

enumtypes(::Type{ALIGN_PACKED}) = (UInt8, Int8, UInt16, Int16, UInt32, Int32, UInt64, Int64, UInt128, Int128)

alignof(::Type{ALIGN_PACKED}, ::Type{T}) where {T<:Union{Int8, Int16, Int32, Int64, Int128}} = 1
alignof(::Type{ALIGN_PACKED}, ::Type{T}) where {T<:Union{UInt8, UInt16, UInt32, UInt64, UInt128}} = 1
alignof(::Type{ALIGN_PACKED}, ::Type{T}) where {T<:Union{Cfloat, Cdouble, Clongdouble}} = 1
alignof(::Type{ALIGN_PACKED}, ::Type{T}) where {T<:Union{Ptr, Cstring}} = 1

alignof(::Type{ALIGN_PACKED}, ::Type{CC}) where {CC<:Cconst} = 1
alignof(::Type{ALIGN_PACKED}, ::Type{CE}) where {CE<:Cenum} = 1
alignof(::Type{ALIGN_PACKED}, ::Type{CA}) where {CA<:Carray} = 1
alignof(::Type{ALIGN_PACKED}, ::Type{CA}) where {CA<:Caggregate} = 1
alignof(::Type{ALIGN_PACKED}, ::Type{spec}) where {spec<:Ctypespec{<:Any, <:Caggregate, <:Calignment, <:Tuple}} = 1
alignof(::Type{ALIGN_PACKED}, ::Type{spec}) where {spec<:Ctypespec{<:Any, <:Cenum, <:Calignment, <:Tuple}} = 1


enumtypes(::Type{ALIGN_NATIVE}) = (UInt32, Int32, UInt64, Int64, UInt128, Int128)

alignof(::Type{ALIGN_NATIVE}, ::Type{CC}) where {CC<:Cconst} = alignof(ALIGN_NATIVE, nonconst(CC))
alignof(::Type{ALIGN_NATIVE}, ::Type{CE}) where {CE<:Cenum} = alignof(ALIGN_NATIVE, eltype(CE))
alignof(::Type{ALIGN_NATIVE}, ::Type{CA}) where {CA<:Carray} = alignof(ALIGN_NATIVE, eltype(CA))
alignof(::Type{ALIGN_NATIVE}, ::Type{CA}) where {CA<:Caggregate} = Ctypelayout(CA).align
alignof(::Type{ALIGN_NATIVE}, ::Type{spec}) where {spec<:Ctypespec{<:Any, <:Caggregate, <:Calignment, <:Tuple}} = Ctypelayout(spec).align
alignof(::Type{ALIGN_NATIVE}, ::Type{spec}) where {spec<:Ctypespec{<:Any, <:Cenum, <:Calignment, <:Tuple}} = alignof(ALIGN_NATIVE, Cenumlayout(spec).type)

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


padding(::Type{ALIGN_PACKED}, offset::Int, align::Int) = (align%8) == 0 ? padding(ALIGN_NATIVE, offset, align) : 0
padding(::Type{ALIGN_PACKED}, offset::Int, bits::Int, typ) = bits == 0 ? padding(ALIGN_PACKED, offset, checked_alignof(ALIGN_PACKED, typ)*8) : 0

padding(::Type{ALIGN_NATIVE}, offset::Int, align::Int) = -offset & (align - 1)
function padding(::Type{ALIGN_NATIVE}, offset::Int, bits::Int, typ)
	pad = padding(ALIGN_NATIVE, offset, checked_alignof(ALIGN_NATIVE, typ)*8)
	return 0 < bits <= pad ? 0 : pad
end


function checked_alignof(args...)
	a = alignof(args...)
	a == 0 || a == nextpow(2, a) || error("Alignment must be a power of 2")
	return a
end



mutable struct Cenumlayout
	type::DataType
	min::Integer
	max::Integer
	values::Dict{Symbol, Integer}
	
	Cenumlayout() = new(Nothing, 0, 0, Dict{Symbol, Integer}())
end
Cenumlayout(::Type{CE}) where {CE<:Cenum} = Cenumlayout(Ctypespec(CE))


function _addvalue(layout::Cenumlayout, ::Type{Pair{sym, val}}, ::Type{spec}) where {spec<:Ctypespec, sym, val}
	haskey(layout.values, sym) && error("Encountered a duplicate value name `$(sym)` in enum specification")
	layout.values[sym] = val
	
	(min, max) = extrema(values(layout.values))
	for typ in enumtypes(_strategy(spec))
		if typemin(typ) <= min && max <= typemax(typ)
			layout.type = typ
			layout.min = typ(min)
			layout.max = typ(max)
			return
		end
	end
	error("Unable to determine suitable enumeration storage type for `$(sym) = $(val)`")
end

@generated function Cenumlayout(::Type{spec}) where {spec<:Ctypespec{<:Any, <:Cenum, <:Calignment, <:Tuple}}
	layout = Cenumlayout()
	
	values = _specification(spec)
	while values !== Tuple{}
		value = Base.tuple_type_head(values)
		values = Base.tuple_type_tail(values)
		
		_addvalue(layout, value, spec)
	end
	
	return layout
