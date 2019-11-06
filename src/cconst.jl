

struct Cconst{T, S}
	mem::NTuple{S, UInt8}
	
	Cconst{T}(x) where {T} = new{T, sizeof(T)}(x)
end
Cconst{T, S}(args...; kwargs...) where {T, S} = Cconst{T}(args...; kwargs...)
Cconst{T}(; kwargs...) where {T} = Cconst(T(; kwargs...))
Cconst(::Type{T}) where {T} = Cconst{nonconst(T), sizeof(nonconst(T))}
Cconst(::Type{CA}) where {T, N, CA<:Carray{T, N}} = Carray(Cconst(nonconst(T)), Val(N))
Cconst(x) = x
Cconst(cc::Cconst) = cc
Cconst(ca::Caggregate) = Cconst{typeof(ca)}(getfield(ca, :mem))

nonconst(::Type{T}) where {T} = T
nonconst(::Type{CA}) where {T<:Cconst, N, CA<:Carray{T, N}} = Carray(nonconst(T), Val(N))
nonconst(::Type{CC}) where {T, CC<:Cconst{T}} = T

Base.convert(::Type{T}, cc::Cconst{T}) where {T} = reinterpret(T, getfield(cc, :mem)[1])
Base.convert(::Type{T}, cc::Cconst{T}) where {T<:Caggregate} = T(cc)
Base.sizeof(::Type{CC}) where {T, CC<:Cconst{T}} = sizeof(T)


function Ctypespec(::Type{CC}) where {CC<:Cconst}
	_fix(::Type{Tuple{typ}}) where {typ} = Tuple{Cconst(typ)}
	_fix(::Type{Tuple{typ, bits}}) where {typ, bits} = Tuple{Cconst(typ), bits}
	_fix(::Type{spec}) where {spec<:Ctypespec} = Ctypespec{Cconst(_type(spec)), _opaque(spec), _strategy(spec), _specification(spec)}
	return _fix(Ctypespec(nonconst(CC)))
end

