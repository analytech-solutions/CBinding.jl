

@testset "Cfunction" begin
	lib = Clibrary()
	
	if !Sys.iswindows()
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
	
	f2 = Cfunction{Clong, Tuple{}}(lib, :jl_gc_total_bytes)
	@test eltype(f2) <: Cfunction{Clong, Tuple{}}
	@test typeof(f2()) === Clong
	@test f2() isa Clong
	@test_throws MethodError f2("no arguments, please!")
	
	if !Sys.iswindows()
		f3 = Cfunction{Cint, Tuple{Ptr{Cchar}, Cstring, Vararg}}(lib, :sprintf)
		@test eltype(f3) <: Cfunction{Cint, Tuple{Ptr{Cchar}, Cstring, Vararg}}
		str = zeros(Cchar, 100)
		@test typeof(f3(str, "")) === Cint
		@test f3(str, "%s %ld\n", "testing printf", 1234) == 20
		@test unsafe_string(pointer(str)) == "testing printf 1234\n"
		@test f3(str, "%s i%c %ld great test of CBinding.jl v%3.1lf%c\n", "This", 's', 1, 0.1, '!') == length("This is 1 great test of CBinding.jl v0.1!\n")
		@test unsafe_string(pointer(str)) == "This is 1 great test of CBinding.jl v0.1!\n"
		@test_throws MethodError f3(1234)
		@test_throws MethodError f3(1234, "still wrong")
	end
	
	(Cadd, add) = Cfunction{Cint, Tuple{Cint, Cint}}() do val1, val2
		return val1+val2
	end
	@test eltype(Cadd) <: Cfunction{Cint, Tuple{Cint, Cint}}
	@test eltype(Cadd) === Cfunction{Cint, Tuple{Cint, Cint}, CBinding.default_convention(Tuple{Cint, Cint})}
	@test typeof(add.f) <: Function
	@test typeof(Cadd(Cint(10), Cint(3))) === typeof(add.f(Cint(10), Cint(3)))
	@test Cadd(Cint(10), Cint(3)) == add.f(Cint(10), Cint(3))
	
	if !Sys.iswindows()
		@cstruct time_t {
			val::Clong
		}
		@cstruct tm {
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
		localtime = Cfunction{Ptr{tm}, Tuple{Ptr{time_t}}}(lib, :localtime)
		
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

