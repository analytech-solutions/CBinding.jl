

@testset "c\"... (*)(...)\"" begin
	@eval c``
	
	asprintf = @eval c"extern int asprintf(char const **str, char *fmt, ...);"
	asprintf = asprintf[]  # get pointer to function
	@test eltype(asprintf) <: eltype(c"int (*)(char const **, char *, ...)")
	
	f(x) = asprintf(x, "%s i%c %d great test of CBinding.jl v%3.1f%c\n", "This", 's', 0x01, 0.1, '!')
	str = Ref(c"char const *"(C_NULL))
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
	
	
	f2a = @eval c"int jl_ver_major();"
	f2a = f2a[]
	@test eltype(f2a) <: eltype(c"int (*)()")
	@test typeof(f2a()) === Cint
	@test f2a() isa Cint
	@test f2a() == Base.VERSION.major
	@test_throws MethodError f2a("no arguments, please!")
	
	f2b = @eval c"int jl_ver_minor();"
	f2b = f2b[]
	@test eltype(f2b) <: eltype(c"int (*)()")
	@test typeof(f2b()) === Cint
	@test f2b() isa Cint
	@test f2b() == Base.VERSION.minor
	@test_throws MethodError f2b("no arguments, please!")
	
	
	function add(val1::Cint, val2::Cint)::Cint
		return val1+val2
	end
	Cadd = c"int (*)(int, int)"(add)
	@test eltype(Cadd) <: eltype(c"int (*)(int, int)")
	@test typeof(Cadd(Cint(10), Cint(3))) === typeof(add(Cint(10), Cint(3)))
	@test Cadd(Cint(10), Cint(3)) == add(Cint(10), Cint(3))
	
	
	c"CB" = c"int (*)(int, int)"
	Capply = c"int (*)(CB, int, int)"() do func::c"CB", val1::Cint, val2::Cint
		return func(val1, val2)::Cint
	end
	@test eltype(Capply) <: eltype(c"int (*)(CB, int, int)")
	@test typeof(Capply(Cadd, Cint(10), Cint(3))) === typeof(add(Cint(10), Cint(3)))
	@test Capply(Cadd, Cint(10), Cint(3)) == add(Cint(10), Cint(3))
end

