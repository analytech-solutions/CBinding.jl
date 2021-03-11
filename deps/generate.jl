using C

const LIBCLANG_PATH = ARGS[1]

incdir = joinpath(dirname(dirname(LIBCLANG_PATH)), "include")

c`-std=c99 -I$(incdir) -L$(dirname(LIBCLANG_PATH)) -lclang`
c"""
	#include <time.h>
"""s

libclang = quote
	const basedir = "$(C.dirname(C.dirname(C.libclang_path())))"
	const incdir  = "$(basedir)/include"
	const libdir  = "$(basedir)/$(Sys.iswindows() ? "bin" : "lib")"
	const libpath = Symbol("$(libdir)/libclang")
	
	const var"c\"time_t\"" = $(Cvoid)  # HACK: this is not used anyways
	const var"c\"size_t\"" = $(Csize_t)
	
	$(@macroexpand c"""
		#include <clang-c/CXString.h>
		#include <clang-c/CXErrorCode.h>
		#include <clang-c/Documentation.h>
		#include <clang-c/Index.h>
	"""ju)
end


function sanitize(str::String)
	str = replace(str, r"(\W)"*dirname(dirname(LIBCLANG_PATH))*"/" => s"\1$(basedir)/")
	str = replace(str, r"(\W)"*"\$(basedir)/lib/" => s"\1$(libdir)/")
	str = replace(str, r"(\W)"*"\$(basedir)/include/" => s"\1$(incdir)/")
	str = replace(str, "Symbol(\"\$(libdir)/libclang\")," => "libpath,")
	str = replace(str, r"(\W)"*dirname(@__DIR__)*"/" => s"\1../")
	
	lines = []
	for line in split(str, '\n')
		l = strip(line)
		startswith(l, "#=") && endswith(l, "=#") && continue
		
		m = match(r"/(C|C\.jl|home|usr)/", l)
		isnothing(m) || error("Unsanitized paths still remain:  $(l)")
		
		push!(lines, line)
	end
	return join(lines, '\n')
end


libclang = sanitize(string(libclang))  # NOTE: do this _before_ we truncate the file!
open(joinpath(@__DIR__, "libclang-$(C.libclang_version(LIBCLANG_PATH)).jl"), "w+") do io
	println(io, libclang)
end

