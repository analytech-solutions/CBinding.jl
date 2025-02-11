

@testset "c\"... (*)(...)\"" begin
	@eval module CBinding_functions
		using CBinding
		c``
		
		c"""
		extern int asprintf(char const **str, char *fmt, ...);
		int jl_ver_major();
		int jl_ver_minor();
		typedef void (*callback)(int, int[]);
		"""
	end
	
	mod = @eval CBinding_functions
	
	asprintf = @eval mod c"asprintf"
	asprintf = asprintf[]  # get pointer to function
	@test eltype(asprintf) <: eltype(@eval mod c"int (*)(char const **, char *, ...)")
	
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
	@test_broken bytes == 0
	@test_throws MethodError asprintf(1234)
	@test_throws MethodError asprintf(1234, "still wrong")
	
	
	f2a = @eval mod c"jl_ver_major"
	f2a = f2a[]
	@test eltype(f2a) <: eltype(@eval mod c"int (*)()")
	@test typeof(f2a()) === Cint
	@test f2a() isa Cint
	@test f2a() == Base.VERSION.major
	@test_throws MethodError f2a("no arguments, please!")
	
	f2b = @eval mod c"jl_ver_minor"
	f2b = f2b[]
	@test eltype(f2b) <: eltype(@eval mod c"int (*)()")
	@test typeof(f2b()) === Cint
	@test f2b() isa Cint
	@test f2b() == Base.VERSION.minor
	@test_throws MethodError f2b("no arguments, please!")
	
	
	function add(val1::Cint, val2::Cint)::Cint
		return val1+val2
	end
	Cadd = (@eval mod c"int (*)(int, int)")(add)
	@test eltype(Cadd) <: eltype(@eval mod c"int (*)(int, int)")
	@test typeof(Cadd(Cint(10), Cint(3))) === typeof(add(Cint(10), Cint(3)))
	@test Cadd(Cint(10), Cint(3)) == add(Cint(10), Cint(3))
	
	
	(@eval mod c"CB" = c"int (*)(int, int)")
	Capply = @eval mod c"int (*)(CB, int, int)"() do func::c"CB", val1::Cint, val2::Cint
		return func(val1, val2)::Cint
	end
	@test eltype(Capply) <: eltype(@eval mod c"int (*)(CB, int, int)")
	@test typeof(Capply(Cadd, Cint(10), Cint(3))) === typeof(add(Cint(10), Cint(3)))
	@test Capply(Cadd, Cint(10), Cint(3)) == add(Cint(10), Cint(3))
	
	
	# https://github.com/analytech-solutions/CBinding.jl/issues/97
	callback = @eval mod c"callback"
	@test eltype(callback) <: Cfunction{Cvoid, Tuple{Cint, Cptr{Cint}}}
	@test eltype(@eval mod c"void (*)(int, int[])") <: Cfunction{Cvoid, Tuple{Cint, Cptr{Cint}}}
	@test eltype(callback) <: eltype(@eval mod c"void (*)(int, int[])")
end

