

# <:Caggregate functions
function (::Type{CA})(cc::Cconst{CA}) where {CA<:Caggregate}
	result = CA(undef)
	setfield!(result, :mem, getfield(cc, :mem))
	return result
end

function (::Type{CA})(; kwargs...) where {CA<:Caggregate}
	result = CA(undef)
	if isempty(kwargs)
		setfield!(result, :mem, map(zero, getfield(result, :mem)))
	else
		CA <: Cunion && length(kwargs) > 1 && error("Expected only a single keyword argument when constructing Cunion's")
		foreach(kwarg -> setproperty!(result, kwarg...), kwargs)
	end
	return result
end

Base.convert(::Type{CA}, nt::NamedTuple) where {CA<:Caggregate} = CA(; nt...)
Base.isequal(x::CA, y::CA) where {CA<:Caggregate} = getfield(x, :mem) == getfield(y, :mem)
Base.:(==)(x::CA, y::CA) where {CA<:Caggregate} = isequal(x, y)

isanonymous(ca::Caggregate) = isanonymous(typeof(ca))
isanonymous(::Type{CA}) where {CA<:Caggregate} = match(r"^##anonymous#\d+$", string(CA.name.name)) !== nothing

Base.show(io::IO, ::Type{CS}) where {CS<:Cstruct} = print(io, isanonymous(CS) ? "<anonymous-struct" : string(CS.name))
Base.show(io::IO, ::Type{CU}) where {CU<:Cunion}  = print(io, isanonymous(CU) ? "<anonymous-union" : string(CU.name))

function Base.show(io::IO, ca::Union{Caggregate, Cconst{<:Caggregate}})
	if !(ca isa get(io, :typeinfo, Nothing))
		if ca isa Cconst
			print(io, typeof(ca).name, "(")
			show(io, nonconst(typeof(ca)))
		else
			show(io, typeof(ca))
		end
	end
	print(io, "(")
	for (ind, name) in enumerate(propertynames(typeof(ca)))
		print(io, ind > 1 ? ", " : "")
		print(io, name, "=")
		show(io, getproperty(ca, name))
	end
	print(io, ")")
	if !(ca isa get(io, :typeinfo, Nothing))
		ca isa Cconst && print(io, ")")
	end
end



const _alignExprs = (Symbol("@calign"), :(CBinding.$(Symbol("@calign"))))
const _enumExprs = (Symbol("@cenum"), :(CBinding.$(Symbol("@cenum"))))
const _arrayExprs = (Symbol("@carray"), :(CBinding.$(Symbol("@carray"))))
const _structExprs = (Symbol("@cstruct"), :(CBinding.$(Symbol("@cstruct"))))
const _unionExprs = (Symbol("@cunion"), :(CBinding.$(Symbol("@cunion"))))
const _externExprs = (Symbol("@cextern"), :(CBinding.$(Symbol("@cextern"))))

# macros need to accumulate definition of sub-structs/unions and define them above the expansion of the macro itself
_expand(mod::Module, deps::Vector{Pair{Symbol, Expr}}, x, escape::Bool = true) = escape ? esc(x) : x
function _expand(mod::Module, deps::Vector{Pair{Symbol, Expr}}, e::Expr, escape::Bool = true)
	if Base.is_expr(e, :macrocall)
		if length(e.args) > 1 && e.args[1] in (_alignExprs..., _enumExprs..., _arrayExprs..., _structExprs..., _unionExprs...)
			if e.args[1] in _alignExprs
				return _calign(mod, deps, filter(x -> !(x isa LineNumberNode), e.args[2:end])...)
			elseif e.args[1] in _enumExprs
				return _cenum(mod, deps, filter(x -> !(x isa LineNumberNode), e.args[2:end])...)
			elseif e.args[1] in _arrayExprs
				return _carray(mod, deps, filter(x -> !(x isa LineNumberNode), e.args[2:end])...)
			elseif e.args[1] in _structExprs
				return _caggregate(mod, deps, :cstruct, filter(x -> !(x isa LineNumberNode), e.args[2:end])...)
			elseif e.args[1] in _unionExprs
				return _caggregate(mod, deps, :cunion, filter(x -> !(x isa LineNumberNode), e.args[2:end])...)
			end
		else
			return _expand(mod, deps, macroexpand(mod, e, recursive = false))
		end
	elseif Base.is_expr(e, :ref, 2)
		return _carray(mod, deps, e)
	else
		for i in eachindex(e.args)
			e.args[i] = _expand(mod, deps, e.args[i], escape)
		end
		return e
	end
end



macro calign(exprs...) return _calign(__module__, nothing, exprs...) end

function _calign(mod::Module, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing}, expr::Union{Integer, Expr})
	isOuter = isnothing(deps)
	deps = isOuter ? Pair{Symbol, Expr}[] : deps
	def = Expr(:align, _expand(mod, deps, expr))
	
	return isOuter ? quote $(map(last, deps)...) ; $(def) end : def
