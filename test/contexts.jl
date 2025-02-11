

@testset "c`...`" begin
	@eval module CBinding_contexts_1
		using CBinding
		c``
	end
	
	@eval module CBinding_contexts_2
		using CBinding
		lib = startswith(Base.libm_name, "lib") ? Base.libm_name[4:end] : Base.libm_name
		libpath = normpath(joinpath(dirname(Base.julia_cmd().exec[1]), Base.LIBDIR, "julia"))
		c`-L$(libpath) -l$(lib)`
	end
	
	
	mod = @eval CBinding_contexts_1
	cache = mod.CBinding.CONTEXT_CACHE
	@test haskey(cache, mod)
	ctx = cache[mod]
	@test ctx isa CBinding.Context{:c}
	@test length(ctx.libs) == 1  # the julia process is the only lib
	
	mod = @eval CBinding_contexts_2
	cache = mod.CBinding.CONTEXT_CACHE
	@test ctx !== cache[mod]
	ctx = cache[mod]
	@test ctx isa CBinding.Context{:c}
	@test length(ctx.libs) == 2
end

