

mutable struct Carray{T, N, S} <: AbstractArray{T, 1}
	mem::NTuple{S, UInt8}
	
	Carray{T, N, S}(::UndefInitializer) where {T, N, S} = new{T, N, S}()
end
Carray{T, N}(u::UndefInitializer) where {T, N} = Carray{T, N, sizeof(Carray{T, N})}(u)
Carray(::Type{T}, ::Val{N}) where {T, N} = Carray{T, N, sizeof(Carray{T, N})}

function (::Type{CA})() where {CA<:Carray}
	result = CA(undef)
	setfield!(result, :mem, map(zero, getfield(result, :mem)))
	return result
end

Base.zero(::Type{CA}) where {CA<:Union{Caggregate, Carray}} = CA()
Base.sizeof(::Type{CA}) where {T, N, CA<:Carray{T, N}} = sizeof(T)*N
Base.isequal(x::Carray, y::Carray) = length(x) == length(y) && all(i -> x[i] == y[i], eachindex(x))
Base.:(==)(x::Carray, y::Carray) = isequal(x, y)


function Ctypespec(::Type{CA}) where {T, N, CA<:Carray{T, N}}
	_fix(::Type{Tuple{typ}}) where {typ} = Tuple{Carray(typ, Val(N))}
	_fix(::Type{Tuple{typ, bits}}) where {typ, bits} = error("A Carray of a bit field is not supported")
	_fix(::Type{spec}) where {spec<:Ctypespec} = Ctypespec{Carray(_type(spec), Val(N)), _aggregate(spec), _strategy(spec), _specification(spec)}
	return _fix(Ctypespec(eltype(CA)))
end

