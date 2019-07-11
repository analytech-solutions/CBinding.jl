

_strategy(::Type{CA}) where {CA<:Caggregate} = error("Attempted to get alignment strategy for an aggregate without one")
_fields(::Type{CA}) where {CA<:Caggregate} = error("Attempted to get fields of an aggregate without any")


function (::Type{CA})(; kwargs...) where (CA<:Caggregate)
	result = CA(undef)
	if isempty(kwargs)
		setfield!(result, :mem, map(zero, getfield(result, :mem)))
	else
		CA <: Cunion && length(kwargs) > 1 && error("Expected only a single keyword argument when constructing Cunion's")
		foreach(kwarg -> setproperty!(result, kwarg...), kwargs)
	end
	return result
end


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

function (::Type{CA})() where (CA<:Carray)
	result = CA(undef)
	setfield!(result, :mem, map(zero, getfield(result, :mem)))
	return result
end

Base.zero(::Type{CA}) where {CA<:Union{Caggregate, Carray}} = CA()
Base.sizeof(::Type{CA}) where {T, N, CA<:Carray{T, N}} = sizeof(T)*N

Base.getindex(ca::Carray{T, N}, ind) where {T, N} = unsafe_load(reinterpret(Ptr{T}, pointer_from_objref(ca)), ind)
Base.setindex!(ca::Carray{T, N}, val, ind) where {T, N} = unsafe_store!(reinterpret(Ptr{T}, pointer_from_objref(ca)), val, ind)
Base.getindex(ca::Carray{CA, N}, ind) where {CA<:Union{Caggregate, Carray}, N} = Caccessor{CA}(ca, (ind-1)*sizeof(CA))
Base.firstindex(ca::Carray{CA, N}) where {CA<:Union{Caggregate, Carray}, N} = 1
Base.lastindex(ca::Carray{CA, N}) where {CA<:Union{Caggregate, Carray}, N} = length(ca)

Base.IndexStyle(::Type{Carray{T, N}}) where {T, N} = IndexLinear()
Base.size(ca::Carray{T, N}) where {T, N} = (N,)
Base.length(ca::Carray{T, N}) where {T, N} = N
Base.eltype(ca::Carray{T, N}) where {T, N} = T
Base.size(::Type{Carray{T, N}}) where {T, N} = (N,)
Base.length(::Type{Carray{T, N}}) where {T, N} = N
Base.eltype(::Type{Carray{T, N}}) where {T, N} = T

Base.keys(ca::Carray{T, N}) where {T, N} = firstindex(ca):lastindex(ca)
Base.values(ca::Carray{T, N}) where {T, N} = iterate(ca)
Base.iterate(ca::Carray{T, N}, state = 1) where {T, N} = state > N ? nothing : (ca[state], state+1)



# Caccessor provides a deferred access mechanism to handle nested aggregate fields (in aggregates or arrays) to support correct/efficient behavior of:
#   a.b[3].c.d = x
#   y = a.b[3].c.d
struct Caccessor{CA<:Union{Caggregate, Carray}}
	base::Union{Caggregate, Carray}
	offset::Int
end

Base.show(io::IO, ca::Caccessor{CA}) where {CA<:Union{Caggregate, Carray}} = show(io, convert(CA, ca))

Caccessor{CA}(ca::Caccessor{<:Union{Caggregate, Carray}}, offset::Int) where {CA<:Union{Caggregate, Carray}} = Caccessor{CA}(getfield(ca, :base), getfield(ca, :offset) + offset)

Base.convert(::Type{CA}, ca::Caccessor{CA}) where {CA<:Union{Caggregate, Carray}} = ca[]
Base.pointer_from_objref(ca::Caccessor) = pointer_from_objref(getfield(ca, :base))+getfield(ca, :offset)

