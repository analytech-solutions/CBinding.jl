

Libc.free(ptr::Cptr{T}) where {T} = Libc.free(Core.Intrinsics.bitcast(Ptr{T}, ptr))

Libc.malloc(::Type{T}, num::Integer = 1) where {T} = Cptr{T}(Libc.malloc(sizeof(T)*num))
function Libc.malloc(t::T, num::Integer = 1) where {T}
	ptr = Cptr{T}(Libc.malloc(sizeof(T)*num))
	for ind in 1:num
		(ptr + (ind-1))[] = t
	end
	return ptr
end


Cptr{T}(ptr::Ptr = C_NULL) where {T} = Core.Intrinsics.bitcast(Cptr{T}, ptr)
Cptr{T}(i::Integer) where {T} = sizeof(i) < sizeof(Cptr) ? Core.Intrinsics.zext_int(Cptr{T}, i) : Core.Intrinsics.bitcast(Cptr{T}, i)
(::Type{T})(ptr::Cptr) where {T<:Union{Ptr, Unsigned}} = convert(T, ptr)

Base.eltype(::Type{Cptr{T}}) where {T} = T
Base.convert(::Type{T}, ptr::Cptrs) where {T<:Unsigned} = convert(T, Core.Intrinsics.bitcast(sizeof(ptr) == sizeof(UInt32) ? UInt32 : UInt64, ptr))
Base.convert(::Type{Ptr{T}}, ptr::Cptrs) where {T} = Core.Intrinsics.bitcast(Ptr{T}, ptr)
Base.convert(::Type{Cptr{T}}, ptr::Cptrs) where {T} = Core.Intrinsics.bitcast(Cptr{T}, ptr)
Base.convert(::Type{Cptr{T}}, ptr::Ptr) where {T} = Core.Intrinsics.bitcast(Cptr{T}, ptr)
Base.convert(::Type{Cptr{T}}, ptr::Ref) where {T} = Core.Intrinsics.bitcast(Cptr{T}, Base.unsafe_convert(Ptr{eltype(ptr)}, ptr))
Base.zero(::Type{Cptr{T}}) where {T} = Cptr{T}(C_NULL)
Base.:+(ptr::Cptr{T}, offset::Integer) where {T} = Cptr{T}(Core.Intrinsics.bitcast(Ptr{UInt8}, ptr) + max(1, sizeof(T))*offset)
Base.:-(ptr::Cptr{T}, offset::Integer) where {T} = Cptr{T}(Core.Intrinsics.bitcast(Ptr{UInt8}, ptr) - max(1, sizeof(T))*offset)

Base.:(==)(x::Cptr, y::Cptr) = convert(Ptr{Cvoid}, x) == convert(Ptr{Cvoid}, y)
Base.:(==)(x::Ptr, y::Cptr) = x == convert(typeof(x), y)
Base.:(==)(x::Cptr, y::Ptr) = convert(typeof(y), x) == y

# TODO: make these all work better
Base.cconvert(::Type{Cptr{T}}, x) where {T} = Base.cconvert(Ptr{T}, x)
Base.cconvert(::Type{Cptr{Cconst{T}}}, x::Cptr{T}) where {T} = x
Base.unsafe_convert(::Type{Ptr{T}}, x::Cptr) where {T} = Core.Intrinsics.bitcast(Ptr{T}, x)
Base.unsafe_convert(::Type{Ptr{Cptr{T1}}}, x::Ref{Ptr{T2}}) where {T1, T2} = Core.Intrinsics.bitcast(Ptr{Cptr{T1}}, Base.unsafe_convert(Ptr{Ptr{T2}}, x))
Base.unsafe_convert(::Type{Cptr{T}}, x::Ptr) where {T} = Core.Intrinsics.bitcast(Cptr{T}, x)
Base.unsafe_convert(::Type{Cptr{T}}, x::Ref) where {T} = Core.Intrinsics.bitcast(Cptr{T}, Base.unsafe_convert(Ptr{eltype(x)}, x))
Base.unsafe_convert(::Type{Cptr{T}}, x::Vector) where {T} = Core.Intrinsics.bitcast(Cptr{T}, Base.unsafe_convert(Ptr{eltype(x)}, x))
Base.unsafe_convert(::Type{Cptr{T}}, x::Union{String, Cstring}) where {T<:Union{Int8, UInt8, Cconst{Int8}, Cconst{UInt8}}} = Core.Intrinsics.bitcast(Cptr{T}, Base.unsafe_convert(Ptr{unqualifiedtype(T)}, x))

