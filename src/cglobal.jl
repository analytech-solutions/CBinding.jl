

struct Cglobal{T}
	handle::Ptr{T}
end
Cglobal{T}(sym::Symbol, libs::Clibrary...) where {T} = Cglobal{T}(reinterpret(Ptr{T}, _dlsym(sym, libs...)))
Cglobal{T}(lib::Clibrary, sym::Symbol) where {T} = Cglobal{T}(sym, lib)

Base.getindex(g::Cglobal{T}) where {T} = unsafe_load(g.handle)
Base.setindex!(g::Cglobal{T}, val) where {T} = unsafe_store!(g.handle, convert(T, val))


struct DeferredCglobal{T, name<:Val, lib<:Val}
end

(g::DeferredCglobal{T, Val{name}, Val{lib}})() where {T, name, lib} = Cglobal{T}(_cglobal(DeferredCglobal{nonconst(T), Val{name}, Val{lib}}()))
(g::DeferredCglobal{FieldType, Val{name}, Val{lib}})() where {FieldType<:Union{Cdeferrable, Cconst{<:Cdeferrable}}, name, lib} = Caccessor{FieldType}(_cglobal(DeferredCglobal{nonconst(FieldType), Val{name}, Val{lib}}()))

@generated function _cglobal(::DeferredCglobal{T, Val{name}, Val{lib}}) where {T, name, lib}
	return quote
		return cglobal(($(QuoteNode(name)), $(String(lib))), T)
	end
end