# functions for when accessor refers to an array
Base.getindex(ca::Caccessor{CA}) where {T, N, S, CA<:Carray{T, N, S}} = unsafe_load(reinterpret(Ptr{CA}, pointer_from_objref(ca)))
Base.setindex!(ca::Caccessor{CA}, val::CA) where {T, N, S, CA<:Carray{T, N, S}} = unsafe_store!(reinterpret(Ptr{CA}, pointer_from_objref(ca)), val)
Base.getindex(ca::Caccessor{CA}, ind) where {T, N, CA<:Carray{T, N}} = unsafe_load(reinterpret(Ptr{T}, pointer_from_objref(ca)), ind)
Base.setindex!(ca::Caccessor{CA}, val::T, ind) where {T, N, CA<:Carray{T, N}} = unsafe_store!(reinterpret(Ptr{T}, pointer_from_objref(ca)), val, ind)
Base.getindex(ca::Caccessor{CA}, ind) where {T<:Union{Caggregate, Carray}, N, CA<:Carray{T, N}} = Caccessor{T}(ca, (ind-1)*sizeof(T))
Base.firstindex(ca::Caccessor{CA}) where {T, N, CA<:Carray{T, N}} = 1
Base.lastindex(ca::Caccessor{CA}) where {T, N, CA<:Carray{T, N}} = length(ca)

Base.IndexStyle(::Type{Caccessor{CA}}) where {T, N, CA<:Carray{T, N}} = IndexLinear()
Base.size(ca::Caccessor{CA}) where {T, N, CA<:Carray{T, N}} = (N,)
Base.length(ca::Caccessor{CA}) where {T, N, CA<:Carray{T, N}} = N
Base.eltype(ca::Caccessor{CA}) where {T, N, CA<:Carray{T, N}} = T
Base.size(::Type{Caccessor{CA}}) where {T, N, CA<:Carray{T, N}} = (N,)
Base.length(::Type{Caccessor{CA}}) where {T, N, CA<:Carray{T, N}} = N
Base.eltype(::Type{Caccessor{CA}}) where {T, N, CA<:Carray{T, N}} = T

Base.keys(ca::Caccessor{CA}) where {T, N, CA<:Carray{T, N}} = firstindex(ca):lastindex(ca)
Base.values(ca::Caccessor{CA}) where {T, N, CA<:Carray{T, N}} = iterate(ca)
Base.iterate(ca::Caccessor{CA}, state = 1) where {T, N, CA<:Carray{T, N}} = state > N ? nothing : (ca[state], state+1)

# functions for when accessor refers to an aggregate
Base.getindex(ca::Caccessor{CA}) where {CA<:Caggregate} = unsafe_load(reinterpret(Ptr{CA}, pointer_from_objref(ca)))
Base.setindex!(ca::Caccessor{CA}, val::CA) where {CA<:Caggregate} = unsafe_store!(reinterpret(Ptr{CA}, pointer_from_objref(ca)), val)

Base.propertynames(ca::CA; kwargs...) where {_CA<:Caggregate, CA<:Union{_CA, Caccessor{_CA}}} = propertynames(CA; kwargs...)
Base.propertynames(::Type{CA}; kwargs...) where {_CA<:Caggregate, CA<:Union{_CA, Caccessor{_CA}}} = map(((sym, typ, off),) -> sym, _computelayout(CA))

propertytypes(ca::CA; kwargs...) where {_CA<:Caggregate, CA<:Union{_CA, Caccessor{_CA}}} = propertytypes(CA; kwargs...)
propertytypes(::Type{CA}; kwargs...) where {_CA<:Caggregate, CA<:Union{_CA, Caccessor{_CA}}} = map(((sym, typ, off),) -> typ isa Tuple ? first(typ) : typ, _computelayout(CA))

_strategy(::Type{<:Caccessor{CA}}) where {CA<:Caggregate} = _strategy(CA)
_fields(::Type{<:Caccessor{CA}}) where {CA<:Caggregate} = _fields(CA)

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

function Base.getproperty(ca::Union{CA, Caccessor{CA}}, sym::Symbol) where {CA<:Caggregate}
	for (nam, typ, off) in _computelayout(typeof(ca))
		sym === nam || continue
		
		if typ isa Tuple
			(t, b) = typ
			ityp = sizeof(t) == sizeof(UInt8) ? UInt8 : sizeof(t) == sizeof(UInt16) ? UInt16 : sizeof(t) == sizeof(UInt32) ? UInt32 : sizeof(t) == sizeof(UInt64) ? UInt64 : UInt128
			o = ityp(off & (8-1))
			field = _unsafe_load(reinterpret(Ptr{UInt8}, pointer_from_objref(ca) + off÷8), ityp, Val(o), Val(b))
			mask = _bitmask(ityp, Val(b))
			val = (field >> o) & mask
			if t <: Signed && ((val >> (b-1)) & 1) != 0  # 0 = pos, 1 = neg
				val |= ~ityp(0) & ~mask
			end
			return reinterpret(t, val)
		elseif typ <: Caggregate || typ <: Carray
			return Caccessor{typ}(ca, off÷8)
		else
			return unsafe_load(reinterpret(Ptr{typ}, pointer_from_objref(ca) + off÷8))
		end
	end
	return getfield(ca, sym)
