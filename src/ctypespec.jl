

struct Ctypespec{T, CO<:Copaques, S<:Calignment, TS<:Tuple}
end

Ctypespec(::Type{T}) where {T} = Tuple{T}
Ctypespec(::Type{T}, ::Val{bits}) where {T, bits} = Tuple{T, bits}
Ctypespec(::Type{CO}) where {CO<:Copaques} = Ctypespec{_concrete(CO), _concrete(CO), _strategy(CO), _specification(CO)}

Ctypespec(::Type{CO}, ::Type{S}, ::Type{TS}) where {CO<:Copaques, S, TS} = Ctypespec{CO, CO, S, TS}


_type(::Type{Ctypespec{T, CO, S, TS}}) where {T, CO, S, TS} = T
_opaque(::Type{Ctypespec{T, CO, S, TS}}) where {T, CO, S, TS} = CO
_strategy(::Type{Ctypespec{T, CO, S, TS}}) where {T, CO, S, TS} = S
_specification(::Type{Ctypespec{T, CO, S, TS}}) where {T, CO, S, TS} = TS

_concrete(::Type{T}) where {T} = T
_concrete(::Type{CO}) where {CO<:Copaques} = error("Attempted to get type specification details of an opaque type `$(CO)`")
_strategy(::Type{CO}) where {CO<:Copaques} = _strategy(_concrete(CO))
_specification(::Type{CO}) where {CO<:Copaques} = _specification(_concrete(CO))

_kind(::Type{TS}) where {TS<:Ctypespec} = _kind(_opaque(TS))
_kind(::Type{CS}) where {CS<:Cstruct} = Cstruct
_kind(::Type{CU}) where {CU<:Cunion} = Cunion
_kind(::Type{CE}) where {CE<:Cenum} = Cenum

