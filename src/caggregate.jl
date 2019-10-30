

const _ANONYMOUS_FIELD = Symbol("")


_strategy(::Type{CA}) where {CA<:Caggregate} = error("Attempted to get alignment strategy for an aggregate without one")
_typespec(::Type{CA}) where {CA<:Caggregate} = error("Attempted to get type specification for an aggregate without one")


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

function Base.show(io::IO, ca::Caggregate)
	ca isa get(io, :typeinfo, Nothing) || show(io, typeof(ca))
	print(io, "(")
	for (ind, name) in enumerate(propertynames(typeof(ca)))
		print(io, ind > 1 ? ", " : "")
		print(io, name, "=")
		show(io, getproperty(ca, name))
	end
	print(io, ")")
end



mutable struct Carray{T, N, S} <: AbstractArray{T, 1}
	mem::NTuple{S, UInt8}
	
	Carray{T, N, S}(::UndefInitializer) where {T, N, S} = new{T, N, S}()
end
Carray{T, N}(u::UndefInitializer) where {T, N} = Carray{T, N, sizeof(Carray{T, N})}(u)

function (::Type{CA})() where {CA<:Carray}
	result = CA(undef)
	setfield!(result, :mem, map(zero, getfield(result, :mem)))
	return result
end

Base.zero(::Type{CA}) where {CA<:Union{Caggregate, Carray}} = CA()
Base.sizeof(::Type{CA}) where {T, N, CA<:Carray{T, N}} = sizeof(T)*N




# the following provides a deferred access mechanism to handle nested aggregate fields (in aggregates or arrays) to support correct/efficient behavior of:
#   a.b[3].c.d = x
#   y = a.b[3].c.d
const Cdeferrable = Union{Caggregate, Carray}
struct Caccessor{FieldType<:Cdeferrable, BaseType<:Cdeferrable, Offset<:Val}
	base::BaseType
	
	Caccessor{FieldType}(b::BaseType, ::Val{Offset}) where {FieldType<:Cdeferrable, BaseType<:Cdeferrable, Offset} = new{FieldType, BaseType, Val{Offset}}(b)
end
const Caggregates = Union{CA, Caccessor{CA}} where {CA<:Caggregate}
const Carrays = Union{CA, Caccessor{CA}} where {CA<:Carray}

_fieldoffset(cx::Union{Cdeferrable, Caccessor}) = _fieldoffset(typeof(cx))
_fieldoffset(::Type{CD}) where {CD<:Cdeferrable} = 0
_fieldoffset(::Type{Caccessor{FieldType, BaseType, Val{Offset}}}) where {FieldType, BaseType, Offset} = Offset

_fieldtype(cx::Union{Cdeferrable, Caccessor}) = _fieldtype(typeof(cx))
_fieldtype(::Type{CD}) where {CD<:Cdeferrable} = CD
_fieldtype(::Type{Caccessor{FieldType, BaseType, Val{Offset}}}) where {FieldType, BaseType, Offset} = FieldType

_base(cx::Cdeferrable) = cx
_base(ca::Caccessor) = getfield(ca, :base)

Base.convert(::Type{CD}, ca::Caccessor{CD}) where {CD<:Cdeferrable} = ca[]
Base.show(io::IO, ca::Caccessor{CD}) where {CD<:Cdeferrable} = show(io, ca[])

Base.pointer_from_objref(ca::Caccessor) = reinterpret(Ptr{_fieldtype(ca)}, pointer_from_objref(_base(ca))+_fieldoffset(ca))

Base.getindex(ca::Caccessor{CA}) where {CA<:Cdeferrable} = unsafe_load(pointer_from_objref(ca))
Base.setindex!(ca::Caccessor{CA}, val::CA) where {CA<:Cdeferrable} = unsafe_store!(pointer_from_objref(ca), val)

