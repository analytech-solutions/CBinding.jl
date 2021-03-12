

@testset "c\"#include ...\"" begin
	@eval c`-I$(@__DIR__)`
	ctx = C.CONTEXT_CACHE[@__MODULE__]
	
	@test length(ctx.hdrs) == 0
	@eval c"""
	#include <stddef.h>
	"""
	@test length(ctx.hdrs) == 1
	@eval c"""
	#include "test.h"
	"""i
	@test length(ctx.hdrs) == 1
	@eval c"""
	#include <inttypes.h>
	"""s
	@test length(ctx.hdrs) == 0
	
	str = String(take!(ctx.src))
	@test occursin("<stddef.h>", str)
	@test occursin("\"test.h\"", str)
	@test occursin("<inttypes.h>", str)
end

