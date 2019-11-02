

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


_strategy(::Type{CA}) where {T<:Caggregate, N, CA<:Carray{T, N}} = _strategy(T)
_typespec(::Type{CA}) where {T<:Caggregate, N, CA<:Carray{T, N}} = _typespec(T)