end



struct Ctypefield
	ind::Int  # field index
	type::DataType  # field type
	size::Int  # in bits:  0 means use sizeof(type)*8, >0 means bit field size
	offset::Int  # in bits
end

mutable struct Ctypelayout
	align::Int  # in bytes
	size::Int  # in bits
	offset::Int  # in bits
	fields::Dict{Symbol, Ctypefield}  # symbol => Ctypefield
	
	Ctypelayout() = new(1, 0, 0, Dict{Symbol, Ctypefield}())
end
Ctypelayout(::Type{CC}) where {CC<:Cconst} = Ctypelayout(nonconst(CC))
Ctypelayout(::Type{CA}) where {CA<:Caggregate} = Ctypelayout(Ctypespec(CA))


_offset(::Type{spec}, offset::Int) where {spec<:Ctypespec} = _offset(_kind(spec), offset)
_offset(::Type{Cstruct}, offset::Int) = offset
_offset(::Type{Cunion}, offset::Int) = 0

_size(::Type{spec}, args...) where {spec<:Ctypespec} = _size(_kind(spec), args...)
_size(::Type{Cstruct}, args...) = +(args...)
_size(::Type{Cunion}, args...) = max(args...)

_field(::Type{T}) where {T} = error("Unable to handle field type `$(T)` found in type specification")
_field(::Type{Pair{sym, Tuple{T}}}) where {sym, T} = (sym, T, 0)
_field(::Type{Pair{sym, Tuple{T, B}}}) where {sym, T, B} = (sym, T, B)
_field(::Type{Pair{sym, TS}}) where {sym, TS<:Ctypespec} = (sym, TS, 0)
_field(::Type{TS}) where {TS<:Ctypespec} = (nothing, TS, 0)


function _addfield(layout::Ctypelayout, sym::Symbol, field::Ctypefield)
	haskey(layout.fields, sym) && error("Encountered a duplicate field name `$(sym)` in type specification")
	layout.fields[sym] = field
end


_addfield(layout::Ctypelayout, ::Nothing, typ) = error("Encountered an unnamed field of type `$(typ)` in type specification")

function _addfield(layout::Ctypelayout, ::Nothing, ::Type{spec}, bits) where {spec<:Ctypespec{<:Any, <:Caggregate, <:Calignment, <:Tuple}}
	for (sym, field) in Ctypelayout(spec).fields
		_addfield(layout, sym, Ctypefield(length(layout.fields), (_type(spec) <: Cconst ? Cconst(field.type) : field.type), field.size, layout.offset+field.offset))
	end
	return sizeof(_type(spec))*8
end

function _addfield(layout::Ctypelayout, sym::Symbol, ::Type{spec}, bits) where {spec<:Ctypespec{<:Any, <:Copaques, <:Calignment, <:Tuple}}
	_addfield(layout, sym, Ctypefield(length(layout.fields), _type(spec), 0, layout.offset))
	return sizeof(_type(spec))*8
end

function _addfield(layout::Ctypelayout, sym::Symbol, typ, bits)
	_addfield(layout, sym, Ctypefield(length(layout.fields), typ, bits, layout.offset))
	return iszero(bits) ? sizeof(typ)*8 : bits
end


function _addfield(layout::Ctypelayout, ::Type{T}, ::Type{spec}) where {spec<:Ctypespec{<:Any, <:Caggregate, <:Calignment, <:Tuple}, T}
	(sym, typ, bits) = _field(T)
	pad = padding(_strategy(spec), layout.offset, bits, typ)
	align = checked_alignof(_strategy(spec), typ)
	layout.offset = _size(spec, layout.offset, pad)
	
	bits = _addfield(layout, sym, typ, bits)
	
	layout.align = max(layout.align, align)
	layout.size = _size(spec, layout.size, pad + bits)
end

function _addfield(layout::Ctypelayout, ::Type{Calignment{align}}, ::Type{spec}) where {spec<:Ctypespec{<:Any, <:Caggregate, <:Calignment, <:Tuple}, align}
	pad = padding(_strategy(spec), layout.offset, align*8)
	layout.align = max(layout.align, align)
	layout.size = _size(spec, layout.size, pad)
end


@generated function Ctypelayout(::Type{spec}) where {spec<:Ctypespec{<:Any, <:Caggregate, <:Calignment, <:Tuple}}
	layout = Ctypelayout()
	
	fields = _specification(spec)
	while fields !== Tuple{}
		field = Base.tuple_type_head(fields)
		fields = Base.tuple_type_tail(fields)
		
		layout.offset = _offset(spec, layout.size)
		_addfield(layout, field, spec)
	end
	
	layout.size += padding(_strategy(spec), layout.size, layout.align*8)
	layout.size += -layout.size & (8-1)  # ensure size is divisible by 8
	
	return layout
end
