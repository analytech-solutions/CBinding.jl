

@generated function Carray{T, N, S}(::UndefInitializer) where {T, N, S}
	init = ((zero(UInt8) for _ in 1:S)...,)
	return :(Carray{T, N, S}(undef, $(init)))
end


(::Type{CA})(args...) where {CA<:Carray} = CA(undef, args...)
function (::Type{CA})(init::Union{NTuple{N, UInt8} where {N}, CA, Cbinding{CA}, Cptrs{CA}, UndefInitializer}, args...) where {CA<:Carray}
	result =
		init isa UndefInitializer ? bitstype(CA)(undef) :
		init isa Tuple ? bitstype(CA)(undef, init) :
		init isa Cbinding ? init[] :
		init isa Cptrs ? init[] :
		init
	
	for (ind, arg) in enumerate(args)
		result = arg isa Pair && first(arg) isa Integer ? initindex!(result, last(arg), first(arg)) : initindex!(result, arg, ind)
	end
	
	return result
end


Base.zero(::Type{CA}) where {CA<:Carray} = CA()
Base.sizeof(::Type{CA}) where {CA<:Carray} = invoke(sizeof, Tuple{Any}, bitstype(CA))
Base.size(::Type{CA}) where {T, N, CA<:Carrays{T, N}} = (N,)
Base.length(::Type{CA}) where {T, N, CA<:Carrays{T, N}} = N
Base.eltype(::Type{CA}) where {T, N, CA<:Carrays{T, N}} = T
Base.convert(::Type{CA}, t::Tuple) where {CA<:Carray} = CA(t...)

Base.convert(::Type{CA}, str::String) where {T<:Union{Int8, UInt8, Cconst{Int8}, Cconst{UInt8}}, CA<:Carray{T}} = CA(str...)
Base.String(ca::Carray{T}) where {T<:Union{Int8, UInt8, Cconst{Int8}, Cconst{UInt8}}} = String(map(t -> reinterpret(UInt8, convert(unqualifiedtype(T), t)), collect(ca)))
Base.show(io::IO, ca::Carray{T}) where {T<:Union{Int8, UInt8, Cconst{Int8}, Cconst{UInt8}}} = show(io, String(ca))


Base.firstindex(ca::CA) where {CA<:Carrays} = 1
Base.lastindex(ca::CA) where {CA<:Carrays} = length(ca)

Base.IndexStyle(::Type{CA}) where {CA<:Carrays} = IndexLinear()
Base.size(ca::CA) where {CA<:Carrays} = size(typeof(ca))
Base.length(ca::CA) where {CA<:Carrays} = length(typeof(ca))
Base.eltype(ca::CA) where {CA<:Carrays} = eltype(typeof(ca))

Base.keys(ca::CA) where {CA<:Carrays} = firstindex(ca):lastindex(ca)
Base.values(ca::CA) where {CA<:Carrays} = iterate(ca)
Base.iterate(ca::CA, i::Integer = 1) where {CA<:Carrays} = firstindex(ca) <= i <= lastindex(ca) ? (ca[i], i+1) : nothing


Base.getindex(ptr::Cptrs{CA}, i::Integer) where {T, N, CA<:Carrays{T, N}} = Core.Intrinsics.bitcast(Cptr{isqualifiedwith(CA, Cconst) && !isqualifiedwith(T, Cconst) ? Cconst{T} : T}, ptr) + (i-1)
Base.getindex(ca::CA, i::Integer) where {T, N, CA<:Carrays{T, N}} = load(ca, field(CA, i))

Base.setindex!(ptr::Cptrs{CA}, val, i::Integer) where {T, N, CA<:Carray{T, N}} = unsafe_store!(Core.Intrinsics.bitcast(Cptr{T}, ptr) + (i-1), val)
initindex!(ca::CA, val, i::Integer) where {T, N, CA<:Carray{T, N}} = store!(ca, field(CA, i), val)

