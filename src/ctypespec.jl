

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
# concrete(::Type{Ptr{T}}) where {T} = Ptr{concrete(T)}
concrete(::Type{Cconst{T, S}}) where {T, S} = Cconst{concrete(T), S}
concrete(::Type{Cconst{T}}) where {T} = Cconst{concrete(T)}
concrete(::Type{CO}) where {CO<:Copaques} = error("Attempted to get type specification details of an opaque type `$(CO)`")
strategy(::Type{CO}) where {CO<:Copaques} = strategy(concrete(CO))
specification(::Type{CO}) where {CO<:Copaques} = specification(concrete(CO))

kind(::Type{TS}) where {TS<:Ctypespec} = kind(opaque(TS))
kind(::Type{CS}) where {CS<:Cstruct} = Cstruct
kind(::Type{CU}) where {CU<:Cunion} = Cunion
kind(::Type{CE}) where {CE<:Cenum} = Cenum


function _gensym(super, strategy, spec...)
	_string(x) = string(x)
	_string(x::QuoteNode) = string(x.value)
	_string(x::Expr) =
		Base.is_expr(x, :escape, 1) ? _string(x.args[1]) :
		Base.is_expr(x, :., 2) ? _string(x.args[1])*"."*_string(x.args[2]) :  # 𝐣𝐥.Cint
		Base.is_expr(x, :curly, 2) && x.args[1] === :Calignment ? _string(x.args[2]) :  # Calignment{:packed}
		Base.is_expr(x, :curly, 3) && x.args[1] === :Pair && _string(x.args[2]) == _string(x.args[3]) ? "<"*_string(x.args[3])*">" :  # enum value
		Base.is_expr(x, :curly, 3) && x.args[1] === :Pair ? _string(x.args[2])*"::"*_string(x.args[3]) :  # fieldName::fieldType
		Base.is_expr(x, :curly, 4) && x.args[1] === :Carray ? _string(x.args[2])*"["*_string(x.args[3])*"]" :  # fieldType[N]
		Base.is_expr(x, :curly, 2) ? _string(x.args[1])*"{"*_string(x.args[2])*'}' :  # Ptr{Cvoid}
		Base.is_expr(x, :call, 2) && x.args[1] === :Ctypespec ? "("*_string(x.args[2])*")" :  # struct/union field type
		Base.is_expr(x, :call, 3) && x.args[1] === :Ctypespec ? "("*_string(x.args[2])*":"*_string(x.args[3])*")" :  # bit field
		Base.is_expr(x, :call, 2) && x.args[1] === :Val ? _string(x.args[2]) :  # # bits of bitfield
		Base.is_expr(x, :call) ? _string(x.args[1])*"("*join(map(_string, x.args[2:end]), ',')*")" :  # Cconst(fieldType) or @align sizeof(x)*2
		string(x)  # error("Unhandled gensym expression: $(x)")
	
	strategy =
		strategy === :ALIGN_NATIVE ? string(:native) :
		strategy === :ALIGN_PACKED ? string(:packed) :
		_string(strategy)
	
	result = [
		_string(super),
		strategy,
		map(_string, spec)...,
	]
	return Symbol(join(result, '|'))
end

