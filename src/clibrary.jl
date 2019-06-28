

struct Clibrary
	handle::Ptr{Cvoid}
	
	Clibrary(libName::Union{AbstractString, Nothing} = nothing) = new(Libdl.dlopen(libName === nothing ? _NullCString() : libName, Libdl.RTLD_LAZY | Libdl.RTLD_DEEPBIND | Libdl.RTLD_LOCAL))
end

Base.close(lib::Clibrary) = Libdl.dlclose(lib.handle)

# NOTE:  risky hack to trick Julia dlopen into ccalling the C dlopen with NULL (meaning to dlopen current process rather than a library)
struct _NullCString <: AbstractString end
Base.cconvert(::Type{Cstring}, ::_NullCString) = Cstring(C_NULL)