end



macro ctypedef(exprs...) return _ctypedef(__module__, nothing, exprs...) end

function _ctypedef(mod::Module, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing}, name::Symbol, expr::Union{Symbol, Expr})
	escName = esc(name)
	
	isOuter = isnothing(deps)
	deps = isOuter ? Pair{Symbol, Expr}[] : deps
	expr = _expand(mod, deps, expr)
	push!(deps, name => quote
		const $(escName) = $(expr)
	end)
	
	return isOuter ? quote $(map(last, deps)...) ; $(escName) end : escName
end



macro cstruct(exprs...) return _caggregate(__module__, nothing, :cstruct, exprs...) end
macro cunion(exprs...) return _caggregate(__module__, nothing, :cunion, exprs...) end

function _caggregate(mod::Module, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing}, kind::Symbol, name::Symbol)
	return _caggregate(mod, deps, kind, name, nothing, nothing)
end

function _caggregate(mod::Module, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing}, kind::Symbol, body::Expr)
	return _caggregate(mod, deps, kind, nothing, body, nothing)
end

function _caggregate(mod::Module, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing}, kind::Symbol, body::Expr, strategy::Symbol)
	return _caggregate(mod, deps, kind, nothing, body, strategy)
end

function _caggregate(mod::Module, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing}, kind::Symbol, name::Union{Symbol, Nothing}, body::Union{Expr, Nothing})
	return _caggregate(mod, deps, kind, name, body, nothing)
end

