

@testset "Clibrary" begin
	lib1 = Clibrary()
	lib2 = Clibrary()
	@test lib1.handle != C_NULL
	@test lib1 == lib2
	
	lib3 = Clibrary(Base.libm_name)
	lib4 = Clibrary(Base.libm_name)
	@test lib3.handle != C_NULL
	@test lib3 == lib4
	
	@test lib1 != lib3
end

