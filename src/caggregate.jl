

const _ANONYMOUS_FIELD = Symbol("")


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

isanonymous(ca::Caggregate) = isanonymous(typeof(ca))
isanonymous(::Type{CA}) where {CA<:Caggregate} = match(r"^##anonymous#\d+$", string(CA.name.name)) !== nothing

function Base.show(io::IO, ::Type{CA}) where {CA<:Caggregate}
	print(io, isanonymous(CA) ? (CA <: Cunion ? "<anonymous-union>" : "<anonymous-struct>") : string(CA.name))
end

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


_strategy(::Type{CA}) where {CA<:Caggregate} = error("Attempted to get alignment strategy for an aggregate without one")
_typespec(::Type{CA}) where {CA<:Caggregate} = error("Attempted to get type specification for an aggregate without one")



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
	
	strategy = isnothing(strategy) ? :(CBinding.ALIGN_NATIVE) : :(Val{$(QuoteNode(Symbol(String(strategy)[3:end-2])))})
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
				push!(fields, :(Pair{nothing, Tuple{$(align)}}))
			elseif Base.is_expr(arg, :escape, 1) && !startswith(String(arg.args[1]), "##anonymous#")
				# this is just a type definition, not a field
			else
				Base.is_expr(arg, :(::)) && (length(arg.args) != 2 || arg.args[1] === _ANONYMOUS_FIELD) && error("Expected @$(kind) to have a `fieldName::FieldType` expression in the body of the type, but found `$(arg)`")
				
				argType = Base.is_expr(arg, :(::)) ? arg.args[end] : arg
				args = Base.is_expr(arg, :(::), 1) || !Base.is_expr(arg, :(::)) ? _ANONYMOUS_FIELD : arg.args[1]
				args = Base.is_expr(args, :tuple) ? args.args : (args,)
				for arg in args
					if arg isa Symbol
						push!(fields, :(Pair{$(QuoteNode(arg)), _isaggregate($(argType)) ? Tuple{$(argType), CBinding._strategy($(argType)), CBinding._typespec($(argType))} : Tuple{$(argType)}}))
					elseif Base.is_expr(arg, :escape, 1) && arg.args[1] isa Symbol
						push!(fields, :(Pair{$(QuoteNode(arg.args[1])), _isaggregate($(argType)) ? Tuple{$(argType), CBinding._strategy($(argType)), CBinding._typespec($(argType))} : Tuple{$(argType)}}))
					elseif Base.is_expr(arg, :call, 3) && arg.args[1] === :(:) && arg.args[3] isa Integer
						push!(fields, :(Pair{$(QuoteNode(arg.args[2])), Tuple{$(argType), $(arg.args[3])}}))
					elseif Base.is_expr(arg, :call, 3) && Base.is_expr(arg.args[1], :escape, 1) && arg.args[1].args[1] === :(:) && Base.is_expr(arg.args[3], :escape, 1) && arg.args[3].args[1] isa Integer
						push!(fields, :(Pair{$(QuoteNode(arg.args[2].args[1])), Tuple{$(argType), $(arg.args[3].args[1])}}))
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
						push!(fields, :(Pair{$(QuoteNode(aname)), _isaggregate($(atype)) ? Tuple{$(atype), CBinding._strategy($(atype)), CBinding._typespec($(atype))} : Tuple{$(atype)}}))
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
				mem::NTuple{_computesize($(strategy), Val{$(super) <: Cunion}, Tuple{$(map(_stripPtrTypes, deepcopy(fields))...)})÷8, UInt8}
				
				$(escName)(::UndefInitializer) = new()
			end
			#=
				TypeSpec = Tuple{
					Pair{:sym1, Tuple{PrimType}},  # primitive field `sym1`
					Pair{:sym2, Tuple{PrimType, NBits}},  # bit field `sym2`
					Pair{:sym3, Tuple{AggType, AggStrategy, AggTypeSpec}},  # nested aggregate `sym3`
					Pair{Symbol(""), Tuple{AggType, AggStrategy, AggTypeSpec}}  # anonymous nested aggregate
				}
			=#
			CBinding._strategy(::Type{$(escName)}) = $(strategy)
			CBinding._typespec(::Type{$(escName)}) = Tuple{$(fields...)}
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



