module CBinding
	import Libdl
	
	
	export @ctypedef, @cstruct, @cunion, @carray, @calign, @cenum, @cextern, @cbindings, @ccallback
	export Clongdouble, Caggregate, Cstruct, Cunion, Carray, Cenum, Clibrary, Cglobal, Cglobalconst, Cfunction, Cconvention, Calignment, Cconst, Caccessor
	export STDCALL, CDECL, FASTCALL, THISCALL
	export propertytypes
	
	
	# @macros should be used in a baremodule to keep a clean namespace which avoids naming conflicts with auto-generated C bindings
	macro macros() return quote
		$(map(sym -> :(using CBinding: $(sym)), filter(sym -> startswith(String(sym), '@'), names(@__MODULE__, all = true)))...)
		using CBinding: @doc, @raw_str
	end end
	macro CBinding() return @__MODULE__ end
	macro include(expr) return quote Base.include($(__module__), $(esc(expr))) end end
	
	for sym in (
		:Cvoid, :Cbool, :Csize_t,
		:Cchar, :Cshort, :Cint, :Clong, :Clonglong,
		:Cuchar, :Cushort, :Cuint, :Culong, :Culonglong,
		:Cfloat, :Cdouble, :Clongdouble,
		:Cfunction, :Cconst,
		:STDCALL, :CDECL, :FASTCALL, :THISCALL,
		:Complex, :Ptr, :Tuple, :Vararg, :VecElement,
	)
		@eval macro $(sym)() return quote $($(sym)) end end
	end
	
	
	# provide a temporary placeholder for 128-bit floating point primitive
	primitive type Clongdouble <: AbstractFloat sizeof(Cdouble)*2*8 end
	
	
	abstract type Cstruct end
	abstract type Cunion end
	const Caggregate = Union{Cstruct, Cunion}
	
	abstract type Cenum <: Integer end
	
	const Copaques = Union{Caggregate, Cenum}
	function Base.show(io::IO, ::Type{CO}) where {CO<:Copaques}
		if CO isa DataType
			return Base.show_datatype(io, isabstracttype(CO) ? CO : supertype(CO))
		end
		return invoke(show, Tuple{IO, Type}, io, CO)
	end
	
	struct Cconst{T, S}
		mem::NTuple{S, UInt8}
		
		Cconst{T}(x::NTuple{X, UInt8}) where {T, X} = new{T, sizeof(T)}(x)
	end
	
	
	# alignment strategies
	struct Calignment{SymT}
	end
	
	const ALIGN_NATIVE = Calignment{:native}
	const ALIGN_PACKED = Calignment{:packed}
	
	
	# calling conventions
	struct Cconvention{SymT}
	end
	
	const STDCALL  = Cconvention{:stdcall}
	const CDECL    = Cconvention{:cdecl}
	const FASTCALL = Cconvention{:fastcall}
	const THISCALL = Cconvention{:thiscall}
	
	
	include("ctypespec.jl")
	include("clibrary.jl")
	include("cbindings.jl")
	include("cenum.jl")
	include("carray.jl")
	include("cconst.jl")
	include("caggregate.jl")
	include("cfunction.jl")
	include("cetc.jl")
	include("ctypelayout.jl")
	include("caccessor.jl")
	include("cglobal.jl")
end
