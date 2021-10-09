

@testset "c\"#include ...\"" begin
	@eval c`-I$(@__DIR__)`
	ctx = CBinding.CONTEXT_CACHE[@__MODULE__]
	
	@test length(ctx.hdrs) == 0
	@eval c"""
	#include <stddef.h>
	"""u
	@test length(ctx.hdrs) == 1
	@eval c"""
	#include "test.h"
	"""iuq
	@test length(ctx.hdrs) == 1
	@eval c"""
	#include <stdalign.h>
	"""su
	@test length(ctx.hdrs) == 0
	
	str = String(take!(ctx.src))
	@test occursin("<stddef.h>", str)
	@test occursin("\"test.h\"", str)
	@test occursin("<stdalign.h>", str)
end