alignof(::Type{ALIGN_PACKED}, ::Type{<:Any}) = 1

alignof(::Type{ALIGN_PACKED}, ::Type{CC}) where {CC<:Cconst} = alignof(ALIGN_PACKED, nonconst(CC))
alignof(::Type{ALIGN_PACKED}, ::Type{CE}) where {CE<:Cenum} = 1
alignof(::Type{ALIGN_PACKED}, ::Type{CA}) where {CA<:Carray} = 1
alignof(::Type{ALIGN_PACKED}, ::Type{CA}) where {CA<:Caggregate} = 1
alignof(::Type{ALIGN_PACKED}, ::Type{AlignStrategy}, ::Type{Val{IsUnion}}, ::Type{TypeSpec}) where {AlignStrategy, IsUnion, TypeSpec<:Tuple} = 1

alignof(::Type{ALIGN_NATIVE}, ::Type{CC}) where {CC<:Cconst} = alignof(ALIGN_NATIVE, nonconst(CC))
alignof(::Type{ALIGN_NATIVE}, ::Type{CE}) where {CE<:Cenum} = alignof(ALIGN_NATIVE, eltype(CE))
alignof(::Type{ALIGN_NATIVE}, ::Type{CA}) where {CA<:Carray} = alignof(ALIGN_NATIVE, eltype(CA))
alignof(::Type{ALIGN_NATIVE}, ::Type{CA}) where {CA<:Caggregate} = _computealign(CA)
alignof(::Type{ALIGN_NATIVE}, ::Type{AlignStrategy}, ::Type{Val{IsUnion}}, ::Type{TypeSpec}) where {AlignStrategy, IsUnion, TypeSpec<:Tuple} = _computealign(AlignStrategy, Val{IsUnion}, TypeSpec)

const (_i8a, _i16a, _i32a, _i64a, _f32a, _f64a) = let
	(i8a, i16a, i32a, i64a, f32a, f64a) = refs = ((Ref{UInt}() for i in 1:6)...,)
	ccall("jl_native_alignment",
		Nothing,
		(Ptr{UInt}, Ptr{UInt}, Ptr{UInt}, Ptr{UInt}, Ptr{UInt}, Ptr{UInt}),
		i8a, i16a, i32a, i64a, f32a, f64a
	)
	(Int(r[]) for r in refs)
end
alignof(::Type{ALIGN_NATIVE}, ::Type{UInt8})   = _i8a
alignof(::Type{ALIGN_NATIVE}, ::Type{UInt16})  = _i16a
alignof(::Type{ALIGN_NATIVE}, ::Type{UInt32})  = _i32a
alignof(::Type{ALIGN_NATIVE}, ::Type{UInt64})  = _i64a
alignof(::Type{ALIGN_NATIVE}, ::Type{Float32}) = _f32a
alignof(::Type{ALIGN_NATIVE}, ::Type{Float64}) = _f64a
alignof(::Type{ALIGN_NATIVE}, ::Type{<:Ptr})   = alignof(ALIGN_NATIVE, sizeof(Ptr{Cvoid}) == sizeof(UInt32) ? UInt32 : UInt64)
alignof(::Type{ALIGN_NATIVE}, ::Type{Cstring}) = alignof(ALIGN_NATIVE, Ptr)
alignof(::Type{ALIGN_NATIVE}, ::Type{S}) where {S<:Signed} = alignof(ALIGN_NATIVE, unsigned(S))
alignof(::Type{ALIGN_NATIVE}, ::Type{UInt128}) = 2*alignof(ALIGN_NATIVE, UInt64)
alignof(::Type{ALIGN_NATIVE}, ::Type{Clongdouble}) = 2*alignof(ALIGN_NATIVE, Cdouble)

function checked_alignof(args...)
	a = alignof(args...)
	a == 0 || a == nextpow(2, a) || error("Alignment must be a power of 2")
	return a
