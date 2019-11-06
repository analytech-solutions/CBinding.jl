

struct Ctypespec{T, CO<:Copaques, S<:Calignment, TS<:Tuple}
end

Ctypespec(::Type{T}) where {T} = Tuple{T}
Ctypespec(::Type{T}, ::Val{bits}) where {T, bits} = Tuple{T, bits}
Ctypespec(::Type{CO}) where {CO<:Copaques} = Ctypespec{concrete(CO), concrete(CO), strategy(CO), specification(CO)}

Ctypespec(::Type{CO}, ::Type{S}, ::Type{TS}) where {CO<:Copaques, S, TS} = Ctypespec{CO, CO, S, TS}


type(::Type{Ctypespec{T, CO, S, TS}}) where {T, CO, S, TS} = T
opaque(::Type{Ctypespec{T, CO, S, TS}}) where {T, CO, S, TS} = CO
strategy(::Type{Ctypespec{T, CO, S, TS}}) where {T, CO, S, TS} = S
specification(::Type{Ctypespec{T, CO, S, TS}}) where {T, CO, S, TS} = TS

concrete(::Type{T}) where {T} = T
concrete(::Type{CO}) where {CO<:Copaques} = error("Attempted to get type specification details of an opaque type `$(CO)`")
strategy(::Type{CO}) where {CO<:Copaques} = strategy(concrete(CO))
specification(::Type{CO}) where {CO<:Copaques} = specification(concrete(CO))

kind(::Type{TS}) where {TS<:Ctypespec} = kind(opaque(TS))
kind(::Type{CS}) where {CS<:Cstruct} = Cstruct
kind(::Type{CU}) where {CU<:Cunion} = Cunion
kind(::Type{CE}) where {CE<:Cenum} = Cenum

