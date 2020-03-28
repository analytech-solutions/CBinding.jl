

Cconst{T, S}(args...; kwargs...) where {T, S} = Cconst{T}(args...; kwargs...)
Cconst{T}(args...; kwargs...) where {T} = Cconst(T(args...; kwargs...))
Cconst(::Type{T}) where {T} = Cconst{nonconst(T), sizeof(nonconst(T))}
Cconst(::Type{CA}) where {T, N, CA<:Carray{T, N}} = Carray(Cconst(nonconst(T)), Val(N))
Cconst(x) = x
Cconst(cc::Cconst) = cc
Cconst(ca::Caggregate) = Cconst{typeof(ca)}(getfield(ca, :mem))

nonconst(::Type{T}) where {T} = T
nonconst(::Type{CA}) where {T<:Cconst, N, CA<:Carray{T, N}} = Carray(nonconst(T), Val(N))
nonconst(::Type{CC}) where {T, CC<:Cconst{T}} = T

Base.read(io::IO, ::Type{CC}) where {CC<:Cconst{<:Caggregate}} = Cconst(read(io, nonconst(CC)))
Base.zero(::Type{CC}) where {CC<:Cconst{<:Caggregate}} = Cconst(zero(nonconst(CC)))
Base.convert(::Type{T}, cc::Cconst{T}) where {T<:Caggregate} = T(cc)
Base.sizeof(::Type{CC}) where {T, CC<:Cconst{T}} = sizeof(T)


function Ctypespec(::Type{CC}) where {CC<:Cconst}
	_fix(::Type{Tuple{typ}}) where {typ} = Tuple{Cconst(typ)}
	_fix(::Type{Tuple{typ, bits}}) where {typ, bits} = Tuple{Cconst(typ), bits}
	_fix(::Type{spec}) where {spec<:Ctypespec} = Ctypespec{Cconst(type(spec)), opaque(spec), strategy(spec), specification(spec)}
	return _fix(Ctypespec(nonconst(CC)))
end