Base.unsafe_pointer_to_objref(ptr::Cptr{T}) where {T} = unsafe_pointer_to_objref(Core.Intrinsics.bitcast(Ptr{T}, ptr))

Base.unsafe_load(ptr::Cptr{T}) where {T} = unsafe_load(Core.Intrinsics.bitcast(Ptr{bitstype(T)}, ptr))
Base.unsafe_load(ptr::Cptr{T}, i::Integer) where {T} = unsafe_load(Core.Intrinsics.bitcast(Ptr{bitstype(T)}, ptr), i)
Base.unsafe_store!(ptr::Cptr{T}, x) where {T} = unsafe_store!(Core.Intrinsics.bitcast(Ptr{bitstype(T)}, ptr), x)
Base.unsafe_store!(ptr::Cptr{T}, x, i::Integer) where {T} = unsafe_store!(Core.Intrinsics.bitcast(Ptr{bitstype(T)}, ptr), x, i)
Base.unsafe_store!(ptr::Cptr{Cconst{T}}, x, i::Integer = 0) where {T} = error("Unable to store value with pointer to constant $(eltype(ptr))")
Base.unsafe_store!(ptr::Cptr{CA}, x, i::Integer = 0) where {T, N, CA<:Carray{Cconst{T}, N}} = error("Unable to store array value with pointer to constant $(eltype(ptr))")

Base.unsafe_string(ptr::Cptr{T}) where {C<:Union{Cchar, Cuchar}, T<:Cqualifiers{C}} = unsafe_string(Core.Intrinsics.bitcast(Ptr{C}, ptr))
Base.unsafe_string(ptr::Cptr{T}, length::Integer) where {C<:Union{Cchar, Cuchar}, T<:Cqualifiers{C}} = unsafe_string(Core.Intrinsics.bitcast(Ptr{C}, ptr), length)

Base.getindex(ptr::Cptr{T}) where {T} = unsafe_load(ptr)
Base.getindex(ptr::Cptr{T}, i::Integer) where {T} = unsafe_load(ptr, i)
Base.setindex!(ptr::Cptr{T}, val) where {T} = unsafe_store!(ptr, val)
Base.setindex!(ptr::Cptr{T}, val, i::Integer) where {T} = unsafe_store!(ptr, val, i)

Base.getproperty(ptr::Cptr{T}, sym::Symbol) where {T<:Cptrs} = getproperty(unsafe_load(ptr), sym)
Base.getproperty(ptr::Cptr{CA}, sym::Symbol) where {CA<:Caggregates} = field(CA, sym) === nothing ? error("type $(CA) has no field $(sym)") : load(ptr, field(CA, sym))
Base.setproperty!(ptr::Cptr{CA}, sym::Symbol, val) where {CA<:Caggregate} = field(CA, sym) === nothing ? error("type $(CA) has no field $(sym)") : store!(ptr, field(CA, sym), val)

Base.fieldcount(::Type{CP}) where {T, CP<:Cptrs{T}} = fieldcount(T)
Base.fieldtypes(::Type{CP}) where {T, CP<:Cptrs{T}} = fieldtypes(T)
Base.fieldnames(::Type{CP}) where {T, CP<:Cptrs{T}} = fieldnames(T)
Base.propertynames(ptr::Cptr) = fieldnames(typeof(ptr))


