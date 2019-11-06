

struct Ctypespec{T, CX<:Union{Caggregate, Cenum}, S<:Calignment, TS<:Tuple}
end

Ctypespec(::Type{T}) where {T} = Tuple{T}
Ctypespec(::Type{T}, ::Val{bits}) where {T, bits} = Tuple{T, bits}
Ctypespec(::Type{CX}) where {CX<:Union{Caggregate, Cenum}} = Ctypespec{_concrete(CX), _concrete(CX), _strategy(CX), _specification(CX)}

Ctypespec(::Type{CX}, ::Type{S}, ::Type{TS}) where {CX<:Union{Caggregate, Cenum}, S, TS} = Ctypespec{CX, CX, S, TS}


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
_kind(::Type{CE}) where {CE<:Cenum} = Cenum

