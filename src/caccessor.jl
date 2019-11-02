

# the following provides a deferred access mechanism to handle nested aggregate fields (in aggregates or arrays) to support correct/efficient behavior of:
#   a.b[3].c.d = x
#   y = a.b[3].c.d
const Cdeferrable = Union{Caggregate, Carray}
struct Caccessor{FieldType<:Union{Cdeferrable, Cconst}, BaseType<:Union{Caggregate, Carray, Ptr{<:Caggregate}, Ptr{<:Carray}}, Offset<:Val}
	base::BaseType
	
	Caccessor{FieldType}(b::BaseType, ::Val{Offset} = Val(0)) where {FieldType, BaseType, Offset} = new{FieldType, BaseType, Val{Offset}}(b)
end
Caccessor{T}(sym::Symbol, libs::Clibrary...) where {T<:Cdeferrable} = Caccessor{T}(reinterpret(Ptr{T}, _dlsym(sym, libs...)))
Caccessor{T}(lib::Clibrary, sym::Symbol) where {T<:Cdeferrable} = Caccessor{T}(sym, lib)
Caccessor{T}(args...) where {T<:Cconst} = Cconst(Caccessor{nonconst(T)}(args...)[])

_fieldoffset(cx::Union{Cdeferrable, Cconst, Caccessor}) = _fieldoffset(typeof(cx))
_fieldoffset(::Type{CD}) where {CD<:Cdeferrable} = 0
_fieldoffset(::Type{CC}) where {T, CC<:Cconst{T}} = _fieldoffset(T)
_fieldoffset(::Type{Caccessor{FieldType, BaseType, Val{Offset}}}) where {FieldType, BaseType, Offset} = Offset

_fieldtype(cx::Union{Cdeferrable, Cconst, Caccessor}) = _fieldtype(typeof(cx))
_fieldtype(::Type{CD}) where {CD<:Cdeferrable} = CD
_fieldtype(::Type{CC}) where {T, CC<:Cconst{T}} = _fieldtype(T)
_fieldtype(::Type{Caccessor{FieldType, BaseType, Val{Offset}}}) where {FieldType, BaseType, Offset} = FieldType

_base(cx::Union{Cdeferrable, Cconst}) = cx
_base(ca::Caccessor) = getfield(ca, :base)

Base.convert(::Type{CD}, ca::Caccessor{CD}) where {CD<:Cdeferrable} = ca[]
Base.show(io::IO, ca::Caccessor{CD}) where {CD<:Cdeferrable} = show(io, ca[])

Base.pointer_from_objref(ca::Caccessor{FieldType, BaseType, Offset}) where {FieldType, BaseType<:Ptr, Offset} = reinterpret(Ptr{_fieldtype(ca)}, _base(ca)+_fieldoffset(ca))
Base.pointer_from_objref(ca::Caccessor{FieldType, BaseType, Offset}) where {FieldType, BaseType<:Union{Caggregate, Carray}, Offset} = reinterpret(Ptr{_fieldtype(ca)}, pointer_from_objref(_base(ca))+_fieldoffset(ca))

Base.getindex(ca::Caccessor{CA}) where {CA<:Cdeferrable} = unsafe_load(pointer_from_objref(ca))
Base.setindex!(ca::Caccessor{CA}, val::CA) where {CA<:Cdeferrable} = unsafe_store!(pointer_from_objref(ca), val)

# Caggregate interface
const Caggregates = Union{CA, Cconst{CA}, Caccessor{CA}, Caccessor{Cconst{CA}}} where {CA<:Caggregate}
Base.propertynames(ca::CA; kwargs...) where {CA<:Caggregates} = propertynames(typeof(ca); kwargs...)
Base.propertynames(::Type{CA}; kwargs...) where {CA<:Caggregates} = map(((sym, typ, off),) -> sym, _computefields(_fieldtype(CA)))

Base.fieldnames(ca::CA; kwargs...) where {CA<:Caggregates} = fieldnames(typeof(ca); kwargs...)
Base.fieldnames(::Type{CA}; kwargs...) where {CA<:Caggregates} = propertynames(_fieldtype(CA); kwargs...)

propertytypes(ca::CA; kwargs...) where {CA<:Caggregates} = propertytypes(typeof(ca); kwargs...)
propertytypes(::Type{CA}; kwargs...) where {CA<:Caggregates} = map(((sym, typ, off),) -> typ isa Tuple ? first(typ) : typ, _computefields(_fieldtype(CA)))

