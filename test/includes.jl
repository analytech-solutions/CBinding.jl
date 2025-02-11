

@testset "c\"#include ...\"" begin
	@eval module CBinding_includes_1
		using CBinding
		c`-I$(@__DIR__)`
	end
	
	@eval module CBinding_includes_2
		using CBinding
		c`-I$(@__DIR__)`
		c"""
		#include <stddef.h>
		"""u
	end
	
	@eval module CBinding_includes_3
		using CBinding
		c`-I$(@__DIR__)`
		c"""
		#include "test.h"
		"""iuq
	end
	
	@eval module CBinding_includes_4
		using CBinding
		c`-I$(@__DIR__)`
		c"""
		#include <stdalign.h>
		"""su
	end
	
	
	mod = @eval CBinding_includes_1
	cache = mod.CBinding.CONTEXT_CACHE
	ctx = cache[mod]
	@test length(ctx.hdrs) == 0
	
	mod = @eval CBinding_includes_2
	cache = mod.CBinding.CONTEXT_CACHE
	ctx = cache[mod]
	@test length(ctx.hdrs) == 1
	str = String(take!(ctx.src))
	@test occursin("<stddef.h>", str)
	
	mod = @eval CBinding_includes_3
	cache = mod.CBinding.CONTEXT_CACHE
	ctx = cache[mod]
	@test length(ctx.hdrs) == 1
	str = String(take!(ctx.src))
	@test occursin("\"test.h\"", str)
	@test !occursin("<stddef.h>", str)
	@test !occursin("<stdalign.h>", str)
	
	mod = @eval CBinding_includes_4
	cache = mod.CBinding.CONTEXT_CACHE
	ctx = cache[mod]
	@test length(ctx.hdrs) == 0
	str = String(take!(ctx.src))
	@test !occursin("\"test.h\"", str)
	@test occursin("<stdalign.h>", str)
end

