

function _dlsym(sym::Symbol, libs::Clibrary...)
	for (ind, lib) in enumerate(libs)
		isLast = ind == length(libs)
		handle = Libdl.dlsym(lib.handle, sym, throw_error = isLast)
		isnothing(handle) || return handle
	end
	error("Libdl.dlsym returned a C_NULL handle and did not throw an error")
end