Base.getproperty(ca::CA, sym::Symbol) where {CA<:Caggregates} = _getproperty(_base(ca), Val{_fieldoffset(ca)}, _strategy(_fieldtype(ca)), Val{_fieldtype(ca) <: Cunion}, _typespec(_fieldtype(ca)), Val{sym})
Base.setproperty!(ca::CA, sym::Symbol, val) where {CA<:Caggregates} = _setproperty!(_base(ca), Val{_fieldoffset(ca)}, _strategy(_fieldtype(ca)), Val{_fieldtype(ca) <: Cunion}, _typespec(_fieldtype(ca)), Val{sym}, val)

# AbstractArray interface
const Carrays = Union{CA, Cconst{CA}, Caccessor{CA}, Caccessor{Cconst{CA}}} where {CA<:Carray}
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


_uintize(::Type{T}) where {T} = sizeof(T) == sizeof(UInt8) ? UInt8 : sizeof(T) == sizeof(UInt16) ? UInt16 : sizeof(T) == sizeof(UInt32) ? UInt32 : sizeof(T) == sizeof(UInt64) ? UInt64 : sizeof(T) == sizeof(UInt128) ? UInt128 : error("Unable to create a UInt of $(sizeof(T)*8) bits")

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

@generated function _getproperty(ca::Union{CA, Ptr{CA}}, ::Type{Val{Offset}}, ::Type{AlignStrategy}, ::Type{Val{IsUnion}}, ::Type{TypeSpec}, ::Type{Val{FieldName}}) where {CA<:Caggregate, Offset, AlignStrategy, IsUnion, TypeSpec<:Tuple, FieldName}
	for (nam, typ, off) in _computefields(AlignStrategy, Val{IsUnion}, TypeSpec)
		nam === FieldName || continue
		off += Offset
		
		if typ isa Tuple
			return quote
				(t, b) = $(typ)
				ityp = sizeof(t) == sizeof(UInt8) ? UInt8 : sizeof(t) == sizeof(UInt16) ? UInt16 : sizeof(t) == sizeof(UInt32) ? UInt32 : sizeof(t) == sizeof(UInt64) ? UInt64 : UInt128
				o = ityp($(off & (8-1)))
				field = _unsafe_load(reinterpret(Ptr{UInt8}, (ca isa Ptr ? ca : pointer_from_objref(ca)) + $(off÷8)), ityp, Val(o), Val(b))
				mask = _bitmask(ityp, Val(b))
				val = (field >> o) & mask
				if t <: Signed && ((val >> (b-1)) & 1) != 0  # 0 = pos, 1 = neg
					val |= ~ityp(0) & ~mask
				end
				return reinterpret((t <: Cconst ? nonconst(t) : t), val)
			end
		elseif typ <: Caggregate || typ <: Carray
			return quote
				return Caccessor{$(typ)}(ca, Val($(off÷8)))
			end
		elseif typ <: Cconst{<:Caggregate} || typ <: Cconst{<:Carray}
			return quote
				return Cconst{nonconst($(typ))}(($(map(i -> :(unsafe_load(reinterpret(Ptr{UInt8}, (ca isa Ptr ? ca : pointer_from_objref(ca))), $(i))), off÷8+1:off÷8+sizeof(typ))...),))
			end
		else
			return quote
				return unsafe_load(reinterpret(Ptr{$(typ) <: Cconst ? nonconst($(typ)) : $(typ)}, (ca isa Ptr ? ca : pointer_from_objref(ca)) + $(off÷8)))
			end
		end
	end
	return quote
		return getfield(ca, $(FieldName))
	end
end