# Caggregate interface
Base.propertynames(ca::CA; kwargs...) where {CA<:Caggregates} = propertynames(typeof(ca); kwargs...)
Base.propertynames(::Type{CA}; kwargs...) where {CA<:Caggregates} = map(((sym, typ, off),) -> sym, _computefields(_fieldtype(CA)))

Base.fieldnames(ca::CA; kwargs...) where {CA<:Caggregates} = fieldnames(typeof(ca); kwargs...)
Base.fieldnames(::Type{CA}; kwargs...) where {CA<:Caggregates} = propertynames(_fieldtype(CA); kwargs...)

propertytypes(ca::CA; kwargs...) where {CA<:Caggregates} = propertytypes(typeof(ca); kwargs...)
propertytypes(::Type{CA}; kwargs...) where {CA<:Caggregates} = map(((sym, typ, off),) -> typ isa Tuple ? first(typ) : typ, _computefields(_fieldtype(CA)))

Base.getproperty(ca::CA, sym::Symbol) where {CA<:Caggregates} = _getproperty(_base(ca), Val{_fieldoffset(ca)}, _strategy(_fieldtype(ca)), Val{_fieldtype(ca) <: Cunion}, _typespec(_fieldtype(ca)), Val{sym})
Base.setproperty!(ca::CA, sym::Symbol, val) where {CA<:Caggregates} = _setproperty!(_base(ca), Val{_fieldoffset(ca)}, _strategy(_fieldtype(ca)), Val{_fieldtype(ca) <: Cunion}, _typespec(_fieldtype(ca)), Val{sym}, val)

# AbstractArray interface
Base.getindex(ca::CA, ind) where {T<:Cdeferrable, N, _CA<:Carray{T, N}, CA<:Carrays{_CA}} = Caccessor{T}(_base(ca), Val(_fieldoffset(ca) + (ind-1)*sizeof(T)))
Base.getindex(ca::CA, ind) where {T, N, _CA<:Carray{T, N}, CA<:Carrays{_CA}} = unsafe_load(reinterpret(Ptr{T}, pointer_from_objref(ca)), ind)
Base.setindex!(ca::CA, val, ind) where {T, N, _CA<:Carray{T, N}, CA<:Carrays{_CA}} = unsafe_store!(reinterpret(Ptr{T}, pointer_from_objref(ca)), val, ind)

Base.firstindex(ca::CA) where {CA<:Carrays} = 1
Base.lastindex(ca::CA) where {CA<:Carrays} = length(ca)

Base.IndexStyle(::Type{CA}) where {CA<:Carrays} = IndexLinear()
Base.size(ca::CA) where {CA<:Carrays} = size(typeof(ca))
Base.length(ca::CA) where {CA<:Carrays} = length(typeof(ca))
Base.eltype(ca::CA) where {CA<:Carrays} = eltype(typeof(ca))
Base.size(::Type{CA}) where {T, N, _CA<:Carray{T, N}, CA<:Carrays{_CA}} = (N,)
Base.length(::Type{CA}) where {T, N, _CA<:Carray{T, N}, CA<:Carrays{_CA}} = N
Base.eltype(::Type{CA}) where {T, N, _CA<:Carray{T, N}, CA<:Carrays{_CA}} = T

