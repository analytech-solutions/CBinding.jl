module CBinding
	import Libdl
	using CEnum: @cenum
	using Todo: @todo_str
	
	
	export Clongdouble, Caggregate, Cstruct, Cunion, Carray, Caccessor, Clibrary, Cglobal, Cglobalconst, Cfunction
	export @ctypedef, @cstruct, @cunion, @carray, @calign, @cenum
	
	
	# provide a temporary placeholder for 128-bit floating point primitive
	primitive type Clongdouble <: AbstractFloat sizeof(Cdouble)*2*8 end
	
	
	abstract type Caggregate end
	abstract type Cstruct <: Caggregate end
	abstract type Cunion <: Caggregate end
	
	include("caggregate.jl")
	include("clibrary.jl")
	include("cglobal.jl")
	include("cfunction.jl")
end