@generated function _setproperty!(ca::Union{CA, Ptr{CA}}, ::Type{Val{Offset}}, ::Type{AlignStrategy}, ::Type{Val{IsUnion}}, ::Type{TypeSpec}, ::Type{Val{FieldName}}, val) where {CA<:Caggregate, Offset, AlignStrategy, IsUnion, TypeSpec<:Tuple, FieldName}
	for (nam, typ, off) in _computefields(AlignStrategy, Val{IsUnion}, TypeSpec)
		nam === FieldName || continue
		off += Offset
		
		if typ isa Tuple
			return quote
				(t, b) = $(typ)
				t <: Cconst && error("Unable to change the value of a Cconst field")
				ityp = sizeof(t) == sizeof(UInt8) ? UInt8 : sizeof(t) == sizeof(UInt16) ? UInt16 : sizeof(t) == sizeof(UInt32) ? UInt32 : sizeof(t) == sizeof(UInt64) ? UInt64 : UInt128
				o = ityp($(off & (8-1)))
				field = _unsafe_load(reinterpret(Ptr{UInt8}, (ca isa Ptr ? ca : pointer_from_objref(ca)) + $(off÷8)), ityp, Val(o), Val(b))
				mask = _bitmask(ityp, Val(b)) << o
				field &= ~mask
				field |= (reinterpret(ityp, convert(t, val)) << o) & mask
				_unsafe_store!(reinterpret(Ptr{UInt8}, (ca isa Ptr ? ca : pointer_from_objref(ca)) + $(off÷8)), ityp, Val(o), Val(b), field)
				return val
			end
		elseif typ <: Carray
			return quote
				$(typ) <: Cconst && error("Unable to change the value of a Cconst field")
				x = Caccessor{$(typ)}(ca, Val($(off÷8)))
				length(val) == length(x) || error("Length of value does not match the length of the array field it is being assigned to")
				for (i, v) in enumerate(val)
					x[i] = v
				end
				return val
			end
		else
			return quote
				$(typ) <: Cconst && error("Unable to change the value of a Cconst field")
				unsafe_store!(reinterpret(Ptr{$(typ)}, (ca isa Ptr ? ca : pointer_from_objref(ca)) + $(off÷8)), val)
				return val
			end
		end
	end
	return quote
		return setfield!(ca, $(FieldName), val)
	end
end


@generated function _extract(mem::NTuple{N, UInt8} where {N}, ::Val{offset}, ::Val{size}) where {offset, size}
	return :($(map(i -> :(mem[$(i)]), offset+1:offset+size)...),)
end

@generated function _unsafe_load(mem::NTuple{N, UInt8} where {N}, ::Val{base}, ::Type{ityp}, ::Val{offset}, ::Val{bits}) where {base, ityp, offset, bits}
	sym = gensym("bitfield")
	result = [:($(sym) = ityp(0))]
	for i in 1:sizeof(ityp)
		todo"verify correctness on big endian machine"  #$((ENDIAN_BOM != 0x04030201 ? (sizeof(ityp)-i) : (i-1))*8)
		offset <= i*8 && (i-1)*8 < offset+bits && push!(result, :($(sym) |= ityp(mem[$(base+i)]) << ityp($((i-1)*8))))
	end
	return quote let ; $(result...) ; $(sym) end end
end

@generated function _getproperty(ca::Cconst{CA}, ::Type{Val{Offset}}, ::Type{AlignStrategy}, ::Type{Val{IsUnion}}, ::Type{TypeSpec}, ::Type{Val{FieldName}}) where {CA<:Caggregate, Offset, AlignStrategy, IsUnion, TypeSpec<:Tuple, FieldName}
	for (nam, typ, off) in _computefields(AlignStrategy, Val{IsUnion}, TypeSpec)
		nam === FieldName || continue
		off += Offset
		
		if typ isa Tuple
			return quote
				(t, b) = $(typ)
				ityp = _uintize(t)
				o = ityp($(off & (8-1)))
				field = _unsafe_load(getfield(ca, :mem), Val($(off÷8)), ityp, Val(o), Val(b))
				mask = _bitmask(ityp, Val(b))
				val = (field >> o) & mask
				if t <: Signed && ((val >> (b-1)) & 1) != 0  # 0 = pos, 1 = neg
					val |= ~ityp(0) & ~mask
				end
				return reinterpret((t <: Cconst ? nonconst(t) : t), val)
			end
		elseif typ <: Caggregate || typ <: Carray || typ <: Cconst{<:Caggregate} || typ <: Cconst{<:Carray}
			return quote
				return Cconst{$(typ)}(_extract(getfield(ca, :mem), Val($(off÷8)), Val($(sizeof(typ)))))
			end
		else
			return quote
				return reinterpret(($(typ) <: Cconst ? nonconst($(typ)) : $(typ)), _unsafe_load(getfield(ca, :mem), Val($(off÷8)), _uintize($(typ)), Val(0), Val(sizeof($(typ))*8)))
			end
		end
	end
	return quote
		return getfield(ca, $(FieldName))
	end
end

function _setproperty!(ca::Cconst{CA}, ::Type{Val{Offset}}, ::Type{AlignStrategy}, ::Type{Val{IsUnion}}, ::Type{TypeSpec}, ::Type{Val{FieldName}}, val) where {CA<:Caggregate, Offset, AlignStrategy, IsUnion, TypeSpec<:Tuple, FieldName}
	setfield!(ca, FieldName, val)
end

