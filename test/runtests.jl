using Test
using Random
using C
using Clang_jll


include("layout-tests.jl")


@testset "C" begin
	include("contexts.jl")
	include("includes.jl")
	include("accessors.jl")
	include("structs.jl")
	include("unions.jl")
	include("enums.jl")
	include("typedefs.jl")
	include("arrays.jl")
	include("externs.jl")
	include("functions.jl")
	include("layouts.jl")
	include("qualifiers.jl")
end

