

Base.getindex(cb::Cbinding{T}) where {T<:Cfunction} = getglobal(cb)
Base.getindex(cb::Cbinding{T}) where {T} = unsafe_load(getglobal(cb))
Base.setindex!(cb::Cbinding{T}, val) where {T} = unsafe_store!(getglobal(cb), convert(T, val))

Base.fieldcount(::Type{Cbinding{CA}}) where {CA<:Caggregates} = fieldcount(CA)
Base.fieldtypes(::Type{Cbinding{CA}}) where {CA<:Caggregates} = fieldtypes(CA)
Base.fieldnames(::Type{Cbinding{CA}}) where {CA<:Caggregates} = fieldnames(CA)
Base.propertynames(cb::Cbinding) = fieldnames(typeof(cb))


Base.getproperty(cb::Cbinding{CA}, sym::Symbol) where {CA<:Caggregates} = getproperty(getglobal(cb), sym)
Base.setproperty!(cb::Cbinding{CA}, sym::Symbol, val) where {CA<:Caggregate} = setproperty!(getglobal(cb), sym, val)


@generated function getglobal(glob::Cbinding{T, lib, name}) where {T, lib, name}
	glob = lib isa Symbol ? :(($(QuoteNode(name)), $(String(lib)))) : QuoteNode(name)
	return quote
		return Cptr{bitstype(T)}(cglobal($(glob)))
	end
end

