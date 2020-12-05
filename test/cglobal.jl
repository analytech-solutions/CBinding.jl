

@testset "Cglobal" begin
	lib = Clibrary()
	
	if !Sys.iswindows() || !(VERSION >= v"1.6-")
		val = Cglobal{Ptr{Cvoid}}(lib, :jl_nothing)
		@test val.handle != C_NULL
		@test val[] == unsafe_load(cglobal(:jl_nothing, Ptr{Cvoid}))
	end
end