end

function Base.setproperty!(ca::Union{CA, Caccessor{CA}}, sym::Symbol, val) where {CA<:Caggregate}
	for (nam, typ, off) in _computelayout(typeof(ca))
		sym === nam || continue
		
		if typ isa Tuple
			(t, b) = typ
			ityp = sizeof(t) == sizeof(UInt8) ? UInt8 : sizeof(t) == sizeof(UInt16) ? UInt16 : sizeof(t) == sizeof(UInt32) ? UInt32 : sizeof(t) == sizeof(UInt64) ? UInt64 : UInt128
			o = ityp(off & (8-1))
			field = _unsafe_load(reinterpret(Ptr{UInt8}, pointer_from_objref(ca) + off÷8), ityp, Val(o), Val(b))
			mask = _bitmask(ityp, Val(b)) << o
			field &= ~mask
			field |= (reinterpret(ityp, convert(t, val)) << o) & mask
			_unsafe_store!(reinterpret(Ptr{UInt8}, pointer_from_objref(ca) + off÷8), ityp, Val(o), Val(b), field)
		elseif typ <: Carray
			ca = Caccessor{typ}(ca, off÷8)
			length(val) == length(ca) || error("Length of value does not match the length of the array field it is being assigned to")
			for (i, v) in enumerate(val)
				ca[i] = v
			end
		else
			unsafe_store!(reinterpret(Ptr{typ}, pointer_from_objref(ca) + off÷8), val)
		end
		return val
	end
	return setfield!(ca, sym, val)
end



const _alignExprs = (Symbol("@calign"), :(CBinding.$(Symbol("@calign"))))
const _enumExprs = (Symbol("@cenum"), :(CBinding.$(Symbol("@cenum"))))
const _arrayExprs = (Symbol("@carray"), :(CBinding.$(Symbol("@carray"))))
const _structExprs = (Symbol("@cstruct"), :(CBinding.$(Symbol("@cstruct"))))
const _unionExprs = (Symbol("@cunion"), :(CBinding.$(Symbol("@cunion"))))

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
				push!(fields, :(nothing => $(align)))
			elseif Base.is_expr(arg, :escape, 1) && !startswith(String(arg.args[1]), "##anonymous#")
				# this is just a type definition, not a field
			else
				Base.is_expr(arg, :(::)) && (length(arg.args) != 2 || arg.args[1] === :_) && error("Expected @$(kind) to have a `fieldName::FieldType` expression in the body of the type, but found `$(arg)`")
				
				argType = Base.is_expr(arg, :(::)) ? arg.args[end] : arg
				args = Base.is_expr(arg, :(::), 1) || !Base.is_expr(arg, :(::)) ? :_ : arg.args[1]
				args = Base.is_expr(args, :tuple) ? args.args : (args,)
				for arg in args
					if arg isa Symbol
						push!(fields, :($(QuoteNode(arg)) => $(argType)))
					elseif Base.is_expr(arg, :escape, 1) && arg.args[1] isa Symbol
						push!(fields, :($(QuoteNode(arg.args[1])) => $(argType)))
					elseif Base.is_expr(arg, :call, 3) && arg.args[1] === :(:) && arg.args[3] isa Integer
						push!(fields, :($(QuoteNode(arg.args[2])) => ($(argType), $(arg.args[3]))))
					elseif Base.is_expr(arg, :call, 3) && Base.is_expr(arg.args[1], :escape, 1) && arg.args[1].args[1] === :(:) && Base.is_expr(arg.args[3], :escape, 1) && arg.args[3].args[1] isa Integer
						push!(fields, :($(QuoteNode(arg.args[2].args[1])) => ($(argType), $(arg.args[3].args[1]))))
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
						push!(fields, :($(QuoteNode(aname)) => $(atype)))
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
				mem::NTuple{_computelayout($(strategy), $(super), ($(map(_stripPtrTypes, deepcopy(fields))...),), total = true)÷8, UInt8}
				
				$(escName)(::UndefInitializer) = new()
			end
			CBinding._strategy(::Type{$(escName)}) = $(strategy)
			CBinding._fields(::Type{$(escName)}) = ($(fields...),)
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

