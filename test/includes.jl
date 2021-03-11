

@testset "c\"#include ...\"" begin
	@eval c``
	ctx = C.CONTEXT_CACHE[@__MODULE__]
	
	@test length(ctx.hdrs) == 1
	@eval c"""
	#include <stddef.h>
	"""
	@test length(ctx.hdrs) == 2
	@eval c"""
	#include <stdalign.h>
	#include <stddef.h>
	"""
	@test length(ctx.hdrs) == 4
	@eval c"""
	#include <inttypes.h>
	"""s
	@test length(ctx.hdrs) == 4
	
	str = String(take!(ctx.src))
	@test occursin("<stddef.h>", str)
	@test occursin("<stdalign.h>", str)
	@test occursin("<inttypes.h>", str)
end

