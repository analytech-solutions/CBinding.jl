

isanonymous(x) = isanonymous(typeof(x))
isanonymous(::Type) = false


abstract type Cstruct_anonymous <: Cstruct end
isanonymous(::Type{<:Cstruct_anonymous}) = true
Base.show(io::IO, ::Type{CS}) where {CS<:Cstruct_anonymous} = print(io, "<anonymous-struct>")

abstract type Cunion_anonymous <: Cunion end
isanonymous(::Type{<:Cunion_anonymous}) = true
Base.show(io::IO, ::Type{CU}) where {CU<:Cunion_anonymous}  = print(io, "<anonymous-union>")


# <:Caggregate functions
function (::Type{CA})(cc::Cconst{CA}) where {CA<:Caggregate}
	T = concrete(CA)
	result = T(undef)
	setfield!(result, :mem, getfield(cc, :mem))
	return result
end

function (::Type{CA})(u::UndefInitializer) where {CA<:Caggregate}
	T = concrete(CA)
	return T(u)
end

function (::Type{CA})(; kwargs...) where {CA<:Caggregate}
	T = concrete(CA)
	result = T(undef)
	if isempty(kwargs)
		setfield!(result, :mem, map(zero, getfield(result, :mem)))
	else
		T <: Cunion && length(kwargs) > 1 && error("Expected only a single keyword argument when constructing Cunion's")
		foreach(kwarg -> _initproperty!(result, kwarg...), kwargs)
	end
	return result
end

Base.zero(::Type{CA}) where {CA<:Caggregate} = CA()
Base.convert(::Type{CA}, nt::NamedTuple) where {CA<:Caggregate} = CA(; nt...)
Base.isequal(x::CA, y::CA) where {CA<:Caggregate} = getfield(x, :mem) == getfield(y, :mem)
Base.:(==)(x::CA, y::CA) where {CA<:Caggregate} = isequal(x, y)

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
	isanon = isnothing(name)
	super = kind === :cunion ? (isanon ? :(Cunion_anonymous) : :(Cunion)) : (isanon ? :(Cstruct_anonymous) : :(Cstruct))
	name = isanon ? gensym("anonymous-$(kind)") : name
	escName = esc(name)
	concreteName = esc(Symbol(name, "\u200B"))  # this is so incredibly evil: appending a 0-width space to the type name
	
	isOuter = isnothing(deps)
	deps = isOuter ? Pair{Symbol, Expr}[] : deps
	if isnothing(body)
		push!(deps, name => quote
			abstract type $(escName) <: $(super) end
		end)
	else
		fields = []
		for arg in body.args
			arg = _expand(mod, deps, arg)
			if Base.is_expr(arg, :align, 1)
				align = arg.args[1]
				push!(fields, :(Calignment{$(align)}))
			elseif Base.is_expr(arg, :escape, 1) && !startswith(String(arg.args[1]), "##anonymous")
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
		
		push!(deps, name => quote
			abstract type $(escName) <: $(super) end
			mutable struct $(concreteName) <: $(escName)
				mem::NTuple{Ctypelayout(Ctypespec($(super), $(strategy), Tuple{$(fields...)})).size÷8, UInt8}
				
				$(concreteName)(::UndefInitializer) = new()
			end
			#=
				TypeSpec = Tuple{
					Pair{:sym1, Tuple{PrimType}},  # primitive field `sym1`
					Pair{:sym2, Tuple{PrimType, NBits}},  # bit field `sym2`
					Pair{:sym3, Ctypespec{FieldType, AggType, AggStrategy, AggTypeSpec}}},  # nested aggregate `sym3`
					Ctypespec{FieldType, AggType, AggStrategy, AggTypeSpec}},  # anonymous nested aggregate
					Calignment{align}  # alignment "field"
				}
			=#
			CBinding.concrete(::Type{$(escName)}) = $(concreteName)
			CBinding.concrete(::Type{$(concreteName)}) = $(concreteName)
			CBinding.strategy(::Type{$(concreteName)}) = $(strategy)
			CBinding.specification(::Type{$(concreteName)})  = Tuple{$(fields...)}
			Base.sizeof(::Type{$(escName)}) = sizeof(CBinding.concrete($(concreteName)))
		end)
	end
	
	return isOuter ? quote $(map(last, deps)...) ; $(escName) end : escName
end