todo"need to handle unknown-length aggregates with last field like `char c[]`"
function _caggregate(mod::Module, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing}, kind::Symbol, name::Union{Symbol, Nothing}, body::Union{Expr, Nothing}, strategy::Union{Symbol, Nothing})
	isnothing(body) || Base.is_expr(body, :braces) || Base.is_expr(body, :bracescat) || error("Expected @$(kind) to have a `{ ... }` expression for the body of the type, but found `$(body)`")
	isnothing(body) && !isnothing(strategy) && error("Expected @$(kind) to have a body if alignment strategy is to be specified")
	isnothing(strategy) || (startswith(String(strategy), "__") && endswith(String(strategy), "__") && length(String(strategy)) > 4) || error("Expected @$(kind) to have packing specified as `__STRATEGY__`, such as `__packed__` or `__native__`")
	
	strategy = isnothing(strategy) ? :(CBinding.ALIGN_NATIVE) : :(Calignment{$(QuoteNode(Symbol(String(strategy)[3:end-2])))})
	name = isnothing(name) ? gensym("anonymous") : name
	escName = esc(name)
	
	isOuter = isnothing(deps)
	deps = isOuter ? Pair{Symbol, Expr}[] : deps
	if isnothing(body)
		push!(deps, name => quote
			mutable struct $(escName) <: $(kind === :cunion ? :(Cunion) : :(Cstruct))
				let constructor = false end
			end
		end)
	else
		super = kind === :cunion ? :(Cunion) : :(Cstruct)
		fields = []
		for arg in body.args
			arg = _expand(mod, deps, arg)
			if Base.is_expr(arg, :align, 1)
				align = arg.args[1]
				push!(fields, :(Calignment{$(align)}))
			elseif Base.is_expr(arg, :escape, 1) && !startswith(String(arg.args[1]), "##anonymous#")
				# this is just a type definition, not a field
			else
				Base.is_expr(arg, :(::)) && length(arg.args) != 2 && error("Expected @$(kind) to have a `fieldName::FieldType` expression in the body of the type, but found `$(arg)`")
				
				argType = Base.is_expr(arg, :(::)) ? arg.args[end] : arg
				args = !Base.is_expr(arg, :(::)) ? nothing : arg.args[1]
				args = Base.is_expr(args, :tuple) ? args.args : (args,)
				for arg in args
					if isnothing(arg)
						push!(fields, :(Ctypespec($(argType))))
					elseif arg isa Symbol
						push!(fields, :(Pair{$(QuoteNode(arg)), Ctypespec($(argType))}))
					elseif Base.is_expr(arg, :escape, 1) && isnothing(arg.args[1])
						push!(fields, :(Ctypespec($(argType))))
					elseif Base.is_expr(arg, :escape, 1) && arg.args[1] isa Symbol
						push!(fields, :(Pair{$(QuoteNode(arg.args[1])), Ctypespec($(argType))}))
					elseif Base.is_expr(arg, :call, 3) && arg.args[1] === :(:) && arg.args[3] isa Integer
						push!(fields, :(Pair{$(QuoteNode(arg.args[2])), Ctypespec($(argType), Val($(arg.args[3])))}))
					elseif Base.is_expr(arg, :call, 3) && Base.is_expr(arg.args[1], :escape, 1) && arg.args[1].args[1] === :(:) && Base.is_expr(arg.args[3], :escape, 1) && arg.args[3].args[1] isa Integer
						push!(fields, :(Pair{$(QuoteNode(arg.args[2].args[1])), Ctypespec($(argType), Val($(arg.args[3].args[1])))}))
					else
						function _parseAugmentedField(a)
							a = deepcopy(a)
							if Base.is_expr(a, :(::), 2)
								(aname, atype) = _parseAugmentedField(a.args[2])
								isnothing(aname) || error("Unable to parse @$(kind) field, unexpected expression `$(a)`")
								return (Base.is_expr(a.args[1], :escape, 1) && a.args[1].args[1] isa Symbol ? a.args[1].args[1] : a.args[1], atype)
							elseif Base.is_expr(a, :curly) && length(a.args) >= 3 && a.args[1] in (:Carray, esc(:Carray), :(CBinding.Carray), Expr(:., esc(:CBinding), esc(QuoteNode(:Carray))))
								(aname, atype) = _parseAugmentedField(a.args[2])
								isnothing(aname) || error("Unable to parse @$(kind) field, unexpected expression `$(a)`")
								a.args[2] = atype
								if length(a.args) == 4 && Base.is_expr(a.args[4], :call, 2) && a.args[4].args[1] === :sizeof
									(aname, atype) = _parseAugmentedField(a.args[4].args[2])
									isnothing(aname) || error("Unable to parse @$(kind) field, unexpected expression `$(a)`")
									a.args[4].args[2] = atype
								end
								return (nothing, a)
							elseif Base.is_expr(a, :curly) && length(a.args) >= 1 && a.args[1] in (:Ptr, esc(:Ptr), :(Base.Ptr), Expr(:., esc(:Base), esc(QuoteNode(:Ptr))))
								if length(a.args) == 1
									push!(a.args, argType)
								else
									(aname, atype) = _parseAugmentedField(a.args[end])
									isnothing(aname) || error("Unable to parse @$(kind) field, unexpected expression `$(a)`")
									a.args[end] = atype
								end
								return (nothing, a)
							elseif Base.is_expr(a, :braces, 0)
								return (nothing, argType)
							else
								error("Expected @$(kind) to have a `fieldName`, `fieldName::Ptr{}`, or `fieldName::{}[N]` field name expression or some combination of them, but found `$(a)` within `$(arg)`")
							end
						end
						
						(aname, atype) = _parseAugmentedField(arg)
						push!(fields, :(Pair{$(QuoteNode(aname)), Ctypespec($(atype))}))
					end
				end
			end
		end
		
		_stripPtrTypes(x) = x
		function _stripPtrTypes(e::Expr)
			if Base.is_expr(e, :curly, 2) && e.args[1] in (:Ptr, esc(:Ptr), :(Base.Ptr), Expr(:., esc(:Base), esc(QuoteNode(:Ptr))))
				e.args[2] = :Cvoid
				return e
			end
			e.args = map(_stripPtrTypes, e.args)
			return e
		end
		
		push!(deps, name => quote
			mutable struct $(escName) <: $(super)
				mem::NTuple{Ctypelayout(Ctypespec($(super), $(strategy), Tuple{$(map(_stripPtrTypes, deepcopy(fields))...)})).size÷8, UInt8}
				
				$(escName)(::UndefInitializer) = new()
			end
			#=
				TypeSpec = Tuple{
					Pair{:sym1, Tuple{PrimType}},  # primitive field `sym1`
					Pair{:sym2, Tuple{PrimType, NBits}},  # bit field `sym2`
					Pair{:sym3, Ctypespec{FieldType, AggType, AggStrategy, AggTypeSpec}}},  # nested aggregate `sym3`
					Pair{nothing, Ctypespec{FieldType, AggType, AggStrategy, AggTypeSpec}}},  # anonymous nested aggregate
					Calignment{align}  # alignment "field"
				}
			=#
			CBinding._strategy(::Type{$(escName)}) = $(strategy)
			CBinding._specification(::Type{$(escName)}) = Tuple{$(fields...)}
		end)
	end
	
	return isOuter ? quote $(map(last, deps)...) ; $(escName) end : escName
end



macro carray(exprs...) _carray(__module__, nothing, exprs...) end

function _carray(mod::Module, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing}, expr::Expr)
	Base.is_expr(expr, :ref, 2) || error("Expected C array definition to be of the form `ElementType[N]`")
	
	isOuter = isnothing(deps)
	deps = isOuter ? Pair{Symbol, Expr}[] : deps
	expr.args[1] = _expand(mod, deps, expr.args[1])
	expr.args[2] = _expand(mod, deps, expr.args[2])
	def = :(Carray{$(expr.args[1]), $(expr.args[2]), sizeof(Carray{$(expr.args[1]), $(expr.args[2])})})
	
	return isOuter ? quote $(map(last, deps)...) ; $(def) end : def
end

