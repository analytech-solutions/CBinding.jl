

# the following provides a deferred access mechanism to handle nested aggregate fields (in aggregates or arrays) to support correct/efficient behavior of:
#   a.b[3].c.d = x
#   y = a.b[3].c.d
const Cdeferrable = Union{Caggregate, Carray}
struct Caccessor{FieldType<:Union{Cdeferrable, Cconst{<:Cdeferrable}}, BaseType<:Union{Caggregate, Carray, Ptr{<:Caggregate}, Ptr{<:Carray}, Cconst{<:Caggregate}, Cconst{<:Carray}}, Offset<:Val}
	base::BaseType
	
	Caccessor{FieldType}(b::BaseType, ::Val{Offset} = Val(0)) where {FieldType, BaseType, Offset} = new{FieldType, BaseType, Val{Offset}}(b)
end

Base.convert(::Type{T}, ca::Caccessor{T}) where {T} = ca[]
Base.show(io::IO, ca::Caccessor) = show(io, ca[])

Base.getindex(cc::Caccessor{CC}) where {CC<:Cconst{<:Cdeferrable}} = Cconst{nonconst(CC)}(_bytes(cc))
Base.getindex(ca::Caccessor{CD}) where {CD<:Cdeferrable} = unsafe_load(_pointer(ca))
Base.setindex!(ca::Caccessor{CD}, val::CD) where {CD<:Cdeferrable} = unsafe_store!(_pointer(ca), val)

# Caggregate interface
const Caggregates = Union{CA, Cconst{CA}, Caccessor{CA}, Caccessor{<:Cconst{CA}}} where {CA<:Caggregate}
Base.propertynames(ca::CA; kwargs...) where {CA<:Caggregates} = propertynames(typeof(ca); kwargs...)
Base.propertynames(::Type{CA}; kwargs...) where {CA<:Caggregates} = map(((sym, fld),) -> sym, (sort(collect(Ctypelayout(_fieldtype(CA)).fields), by = ((sym, fld),) -> fld.ind)...,))

propertytypes(ca::CA; kwargs...) where {CA<:Caggregates} = propertytypes(typeof(ca); kwargs...)
propertytypes(::Type{CA}; kwargs...) where {CA<:Caggregates} = map(((sym, fld),) -> fld.type, (sort(collect(Ctypelayout(_fieldtype(CA)).fields), by = ((sym, fld),) -> fld.ind)...,))

Base.fieldnames(ca::CA; kwargs...) where {CA<:Caggregates} = fieldnames(typeof(ca); kwargs...)
Base.fieldnames(::Type{CA}; kwargs...) where {CA<:Caggregates} = propertynames(_fieldtype(CA); kwargs...)

Base.getproperty(cx::CX, sym::Symbol) where {CA<:Caggregates, CX<:Union{CA, Caccessor{CA}}} = _getproperty(_base(cx), Val(_fieldoffset(cx)), Ctypespec(_fieldtype(cx)), Val(sym))
Base.setproperty!(cx::CX, sym::Symbol, val) where {CA<:Caggregate, CX<:Union{CA, Caccessor{CA}}} = _setproperty!(_base(cx), Val(_fieldoffset(cx)), Ctypespec(_fieldtype(cx)), Val(sym), val)

# Carray interface
const Carrays = Union{CA, Cconst{CA}, Caccessor{CA}, Caccessor{<:Cconst{CA}}} where {CA<:Carray}
Base.getindex(ca::CA, ind) where {T<:Cdeferrable, N, _CA<:Carray{T, N}, CA<:Carrays{_CA}} = Caccessor{T}(_base(ca), Val(_fieldoffset(ca) + (ind-1)*sizeof(T)))
Base.getindex(ca::CA, ind) where {T, N, _CA<:Carray{T, N}, CA<:Carrays{_CA}} = unsafe_load(reinterpret(Ptr{T}, _pointer(ca)), ind)
Base.setindex!(ca::CA, val, ind) where {T, N, _CA<:Carray{T, N}, CA<:Carrays{_CA}} = unsafe_store!(reinterpret(Ptr{T}, _pointer(ca)), val, ind)

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

_pointer(ptr::Ptr) = ptr
_pointer(cx::Union{Caggregate, Carray}) = reinterpret(Ptr{typeof(cx)}, pointer_from_objref(cx))
_pointer(ca::Caccessor) = reinterpret(Ptr{_fieldtype(ca)}, _pointer(_base(ca)) + _fieldoffset(ca))


_uint(::Type{T}) where {T} = sizeof(T) == sizeof(UInt8) ? UInt8 : sizeof(T) == sizeof(UInt16) ? UInt16 : sizeof(T) == sizeof(UInt32) ? UInt32 : sizeof(T) == sizeof(UInt64) ? UInt64 : sizeof(T) == sizeof(UInt128) ? UInt128 : error("Unable to create a UInt of $(sizeof(T)*8) bits")

function _bitmask(::Type{uint}, bits::Int) where {uint}
	mask = zero(uint)
	for i in 1:bits
		mask = (mask << one(uint)) | one(uint)
	end
	return uint(mask)
end

_readbyte(::Type{T}, base, ind) where {T<:Cconst} = :(getfield($(base), :mem)[$(ind)])
_readbyte(::Type{T}, base, ind) where {T<:Ptr} = :(unsafe_load(reinterpret(Ptr{UInt8}, $(base)), $(ind)))
_writebyte(::Type{T}, base, ind, val) where {T<:Ptr} = :(unsafe_store!(reinterpret(Ptr{UInt8}, $(base)), $(val), $(ind)))

