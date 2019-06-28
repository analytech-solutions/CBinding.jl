

struct Cglobalconst{T}
	handle::Ptr{T}
	
	Cglobalconst{T}(lib::Clibrary, sym::Symbol) where {T} = new{T}(reinterpret(Ptr{T}, Libdl.dlsym(lib.handle, sym)))
	function Cglobalconst{T}(libs::Vector{Clibrary}, sym::Symbol) where {T}
		for lib in libs
			handle = Libdl.dlsym(lib.handle, sym, throw_error = false)
			handle === nothing || return new{T}(reinterpret(Ptr{T}, handle))
		end
		return new{T}(reinterpret(Ptr{T}, Libdl.dlsym(last(libs).handle, sym)))
	end
end
struct Cglobal{T}
	handle::Ptr{T}
	
	Cglobal{T}(lib::Clibrary, sym::Symbol) where {T} = new{T}(reinterpret(Ptr{T}, Libdl.dlsym(lib.handle, sym)))
	function Cglobal{T}(libs::Vector{Clibrary}, sym::Symbol) where {T}
		for lib in libs
			handle = Libdl.dlsym(lib.handle, sym, throw_error = false)
			handle === nothing || return new{T}(reinterpret(Ptr{T}, handle))
		end
		return new{T}(reinterpret(Ptr{T}, Libdl.dlsym(last(libs).handle, sym)))
	end
end
Base.getindex(g::Union{Cglobalconst{T}, Cglobal{T}}) where {T} = unsafe_load(g.handle)
Base.setindex!(g::Cglobal{T}, val::T) where {T} = unsafe_store!(g.handle, val)

