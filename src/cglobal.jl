

mutable struct Cglobalconst{T}
	handle::Ptr{T}
	
	Cglobalconst{T}(lib::Clibrary, sym::Symbol) where {T} = new{T}(reinterpret(Ptr{T}, Libdl.dlsym(lib.handle, sym)))
	Cglobalconst{T}() where {T} = new{T}(Ptr{T}(C_NULL))
end
mutable struct Cglobal{T}
	handle::Ptr{T}
	
	Cglobal{T}(lib::Clibrary, sym::Symbol) where {T} = new{T}(reinterpret(Ptr{T}, Libdl.dlsym(lib.handle, sym)))
	Cglobal{T}() where {T} = new{T}(Ptr{T}(C_NULL))
end
Base.getindex(g::Union{Cglobalconst{T}, Cglobal{T}}) where {T} = unsafe_load(g.handle)
Base.setindex!(g::Cglobal{T}, val::T) where {T} = unsafe_store!(g.handle, val)


function bind(g::Union{Cglobalconst{T}, Cglobal{T}}, sym, libs::Clibrary...) where {T}
		for (ind, lib) in enumerate(libs)
			handle = Libdl.dlsym(lib.handle, sym, throw_error = ind == length(libs))
			if !isnothing(handle)
				g.handle = reinterpret(Ptr{T}, handle)
				break
			end
		end
		return nothing
end
