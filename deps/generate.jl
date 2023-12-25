# USAGE:
#   1. install a new version of Julia
#   2. run the new version, install Clang_jll `] add Clang_jll`, and obtain paths `using Clang_jll ; @info String(Clang_jll.libclang_path), String(Base.libllvm_path())`
#   3. using a prior version of Julia with CBinding in development, run `path/to/prior/bin/julia ~/.julia/dev/CBinding/deps/generate.jl path/to/libclang path/to/libllvm`

using CBinding
using CBinding.libclang: Clang_jll
using CBinding.Libdl

const LIBCLANG_PATH = get(ARGS, 1, Clang_jll.libclang_path)
const LIBLLVM_PATH = get(ARGS, 2, joinpath(dirname(Base.julia_cmd().exec[1]), Base.LIBDIR, "julia", "libLLVM.so"))

withenv("LD_LIBRARY_PATH" => get(ENV, "LD_LIBRARY_PATH", "")*":"*normpath(dirname(LIBLLVM_PATH))) do
	dlopen(LIBLLVM_PATH) do lib  # needed to hijack the libLLVM that clank will be linked to
		@eval c`-std=c99 -I$(dirname(dirname(LIBCLANG_PATH)))/include -L$(dirname(LIBCLANG_PATH)) -lclang`
		@eval c"""
			#include <time.h>
		"""s
		
		libclang = quote
			const basedir = "$(CBinding.dirname(CBinding.dirname(CBinding.libclang_path())))"
			const incdir  = "$(basedir)/include"
			const libdir  = "$(basedir)/$(Sys.iswindows() ? "bin" : "lib")"
			const libpath = Symbol("$(libdir)/libclang")
			
			const var"c\"time_t\"" = $(Cvoid)  # HACK: this is not used anyways
			const var"c\"size_t\"" = $(Csize_t)
			
			$(@eval @macroexpand c"""
				#include <clang-c/Documentation.h>
				#include <clang-c/Index.h>
			"""jium)
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
				
				m = match(r"/(TEST|C|C\.jl|home|usr)/", l)
				isnothing(m) || error("Unsanitized paths still remain:  $(l)")
				
				push!(lines, line)
			end
			return join(lines, '\n')
		end
		
		
		libclang = sanitize(string(libclang))  # NOTE: do this _before_ we truncate the file!
		open(joinpath(@__DIR__, "libclang-$(CBinding.libclang_version(LIBCLANG_PATH)).jl"), "w+") do io
			println(io, libclang)
		end
	end
end
