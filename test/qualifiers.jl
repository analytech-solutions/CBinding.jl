

@testset "type qualifiers" begin
	c``
	
	@eval c"""
	struct CconstStruct {
		int i;
		int const ci;
		
		struct {
			int i;
			int const ci;
		} s;
		
		struct {
			int i;
			int const ci;
		} const cs;
		
		union {
			int i;
			int const ci;
		} u;
		
		union {
			int i;
			int const ci;
		} const cu;
		
		
		struct {
			int i;
			int const ci;
		} as[1];
		
		struct {
			int i;
			int const ci;
		} const acs[1];
		
		struct {
			int si;
			int const sci;
		};
		
		union {
			int ui;
			int const uci;
		};
	};
	"""
	@test sizeof(c"struct CconstStruct") == sizeof(Cint)*(2*6+3)
	
	x = c"struct CconstStruct"()
	@test x.i isa Cint
	@test x.ci isa Cint
	@test x.s isa Cstruct
	@test x.s.i isa Cint
	@test x.s.ci isa Cint
	@test x.cs isa Cstruct
	@test x.cs.i isa Cint
	@test x.cs.ci isa Cint
	@test x.u isa Cunion
	@test x.u.i isa Cint
	@test x.u.ci isa Cint
	@test x.cu isa Cunion
	@test x.cu.i isa Cint
	@test x.cu.ci isa Cint
	@test x.as isa Carray{<:Cstruct, 1}
	@test x.as[1] isa Cstruct
	@test x.as[1].i isa Cint
	@test x.as[1].ci isa Cint
	@test x.acs isa Carray{<:Cstruct, 1}
	@test x.acs[1] isa Cstruct
	@test x.acs[1].i isa Cint
	@test x.acs[1].ci isa Cint
	@test x.si isa Cint
	@test x.sci isa Cint
	@test x.ui isa Cint
	@test x.uci isa Cint
	
	ptr = Libc.malloc(x)
	@test eltype(ptr.i) <: Cint
	@test eltype(ptr.ci) <: Cconst{Cint}
	@test eltype(ptr.s) <: Cstruct
	@test eltype(ptr.s.i) <: Cint
	@test eltype(ptr.s.ci) <: Cconst{Cint}
	@test eltype(ptr.cs) <: Cconst{<:Cstruct}
	@test eltype(ptr.cs.i) <: Cconst{Cint}
	@test eltype(ptr.cs.ci) <: Cconst{Cint}
	@test eltype(ptr.u) <: Cunion
	@test eltype(ptr.u.i) <: Cint
	@test eltype(ptr.u.ci) <: Cconst{Cint}
	@test eltype(ptr.cu) <: Cconst{<:Cunion}
	@test eltype(ptr.cu.i) <: Cconst{Cint}
	@test eltype(ptr.cu.ci) <: Cconst{Cint}
	@test eltype(ptr.as) <: Carray{<:Cstruct, 1}
	@test eltype(ptr.as[1]) <: Cstruct
	@test eltype(ptr.as[1].i) <: Cint
	@test eltype(ptr.as[1].ci) <: Cconst{Cint}
	@test eltype(ptr.acs) <: Carray{<:Cconst{<:Cstruct}, 1}
	@test eltype(ptr.acs[1]) <: Cconst{<:Cstruct}
	@test eltype(ptr.acs[1].i) <: Cconst{Cint}
	@test eltype(ptr.acs[1].ci) <: Cconst{Cint}
	@test eltype(ptr.si) <: Cint
	@test eltype(ptr.sci) <: Cconst{Cint}
	@test eltype(ptr.ui) <: Cint
	@test eltype(ptr.uci) <: Cconst{Cint}
	
	cptr = reinterpret(Cptr{Cconst{eltype(ptr)}}, ptr)
	@test eltype(cptr.i) <: Cconst{Cint}
	@test eltype(cptr.ci) <: Cconst{Cint}
	@test eltype(cptr.s) <: Cconst{<:Cstruct}
	@test eltype(cptr.s.i) <: Cconst{Cint}
	@test eltype(cptr.s.ci) <: Cconst{Cint}
	@test eltype(cptr.cs) <: Cconst{<:Cstruct}
	@test eltype(cptr.cs.i) <: Cconst{Cint}
	@test eltype(cptr.cs.ci) <: Cconst{Cint}
	@test eltype(cptr.u) <: Cconst{<:Cunion}
	@test eltype(cptr.u.i) <: Cconst{Cint}
	@test eltype(cptr.u.ci) <: Cconst{Cint}
	@test eltype(cptr.cu) <: Cconst{<:Cunion}
	@test eltype(cptr.cu.i) <: Cconst{Cint}
	@test eltype(cptr.cu.ci) <: Cconst{Cint}
	@test eltype(cptr.as) <: Cconst{<:Carray{<:Cstruct, 1}}
	@test eltype(cptr.as[1]) <: Cconst{<:Cstruct}
	@test eltype(cptr.as[1].i) <: Cconst{Cint}
	@test eltype(cptr.as[1].ci) <: Cconst{Cint}
	@test eltype(cptr.acs) <: Cconst{<:Carray{<:Cconst{<:Cstruct}, 1}}
	@test eltype(cptr.acs[1]) <: Cconst{<:Cstruct}
	@test eltype(cptr.acs[1].i) <: Cconst{Cint}
	@test eltype(cptr.acs[1].ci) <: Cconst{Cint}
	@test eltype(cptr.si) <: Cconst{Cint}
	@test eltype(cptr.sci) <: Cconst{Cint}
	@test eltype(cptr.ui) <: Cconst{Cint}
	@test eltype(cptr.uci) <: Cconst{Cint}
	
	@test ptr.i+1 == ptr.ci
	@test ptr.s+1 == ptr.cs
	@test ptr.i+6 == ptr.u.i
	@test ptr.u.i-6 == ptr.i
	
	f(p) = 
		p.i[] + p.ci[] +
		p.s.i[] + p.s.ci[] +
		p.cs.i[] + p.cs.ci[] +
		p.u.i[] + p.u.ci[] +
		p.cu.i[] + p.cu.ci[] +
		p.as[1].i[] + p.as[1].ci[] +
		p.acs[1].i[] + p.acs[1].ci[] +
		p.si[] + p.sci[] +
		p.ui[] + p.uci[]
	@test f(ptr) == 0
	@test @allocated(f(ptr)) == 0
	
	@test ptr.i[] == 0
	ptr.i[] = 1
	@test ptr.i[] == 1
	
	@test ptr.ci[] == 0
	@test_throws ErrorException ptr.ci[] = 1
	@test ptr.ci[] == 0
	
	@test ptr.s[] == eltype(ptr.s)()
	@test ptr.s.i[] == 0
	@test ptr.s.ci[] == 0
	ptr.s[] = eltype(ptr.s)(i = 2, ci = 3)
	
	@test ptr.s.i[] == 2
	ptr.s.i[] = 22
	@test ptr.s.i[] == 22
	@test_throws ErrorException ptr.s[].i = 222
	@test ptr.s.i[] == 22
	
	@test ptr.s.ci[] == 3
	@test_throws ErrorException ptr.s.ci[] = 33
	@test ptr.s.ci[] == 3
	@test_throws ErrorException ptr.s[].ci = 333
	@test ptr.s.ci[] == 3
	
	@test ptr.cs[] == unqualifiedtype(eltype(ptr.cs))()
	@test ptr.cs.i[] == 0
	@test ptr.cs.ci[] == 0
	@test_throws ErrorException ptr.cs[] = unqualifiedtype(eltype(ptr.cs))(i = 4, ci = 5)
	
	@test ptr.cs.i[] == 0
	@test_throws ErrorException ptr.cs.i[] = 44
	@test ptr.cs.i[] == 0
	@test_throws ErrorException ptr.cs[].i = 444
	@test ptr.cs.i[] == 0
	
	@test ptr.cs.ci[] == 0
	@test_throws ErrorException ptr.cs.ci[] = 55
	@test ptr.cs.ci[] == 0
	@test_throws ErrorException ptr.cs[].ci = 555
	@test ptr.cs.ci[] == 0
	
	@test ptr.u[] == eltype(ptr.u)()
	
	@test ptr.u.i[] == 0
	ptr.u[] = eltype(ptr.u)(i = 6)
	@test ptr.u.i[] == 6
	ptr.u.i[] = 66
	@test ptr.u.i[] == 66
	ptr.u.i[] = 666
	@test ptr.u.i[] == 666
	
	@test ptr.u.ci[] == 666
	ptr.u[] = eltype(ptr.u)(ci = 7)
	@test ptr.u.ci[] == 7
	@test_throws ErrorException ptr.u.ci[] = 77
	@test ptr.u.ci[] == 7
	@test_throws ErrorException ptr.u[].ci = 777
	@test ptr.u.ci[] == 7
	
	@test ptr.cu[] == unqualifiedtype(eltype(ptr.cu))()
	
	@test ptr.cu.i[] == 0
	@test_throws ErrorException ptr.cu[] = unqualifiedtype(eltype(ptr.cu))(i = 8)
	@test ptr.cu.i[] == 0
	@test_throws ErrorException ptr.cu.i[] = 88
	@test ptr.cu.i[] == 0
	@test_throws ErrorException ptr.cu.i[] = 888
	@test ptr.cu.i[] == 0
	
	@test ptr.cu.ci[] == 0
	@test_throws ErrorException ptr.cu[] = unqualifiedtype(eltype(ptr.cu))(ci = 9)
	@test ptr.cu.ci[] == 0
	@test_throws ErrorException ptr.cu.ci[] = 99
	@test ptr.cu.ci[] == 0
	@test_throws ErrorException ptr.cu[].ci = 999
	@test ptr.cu.ci[] == 0
	
	@test ptr.si[] == 0
	ptr.si[] = 1
	@test ptr.si[] == 1
	
	@test ptr.sci[] == 0
	@test_throws ErrorException ptr.sci[] = 2
	@test ptr.sci[] == 0
	
	@test ptr.ui[] == 0
	ptr.ui[] = 5
	@test ptr.ui[] == 5
	
	@test ptr.uci[] == 5
	@test_throws ErrorException ptr.uci[] = 6
	@test ptr.uci[] == 5
	
	@test f(ptr) == 51
	@test f(cptr) == 51
	@test_throws ErrorException cptr[] = x
	ptr[] = x
	@test f(cptr) == 0
	@test @allocated(f(cptr)) == 0
	
	@test cptr.i[] == 0
	@test_throws ErrorException cptr.i[] = 1
	@test cptr.i[] == 0
	
	@test cptr.s.i[] == 0
	@test_throws ErrorException cptr.s.i[] = 2
	@test cptr.s.i[] == 0
	
	@test cptr.u.i[] == 0
	@test_throws ErrorException cptr.u.i[] = 3
	@test cptr.u.i[] == 0
	
	@test cptr.si[] == 0
	@test_throws ErrorException cptr.si[] = 4
	@test cptr.si[] == 0
	
	@test cptr.ui[] == 0
	@test_throws ErrorException cptr.ui[] = 5
	@test cptr.ui[] == 0
	
	@test f(cptr) == 0
	@test @allocated(f(cptr)) == 0
	
	@eval c"""
	struct SelfRef {
		struct SelfRef *ptr;
	};
	"""
	@test sizeof(c"struct SelfRef") == sizeof(Cptr)
	
	Libc.free(ptr)
end

