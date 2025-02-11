

@testset "c\"extern ...\"" begin
	@eval module CBinding_externs
		using CBinding
		c``
		
		c"""
		extern int asprintf(char const **str, char *fmt, ...);
		"""
	end
	
	mod = @eval CBinding_externs
	
	asprintf = @eval mod c"asprintf"
	f(x) = asprintf(x, "%s i%c %d great test of CBinding.jl v%3.1f%c\n", "This", 's', 0x01, 0.1, '!')
	str = Ref((@eval mod c"char const *")(C_NULL))
	expect = "This is 1 great test of CBinding.jl v0.1!\n"
	bytes = 0
	for i in 1:100
		b = @allocated len = f(str)
		bytes += i > 1 ? b : 0
		@test len == length(expect)
		@test unsafe_string(str[]) == expect
		Libc.free(str[])
		str[] = C_NULL
	end
	@test bytes == 0
	@test_throws MethodError asprintf(1234)
	@test_throws MethodError asprintf(1234, "still wrong")
	
	
	# TODO: add test for accessing libjulia global functions and variables
end

