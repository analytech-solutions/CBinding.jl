

struct Ctypespec{T, CA<:Caggregate, S<:Calignment, TS<:Tuple}
end

Ctypespec(::Type{T}) where {T} = Tuple{T}
Ctypespec(::Type{T}, ::Val{bits}) where {T, bits} = Tuple{T, bits}
Ctypespec(::Type{CA}) where {CA<:Caggregate} = Ctypespec{_concrete(CA), _concrete(CA), _strategy(CA), _specification(CA)}

Ctypespec(::Type{CS}, ::Type{S}, ::Type{TS}) where {CS<:Cstruct, S, TS} = Ctypespec{CS, CS, S, TS}
Ctypespec(::Type{CU}, ::Type{S}, ::Type{TS}) where {CU<:Cunion, S, TS} = Ctypespec{CU, CU, S, TS}


_type(::Type{Ctypespec{T, CA, S, TS}}) where {T, CA, S, TS} = T
_aggregate(::Type{Ctypespec{T, CA, S, TS}}) where {T, CA, S, TS} = CA
_strategy(::Type{Ctypespec{T, CA, S, TS}}) where {T, CA, S, TS} = S
_specification(::Type{Ctypespec{T, CA, S, TS}}) where {T, CA, S, TS} = TS

_concrete(::Type{T}) where {T} = T
_concrete(::Type{CA}) where {CA<:Caggregate} = error("Attempted to get type specification details of an opaque aggregate type `$(CA)`")
_strategy(::Type{CA}) where {CA<:Caggregate} = _strategy(_concrete(CA))
_specification(::Type{CA}) where {CA<:Caggregate} = _specification(_concrete(CA))

_kind(::Type{TS}) where {TS<:Ctypespec} = _kind(_aggregate(TS))
_kind(::Type{CS}) where {CS<:Cstruct} = Cstruct
_kind(::Type{CU}) where {CU<:Cunion} = Cunion