Base.keys(ca::CA) where {CA<:Carrays} = firstindex(ca):lastindex(ca)
Base.values(ca::CA) where {CA<:Carrays} = iterate(ca)
Base.iterate(ca::CA, state = 1) where {CA<:Carrays} = state > length(ca) ? nothing : (ca[state], state+1)



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
						push!(fields, :(Pair{$(QuoteNode(arg)), $(argType) <: CBinding.Caggregate || ($(argType) <: CBinding.Carray && eltype($(argType)) <: CBinding.Caggregate) ? Tuple{$(argType), CBinding._strategy($(argType) <: Carray ? eltype($(argType)) : $(argType)), CBinding._typespec($(argType) <: Carray ? eltype($(argType)) : $(argType))} : Tuple{$(argType)}}))
					elseif Base.is_expr(arg, :escape, 1) && arg.args[1] isa Symbol
						push!(fields, :(Pair{$(QuoteNode(arg.args[1])), $(argType) <: CBinding.Caggregate || ($(argType) <: CBinding.Carray && eltype($(argType)) <: CBinding.Caggregate) ? Tuple{$(argType), CBinding._strategy($(argType) <: Carray ? eltype($(argType)) : $(argType)), CBinding._typespec($(argType) <: Carray ? eltype($(argType)) : $(argType))} : Tuple{$(argType)}}))
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
						push!(fields, :(Pair{$(QuoteNode(aname)), $(atype) <: CBinding.Caggregate || ($(atype) <: CBinding.Carray && eltype($(atype)) <: CBinding.Caggregate) ? Tuple{$(atype), CBinding._strategy($(atype) <: Carray ? eltype($(atype)) : $(atype)), CBinding._typespec($(atype) <: Carray ? eltype($(atype)) : $(atype))} : Tuple{$(atype)}}))
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



# alignment strategies
const ALIGN_NATIVE = Val{:native}
const ALIGN_PACKED = Val{:packed}

alignof(::Type{ALIGN_PACKED}, ::Type{<:Any}) = 1

alignof(::Type{ALIGN_PACKED}, ::Type{CE}) where {CE<:Cenum} = 1
alignof(::Type{ALIGN_PACKED}, ::Type{CA}) where {CA<:Carray} = 1
alignof(::Type{ALIGN_PACKED}, ::Type{CA}) where {CA<:Caggregate} = 1
alignof(::Type{ALIGN_PACKED}, ::Type{AlignStrategy}, ::Type{Val{IsUnion}}, ::Type{TypeSpec}) where {AlignStrategy, IsUnion, TypeSpec<:Tuple} = 1

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



_computealign(args...) = _computelayout(args...)[1]
_computesize(args...) = _computelayout(args...)[2]
_computefields(args...) = _computelayout(args...)[3]

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
			typIsUnion = Val{(typ <: Carray ? eltype(typ) : typ) <: Cunion}
		end
		
		start = !IsUnion ? size : 0
		if sym === _ANONYMOUS_FIELD && typ <: Caggregate
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
			pad = typ <: Caggregate || (typ <: Carray && eltype(typ) <: Caggregate) ? padding(AlignStrategy, start, bits, typStrat, typIsUnion, typSpec) : padding(AlignStrategy, start, bits, typ)
			alignas = typ <: Caggregate || (typ <: Carray && eltype(typ) <: Caggregate) ? checked_alignof(AlignStrategy, typStrat, typIsUnion, typSpec) : checked_alignof(AlignStrategy, typ)
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


@generated function _bitmask(::Type{ityp}, ::Val{bits}) where {ityp, bits}
	mask = zero(ityp)
	for i in 1:bits
		mask = (mask << one(ityp)) | one(ityp)
	end
	return :(ityp($(mask)))
end

@generated function _unsafe_load(base::Ptr{UInt8}, ::Type{ityp}, ::Val{offset}, ::Val{bits}) where {ityp, offset, bits}
	sym = gensym("bitfield")
	result = [:($(sym) = ityp(0))]
	for i in 1:sizeof(ityp)
		todo"verify correctness on big endian machine"  #$((ENDIAN_BOM != 0x04030201 ? (sizeof(ityp)-i) : (i-1))*8)
		offset <= i*8 && (i-1)*8 < offset+bits && push!(result, :($(sym) |= ityp(unsafe_load(base + $(i-1))) << ityp($((i-1)*8))))
	end
	return quote let ; $(result...) ; $(sym) end end
end

@generated function _unsafe_store!(base::Ptr{UInt8}, ::Type{ityp}, ::Val{offset}, ::Val{bits}, val::ityp) where {ityp, offset, bits}
	result = []
	for i in 1:sizeof(ityp)
		todo"verify correctness on big endian machine"  #$((ENDIAN_BOM != 0x04030201 ? (sizeof(ityp)-i) : (i-1))*8)
		offset <= i*8 && (i-1)*8 < offset+bits && push!(result, :(unsafe_store!(base + $(i-1), UInt8((val >> $((i-1)*8)) & 0xff))))
	end
	return quote $(result...) end