alignof(::Type{ALIGN_PACKED}, ::Type{CE}) where {_CE<:Cenum, CE<:Union{_CE, Caccessor{_CE}}} = 1
alignof(::Type{ALIGN_PACKED}, ::Type{CA}) where {_CA<:Carray, CA<:Union{_CA, Caccessor{_CA}}} = 1
alignof(::Type{ALIGN_PACKED}, ::Type{CA}) where {_CA<:Caggregate, CA<:Union{_CA, Caccessor{_CA}}} = 1

alignof(::Type{ALIGN_NATIVE}, ::Type{CE}) where {_CE<:Cenum, CE<:Union{_CE, Caccessor{_CE}}} = alignof(ALIGN_NATIVE, eltype(_CE))
alignof(::Type{ALIGN_NATIVE}, ::Type{CA}) where {_CA<:Carray, CA<:Union{_CA, Caccessor{_CA}}} = alignof(ALIGN_NATIVE, eltype(_CA))
alignof(::Type{ALIGN_NATIVE}, ::Type{CA}) where {_CA<:Caggregate, CA<:Union{_CA, Caccessor{_CA}}} = _computelayout(_CA, alignment = true)

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
alignof(::Type{ALIGN_NATIVE}, ::Type{S}) where {S<:Signed} = alignof(ALIGN_NATIVE, unsigned(S))
alignof(::Type{ALIGN_NATIVE}, ::Type{UInt128}) = 2*alignof(ALIGN_NATIVE, UInt64)
alignof(::Type{ALIGN_NATIVE}, ::Type{Clongdouble}) = 2*alignof(ALIGN_NATIVE, Cdouble)

function checked_alignof(x, y)
	a = alignof(x, y)
	a == 0 || a == nextpow(2, a) || error("Alignment must be a power of 2")
	return a
end

padding(::Type{ALIGN_PACKED}, offset::Int, align::Int) = (align%8) == 0 ? padding(ALIGN_NATIVE, offset, align) : 0
padding(::Type{ALIGN_PACKED}, offset::Int, typ::DataType, bits::Int = 0) = bits == 0 ? padding(ALIGN_PACKED, offset, checked_alignof(ALIGN_PACKED, typ)*8) : 0

padding(::Type{ALIGN_NATIVE}, offset::Int, align::Int) = -offset & (align - 1)
function padding(::Type{ALIGN_NATIVE}, offset::Int, typ::DataType, bits::Int = 0)
	pad = padding(ALIGN_NATIVE, offset, checked_alignof(ALIGN_NATIVE, typ)*8)
	return 0 < bits <= pad ? 0 : pad
end

_computelayout(::Type{CA}; kwargs...) where {_CA<:Caggregate, CA<:Union{_CA, Caccessor{_CA}}} = _computelayout(_strategy(CA), CA, _fields(CA); kwargs...)
function _computelayout(strategy::DataType, ::Type{CA}, fields::Tuple; total::Bool = false, alignment::Bool = false) where {_CA<:Caggregate, CA<:Union{_CA, Caccessor{_CA}}}
	op = CA <: Cstruct ? (+) : (max)
	
	align = 1  # in bytes
	size = 0  # in bits
	result = ()  # ((symbol, (type, bits), offset), ...)
	for (sym, typ) in fields
		start = CA <: Cstruct ? size : 0
		if sym === :_ && typ <: Caggregate
			offset = op(start, padding(strategy, start, typ))
			result = (result..., map(((s, t, o),) -> (s, t, offset+o), _computelayout(typ))...)
			align = max(align, checked_alignof(strategy, typ))
			size = op(size, padding(strategy, start, typ) + sizeof(typ)*8)
		elseif isnothing(sym)
			align = max(align, typ)
			size = op(size, padding(strategy, start, typ*8))
		else
			if typ isa Tuple
				(typ, bits) = typ
			else
				bits = 0
			end
			
			offset = op(start, padding(strategy, start, typ, bits))
			if sym !== :_
				result = (result..., (sym, (bits == 0 ? typ : (typ, bits)), offset))
			end
			align = max(align, checked_alignof(strategy, typ))
			size = op(size, padding(strategy, start, typ, bits) + (bits == 0 ? sizeof(typ)*8 : bits))
		end
	end
	
	if alignment
		return align
	end
	
	if total
		size += padding(strategy, size, align*8)
		size += -size & (8-1)  # ensure size is divisible by 8
		return size
	end
	
	return result
end