end

padding(::Type{ALIGN_PACKED}, offset::Int, align::Int) = (align%8) == 0 ? padding(ALIGN_NATIVE, offset, align) : 0
padding(::Type{ALIGN_PACKED}, offset::Int, bits::Int, args...) = bits == 0 ? padding(ALIGN_PACKED, offset, checked_alignof(ALIGN_PACKED, args...)*8) : 0

padding(::Type{ALIGN_NATIVE}, offset::Int, align::Int) = -offset & (align - 1)
function padding(::Type{ALIGN_NATIVE}, offset::Int, bits::Int, args...)
	pad = padding(ALIGN_NATIVE, offset, checked_alignof(ALIGN_NATIVE, args...)*8)
	return 0 < bits <= pad ? 0 : pad
end



_isaggregate(::Type{T}) where {T} = false
_isaggregate(::Type{CA}) where {CA<:Caggregate} = true
_isaggregate(::Type{CC}) where {CC<:Cconst} = _isaggregate(nonconst(CC))
_isaggregate(::Type{CA}) where {CA<:Carray} = _isaggregate(eltype(CA))

_computealign(args...) = _computelayout(args...)[1]
_computesize(args...) = _computelayout(args...)[2]
_computefields(args...) = _computelayout(args...)[3]

_computelayout(::Type{CC}) where {CC<:Cconst} = _computelayout(nonconst(CC))
_computelayout(::Type{CA}) where {CA<:Caggregate} = _computelayout(_strategy(CA), Val{CA <: Cunion}, _typespec(CA))
@generated function _computelayout(::Type{AlignStrategy}, ::Type{Val{IsUnion}}, ::Type{TypeSpec}) where {AlignStrategy, IsUnion, TypeSpec<:Tuple}
	op = !IsUnion ? (+) : (max)
	
	align = 1  # in bytes
	size = 0  # in bits
	result = ()  # ((symbol, (type, bits), offset), ...)
	for field in TypeSpec.parameters
		field <: Pair || continue
		(sym, typ) = field.parameters
		bits = 0
		
		typ <: Tuple || continue
		if length(typ.parameters) == 1
			(typ,) = typ.parameters
		elseif length(typ.parameters) == 2
			(typ, bits) = typ.parameters
		elseif length(typ.parameters) == 3
			(typ, typStrat, typSpec) = typ.parameters
			x = typ <: Carray ? eltype(typ) : typ
			x = x <: Cconst ? nonconst(x) : x
			typIsUnion = Val{x <: Cunion}
		end
		
		start = !IsUnion ? size : 0
		if sym === _ANONYMOUS_FIELD && _isaggregate(typ)
			pad = padding(AlignStrategy, start, 0, typStrat, typIsUnion, typSpec)
			offset = op(start, pad)
			result = (result..., map(((s, t, o),) -> (s, t, offset+o), _computefields(typStrat, typIsUnion, typSpec))...)
			align = max(align, checked_alignof(AlignStrategy, typStrat, typIsUnion, typSpec))
			size = op(size, pad + sizeof(typ)*8)
		elseif sym === nothing
			pad = padding(AlignStrategy, start, typ*8)
			align = max(align, typ)
			size = op(size, pad)
		else
			pad = _isaggregate(typ) ? padding(AlignStrategy, start, bits, typStrat, typIsUnion, typSpec) : padding(AlignStrategy, start, bits, typ)
			alignas = _isaggregate(typ) ? checked_alignof(AlignStrategy, typStrat, typIsUnion, typSpec) : checked_alignof(AlignStrategy, typ)
			offset = op(start, pad)
			if sym !== _ANONYMOUS_FIELD
				result = (result..., (sym, (bits == 0 ? typ : (typ, bits)), offset))
			end
			align = max(align, alignas)
			size = op(size, pad + (bits == 0 ? sizeof(typ)*8 : bits))
		end
	end
	
	size += padding(AlignStrategy, size, align*8)
	size += -size & (8-1)  # ensure size is divisible by 8
	
	return (align::Int, size::Int, result)
end


