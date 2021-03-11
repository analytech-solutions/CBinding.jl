

@testset "c`...`" begin
	@eval c``
	@test haskey(C.CONTEXT_CACHE, @__MODULE__)
	ctx = C.CONTEXT_CACHE[@__MODULE__]
	@test ctx isa C.Context{:c}
	@test length(ctx.libs) == 1  # the julia process is the only lib
	
	@eval begin
		lib = startswith(Base.libm_name, "lib") ? Base.libm_name[4:end] : Base.libm_name
		libpath = normpath(joinpath(dirname(Base.julia_cmd().exec[1]), Base.LIBDIR, "julia"))
		c`-L$(libpath) -l$(lib)`
	end
	@test ctx !== C.CONTEXT_CACHE[@__MODULE__]
	ctx = C.CONTEXT_CACHE[@__MODULE__]
	@test ctx isa C.Context{:c}
	@test length(ctx.libs) == 2
end

