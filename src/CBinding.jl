module CBinding
	import Libdl
	using CEnum: @cenum
	using Todo: @todo_str
	
	
	export Clongdouble, Caggregate, Cstruct, Cunion, Carray, Caccessor, Clibrary, Cglobal, Cglobalconst, Cfunction
	export @ctypedef, @cstruct, @cunion, @carray, @calign, @cenum
	
	
	# provide a temporary placeholder for 128-bit floating point primitive
	mutable struct Clongdouble <: AbstractFloat
		mem::NTuple{2*sizeof(Cdouble), UInt8}
		
		Clongdouble() = new()
	end
	
	
	include("caggregate.jl")
	include("clibrary.jl")
	include("cglobal.jl")
	include("cfunction.jl")
end