_bytes(ca::Caccessor) = _bytes(_base(ca), Val(_fieldoffset(ca)), Val(sizeof(_fieldtype(ca))))
_bytes(cd::Cdeferrable, ::Val{offset}, ::Val{size}) where {offset, size} = _bytes(pointer_from_objref(cd), Val(offset), Val(size))
@generated function _bytes(base::Union{Cconst, Ptr}, ::Val{offset}, ::Val{size}) where {offset, size}
	return :($(map(ind -> _readbyte(base, :base, ind), offset+1:offset+size)...),)
end


@generated function _unsafe_load(base::Union{Cconst, Ptr}, ::Val{offset}, ::Type{uint}, ::Val{offbits}, ::Val{numbits}) where {offset, uint, offbits, numbits}
	sym = gensym("bitfield")
	result = [:($(sym) = uint(0))]
	for i in 1:sizeof(uint)
		todo"verify correctness on big endian machine"  #$((ENDIAN_BOM != 0x04030201 ? (sizeof(uint)-i) : (i-1))*8)
		offbits <= i*8 && (i-1)*8 < offbits+numbits && push!(result, :($(sym) |= uint($(_readbyte(base, :base, offset+i))) << uint($((i-1)*8))))
	end
	return quote let ; $(result...) ; $(sym) end end
end

@generated function _unsafe_store!(base::Ptr, ::Val{offset}, ::Type{uint}, ::Val{offbits}, ::Val{numbits}, val::uint) where {offset, uint, offbits, numbits}
	result = []
	for i in 1:sizeof(uint)
		todo"verify correctness on big endian machine"  #$((ENDIAN_BOM != 0x04030201 ? (sizeof(uint)-i) : (i-1))*8)
		offbits <= i*8 && (i-1)*8 < offbits+numbits && push!(result, _writebyte(base, :base, offset+i, :(UInt8((val >> $((i-1)*8)) & 0xff))))
	end
	return quote $(result...) end
end



@generated function _getproperty(base::Union{CA, Cconst{CA}, Ptr{CA}}, ::Val{offset}, ::Type{spec}, ::Val{name}) where {CA<:Caggregate, offset, spec<:Ctypespec, name}
	mem = base <: CA ? :(pointer_from_objref(base)) : :(base)
	
	fields = Ctypelayout(spec).fields
	if haskey(fields, name)
		typ = fields[name].type
		bits = fields[name].size
		off = fields[name].offset + offset*8
		
		if typ <: Union{Cdeferrable, Cconst{<:Cdeferrable}}
			return :(Caccessor{$(base <: Cconst || _type(spec) <: Cconst ? Cconst(typ) : typ)}(base, Val($(off÷8))))
		else
			t = nonconst(typ)
			o = off & (8-1)
			b = iszero(bits) ? sizeof(t)*8 : bits
			uint = _uint(t)
			mask = _bitmask(uint, b)
			return quote
				val = _unsafe_load($(mem), Val($(off÷8)), $(uint), Val($(o)), Val($(b)))
				if $(!iszero(bits))
					val = (val >> $(uint)($(o))) & $(uint)($(mask))
					if $(t) <: Signed && ((val >> $(b-1)) & 1) != 0  # 0 = pos, 1 = neg
						val |= ~$(uint)(0) & ~$(uint)($(mask))
					end
				end
				return reinterpret($(t), val)
			end
		end
	end
	return :(error("Unable to get property `$(name)`, it is not a field of $(typeof(base))"))
end


@generated function _setproperty!(base::Union{CA, Ptr{CA}}, ::Val{offset}, ::Type{spec}, ::Val{name}, val) where {CA<:Caggregate, offset, spec<:Ctypespec, name}
	mem = base <: CA ? :(pointer_from_objref(base)) : :(base)
	
	fields = Ctypelayout(spec).fields
	if haskey(fields, name)
		typ = fields[name].type
		bits = fields[name].size
		off = fields[name].offset + offset*8
		
		typ <: Cconst && error("Unable to change the value of a Cconst field")
		
		if typ <: Carray
			return quote
				arr = Caccessor{$(typ)}(base, Val($(off÷8)))
				length(val) == length(arr) || error("Length of value does not match the length of the array field it is being assigned to")
				for (i, v) in enumerate(val)
					arr[i] = v
				end
				return val
			end
		elseif !iszero(bits)
			o = off & (8-1)
			b = iszero(bits) ? sizeof(typ)*8 : bits
			uint = _uint(typ)
			mask = _bitmask(uint, b) << o
			return quote
				field = _unsafe_load($(mem), Val($(off÷8)), $(uint), Val($(o)), Val($(b)))
				field &= ~$(uint)($(mask))
				field |= (reinterpret($(uint), convert($(typ), val)) << $(o)) & $(uint)($(mask))
				_unsafe_store!($(mem), Val($(off÷8)), $(uint), Val($(o)), Val($(b)), field)
				return val
			end
		else
			return quote
				unsafe_store!(reinterpret(Ptr{$(typ)}, $(mem) + $(off÷8)), val)
				return val
			end
		end
	end
	return :(error("Unable to set property `$(name)`, it is not a field of $(typeof(base))"))
end

