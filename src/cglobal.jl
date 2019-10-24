

struct Cglobal{T}
	handle::Ptr{T}
	
	Cglobal{T}(sym::Symbol, libs::Clibrary...) where {T} = new{T}(reinterpret(Ptr{T}, _dlsym(sym, libs...)))
end
Cglobal{T}(lib::Clibrary, sym::Symbol) where {T} = Cglobal{T}(sym, lib)

Base.getindex(g::Cglobal{T}) where {T} = unsafe_load(g.handle)
Base.setindex!(g::Cglobal{T}, val::T) where {T} = unsafe_store!(g.handle, val)

