

struct Ctypespec{T, CA<:Caggregate, S<:Calignment, TS<:Tuple}
end

Ctypespec(::Type{T}) where {T} = Tuple{T}
Ctypespec(::Type{T}, ::Val{bits}) where {T, bits} = Tuple{T, bits}
Ctypespec(::Type{CA}) where {CA<:Caggregate} = Ctypespec{CA, CA, _strategy(CA), _specification(CA)}

Ctypespec(::Type{Cstruct}, ::Type{S}, ::Type{TS}) where {S, TS} = Ctypespec{Cstruct, Cstruct, S, TS}
Ctypespec(::Type{Cunion}, ::Type{S}, ::Type{TS}) where {S, TS} = Ctypespec{Cunion, Cunion, S, TS}


_type(::Type{Ctypespec{T, CA, S, TS}}) where {T, CA, S, TS} = T
_aggregate(::Type{Ctypespec{T, CA, S, TS}}) where {T, CA, S, TS} = CA
_strategy(::Type{Ctypespec{T, CA, S, TS}}) where {T, CA, S, TS} = S
_specification(::Type{Ctypespec{T, CA, S, TS}}) where {T, CA, S, TS} = TS

_strategy(::Type{CA}) where {CA<:Caggregate} = error("Attempted to get alignment strategy for an aggregate without one")

_specification(::Type{CA}) where {CA<:Caggregate} = error("Attempted to get type specification for an aggregate without one")

_kind(::Type{TS}) where {TS<:Ctypespec} = _kind(_aggregate(TS))
_kind(::Type{CS}) where {CS<:Cstruct} = Cstruct
_kind(::Type{CU}) where {CU<:Cunion} = Cunion