end

@generated function _getproperty(ca::CA, ::Type{Val{Offset}}, ::Type{AlignStrategy}, ::Type{Val{IsUnion}}, ::Type{TypeSpec}, ::Type{Val{FieldName}}) where {CA<:Caggregate, Offset, AlignStrategy, IsUnion, TypeSpec<:Tuple, FieldName}
	for (nam, typ, off) in _computefields(AlignStrategy, Val{IsUnion}, TypeSpec)
		nam === FieldName || continue
		off += Offset
		
		return quote
			if $(typ) isa Tuple
				(t, b) = $(typ)
				ityp = sizeof(t) == sizeof(UInt8) ? UInt8 : sizeof(t) == sizeof(UInt16) ? UInt16 : sizeof(t) == sizeof(UInt32) ? UInt32 : sizeof(t) == sizeof(UInt64) ? UInt64 : UInt128
				o = ityp($(off & (8-1)))
				field = _unsafe_load(reinterpret(Ptr{UInt8}, pointer_from_objref(ca) + $(off÷8)), ityp, Val(o), Val(b))
				mask = _bitmask(ityp, Val(b))
				val = (field >> o) & mask
				if t <: Signed && ((val >> (b-1)) & 1) != 0  # 0 = pos, 1 = neg
					val |= ~ityp(0) & ~mask
				end
				return reinterpret(t, val)
			elseif $(typ) <: Caggregate || $(typ) <: Carray
				return Caccessor{$(typ)}(ca, Val($(off÷8)))
			else
				return unsafe_load(reinterpret(Ptr{$(typ)}, pointer_from_objref(ca) + $(off÷8)))
			end
		end
	end
	return quote
		return getfield(ca, $(FieldName))
	end
end

@generated function _setproperty!(ca::CA, ::Type{Val{Offset}}, ::Type{AlignStrategy}, ::Type{Val{IsUnion}}, ::Type{TypeSpec}, ::Type{Val{FieldName}}, val) where {CA<:Caggregate, Offset, AlignStrategy, IsUnion, TypeSpec<:Tuple, FieldName}
	for (nam, typ, off) in _computefields(AlignStrategy, Val{IsUnion}, TypeSpec)
		nam === FieldName || continue
		off += Offset
		
		return quote
			if $(typ) isa Tuple
				(t, b) = $(typ)
				ityp = sizeof(t) == sizeof(UInt8) ? UInt8 : sizeof(t) == sizeof(UInt16) ? UInt16 : sizeof(t) == sizeof(UInt32) ? UInt32 : sizeof(t) == sizeof(UInt64) ? UInt64 : UInt128
				o = ityp($(off & (8-1)))
				field = _unsafe_load(reinterpret(Ptr{UInt8}, pointer_from_objref(ca) + $(off÷8)), ityp, Val(o), Val(b))
				mask = _bitmask(ityp, Val(b)) << o
				field &= ~mask
				field |= (reinterpret(ityp, convert(t, val)) << o) & mask
				_unsafe_store!(reinterpret(Ptr{UInt8}, pointer_from_objref(ca) + $(off÷8)), ityp, Val(o), Val(b), field)
			elseif $(typ) <: Carray
				x = Caccessor{$(typ)}(ca, Val($(off÷8)))
				length(val) == length(x) || error("Length of value does not match the length of the array field it is being assigned to")
				for (i, v) in enumerate(val)
					x[i] = v
				end
			else
				unsafe_store!(reinterpret(Ptr{$(typ)}, pointer_from_objref(ca) + $(off÷8)), val)
			end
			return val
		end
	end
	return quote
		return setfield!(ca, $(FieldName), val)
	end
end

