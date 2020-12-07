

@testset "Cfunction" begin
	lib = Clibrary()
	
	if !Sys.iswindows() && sizeof(Clong) != sizeof(Cint)
		f1 = Cfunction{Clong, Tuple{Ptr{Clong}}}(lib, :time)
		@test eltype(f1) <: Cfunction{Clong, Tuple{Ptr{Clong}}}
		@test typeof(f1(C_NULL)) === Clong
		@test f1(C_NULL) isa Clong
		@test_throws MethodError f1(0)
		
		before = f1(C_NULL)
		sleep(3)
		after = f1(C_NULL)
		@test before < after
	end
	
	f2a = Cfunction{Cint, Tuple{}}(lib, :jl_ver_major)
	@test eltype(f2a) <: Cfunction{Cint, Tuple{}}
	@test typeof(f2a()) === Cint
	@test f2a() isa Cint
	@test f2a() == Base.VERSION.major
	@test_throws MethodError f2a("no arguments, please!")
	
	f2b = Cfunction{Cint, Tuple{}}(lib, :jl_ver_minor)
	@test eltype(f2b) <: Cfunction{Cint, Tuple{}}
	@test typeof(f2b()) === Cint
	@test f2b() isa Cint
	@test f2b() == Base.VERSION.minor
	@test_throws MethodError f2b("no arguments, please!")
	
	f3 = Cfunction{Cint, Tuple{Ptr{Ptr{Cchar}}, Cstring, Vararg}}(lib, :asprintf)
	@test eltype(f3) <: Cfunction{Cint, Tuple{Ptr{Ptr{Cchar}}, Cstring, Vararg}}
	str = Ref(Ptr{Cchar}(C_NULL))
	len = f3(str, "%s i%c %d great test of CBinding.jl v%3.1f%c\n", "This", 's', 0x01, 0.1, '!')
	expect = "This is 1 great test of CBinding.jl v0.1!\n"
	@test len == length(expect)
	@test unsafe_string(str[]) == expect
	Libc.free(str[])
	@test_throws MethodError f3(1234)
	@test_throws MethodError f3(1234, "still wrong")
	
	(Cadd, add) = Cfunction{Cint, Tuple{Cint, Cint}}() do val1, val2
		return val1+val2
	end
	@test eltype(Cadd) <: Cfunction{Cint, Tuple{Cint, Cint}}
	@test eltype(Cadd) === Cfunction{Cint, Tuple{Cint, Cint}, CBinding.default_convention(Tuple{Cint, Cint})}
	@test typeof(add.f) <: Function
	@test typeof(Cadd(Cint(10), Cint(3))) === typeof(add.f(Cint(10), Cint(3)))
	@test Cadd(Cint(10), Cint(3)) == add.f(Cint(10), Cint(3))
	
	if !Sys.iswindows() && sizeof(Clong) != sizeof(Cint)
		@eval @cstruct time_t {
			val::Clong
		}
		@eval @cstruct tm {
			sec::Cint
			min::Cint
			hour::Cint
			mday::Cint
			mon::Cint
			year::Cint
			wday::Cint
			yday::Cint
			isdst::Cint
		}
		time = Cfunction{time_t, Tuple{Ptr{time_t}}}(lib, :time)
		localtime = Cfunction{Ptr{tm}, Tuple{Ptr{Cconst(time_t)}}}(lib, :localtime)
		
		t = Ref(time_t(zero))
		@test t[].val == 0
		time(t)
		@test t[].val != 0
		
		p = localtime(t)
		@test p isa Ptr
		@test p != C_NULL
		
		x = unsafe_load(p)
		@test 2000 < 1900+x.year < 2100  # if this package is still around in 2100...
		
		mktime = Cfunction{time_t, Tuple{Ptr{tm}}}(lib, :mktime)
		u = mktime(p)
		@test u.val == t[].val
	end
end

