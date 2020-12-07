

@testset "Caccessor + Cconst" begin
	@eval @cstruct CconstStruct {
		i::Cint
		ci::Cconst{Cint}
		
		s::@cstruct {
			i::Cint
			ci::Cconst{Cint}
		}
		
		cs::Cconst{@cstruct {
			i::Cint
			ci::Cconst{Cint}
		}}
		
		u::@cunion {
			i::Cint
			ci::Cconst{Cint}
		}
		
		cu::Cconst{@cunion {
			i::Cint
			ci::Cconst{Cint}
		}}
		
		(as::_[1])::@cstruct {
			i::Cint
			ci::Cconst{Cint}
		}
		
		(acs::_[1])::Cconst{@cstruct {
			i::Cint
			ci::Cconst{Cint}
		}}
		
		@cstruct {
			si::Cint
			sci::Cconst{Cint}
		}
		
		Cconst{@cstruct {
			csi::Cint
			csci::Cconst{Cint}
		}}
		
		@cunion {
			ui::Cint
			uci::Cconst{Cint}
		}
		
		Cconst{@cunion {
			cui::Cint
			cuci::Cconst{Cint}
		}}
	}
	@test sizeof(CconstStruct) == sizeof(Cint)*18
	
	x = CconstStruct(zero)
	@test typeof(x.i) === Cint
	@test typeof(x.ci) === Cint
	@test typeof(x.s) <: Caccessor{<:Cstruct}
	@test typeof(x.s.i) === Cint
	@test typeof(x.s.ci) === Cint
	@test typeof(x.cs) <: Caccessor{<:Cconst{<:Cstruct}}
	@test typeof(x.cs.i) === Cint
	@test typeof(x.cs.ci) === Cint
	@test typeof(x.u) <: Caccessor{<:Cunion}
	@test typeof(x.u.i) === Cint
	@test typeof(x.u.ci) === Cint
	@test typeof(x.cu) <: Caccessor{<:Cconst{<:Cunion}}
	@test typeof(x.cu.i) === Cint
	@test typeof(x.cu.ci) === Cint
	@test typeof(x.as) <: Caccessor{<:Carray{<:Cstruct}}
	@test typeof(x.as[1]) <: Caccessor{<:Cstruct}
	@test typeof(x.as[1].i) === Cint
	@test typeof(x.as[1].ci) === Cint
	@test typeof(x.acs) <: Caccessor{<:Carray{<:Cconst{<:Cstruct}}}
	@test typeof(x.acs[1]) <: Caccessor{<:Cconst{<:Cstruct}}
	@test typeof(x.acs[1].i) === Cint
	@test typeof(x.acs[1].ci) === Cint
	@test typeof(x.si) === Cint
	@test typeof(x.sci) === Cint
	@test typeof(x.csi) === Cint
	@test typeof(x.csci) === Cint
	@test typeof(x.ui) === Cint
	@test typeof(x.uci) === Cint
	@test typeof(x.cui) === Cint
	@test typeof(x.cuci) === Cint
	
	f(x) = 
		x.i + x.ci + 
		x.s.i + x.s.ci + 
		x.cs.i + x.cs.ci + 
		x.u.i + x.u.ci + 
		x.cu.i + x.cu.ci + 
		# x.as[1].i + x.as[1].ci +   # TODO: fix these to not allocate
		# x.acs[1].i + x.acs[1].ci + 
		x.si + x.sci + 
		x.csi + x.csci + 
		x.ui + x.uci + 
		x.cui + x.cuci
	@test f(x) == 0
	@test @allocated(f(x)) == 0
	
	@test x.i == 0
	x.i = 1
	@test x.i == 1
	
	@test x.ci == 0
	@test_throws ErrorException x.ci = 1
	@test x.ci == 0
	
	@test x.s[] == typeof(x.s[])(zero)
	@test x.s.i == 0
	@test x.s.ci == 0
	x.s = typeof(x.s[])(zero, i = 2, ci = 3)
	
	@test x.s.i == 2
	x.s.i = 22
	@test x.s.i == 22
	x.s[].i = 222
	@test x.s.i == 22
	
	@test x.s.ci == 3
	@test_throws ErrorException x.s.ci = 33
	@test x.s.ci == 3
	@test_throws ErrorException x.s[].ci = 333
	@test x.s.ci == 3
	
	@test x.cs[] == typeof(x.cs[])(zero)
	@test x.cs.i == 0
	@test x.cs.ci == 0
	@test_throws ErrorException x.cs = typeof(x.cs[])(zero, i = 4, ci = 5)
	
	@test x.cs.i == 0
	@test_throws ErrorException x.cs.i = 44
	@test x.cs.i == 0
	@test_throws ErrorException x.cs[].i = 444
	@test x.cs.i == 0
	
	@test x.cs.ci == 0
	@test_throws ErrorException x.cs.ci = 55
	@test x.cs.ci == 0
	@test_throws ErrorException x.cs[].ci = 555
	@test x.cs.ci == 0
	
	@test x.u[] == typeof(x.u[])(zero)
	
	@test x.u.i == 0
	x.u = typeof(x.u[])(zero, i = 6)
	@test x.u.i == 6
	x.u.i = 66
	@test x.u.i == 66
	x.u[].i = 666
	@test x.u.i == 66
	
	@test x.u.ci == 66
	x.u = typeof(x.u[])(zero, ci = 7)
	@test x.u.ci == 7
	@test_throws ErrorException x.u.ci = 77
	@test x.u.ci == 7
	@test_throws ErrorException x.u[].ci = 777
	@test x.u.ci == 7
	
	@test x.cu[] == typeof(x.cu[])(zero)
	
	@test x.cu.i == 0
	@test_throws ErrorException x.cu = typeof(x.cu[])(zero, i = 8)
	@test x.cu.i == 0
	@test_throws ErrorException x.cu.i = 88
	@test x.cu.i == 0
	@test_throws ErrorException x.cu[].i = 888
	@test x.cu.i == 0
	
	@test x.cu.ci == 0
	@test_throws ErrorException x.cu = typeof(x.cu[])(zero, ci = 9)
	@test x.cu.ci == 0
	@test_throws ErrorException x.cu.ci = 99
	@test x.cu.ci == 0
	@test_throws ErrorException x.cu[].ci = 999
	@test x.cu.ci == 0
	
	@test x.si == 0
	x.si = 1
	@test x.si == 1
	
	@test x.sci == 0
	@test_throws ErrorException x.sci = 2
	@test x.sci == 0
	
	@test x.csi == 0
	@test_throws ErrorException x.csi = 3
	@test x.csi == 0
	
	@test x.csci == 0
	@test_throws ErrorException x.csci = 4
	@test x.csci == 0
	
	@test x.ui == 0
	x.ui = 5
	@test x.ui == 5
	
	@test x.uci == 5
	@test_throws ErrorException x.uci = 6
	@test x.uci == 5
	
	@test x.cui == 0
	@test_throws ErrorException x.cui = 7
	@test x.cui == 0
	
	@test x.csci == 0
	@test_throws ErrorException x.csci = 8
	@test x.csci == 0
	
	@test f(x) == 51
	
	
	x = Cconst(CconstStruct(zero))
	@test typeof(x.i) === Cint
	@test typeof(x.ci) === Cint
	@test typeof(x.s) <: Caccessor{<:Cconst{<:Cstruct}}
	@test typeof(x.s.i) === Cint
	@test typeof(x.s.ci) === Cint
	@test typeof(x.cs) <: Caccessor{<:Cconst{<:Cstruct}}
	@test typeof(x.cs.i) === Cint
	@test typeof(x.cs.ci) === Cint
	@test typeof(x.u) <: Caccessor{<:Cconst{<:Cunion}}
	@test typeof(x.u.i) === Cint
	@test typeof(x.u.ci) === Cint
	@test typeof(x.cu) <: Caccessor{<:Cconst{<:Cunion}}
	@test typeof(x.cu.i) === Cint
	@test typeof(x.cu.ci) === Cint
	@test typeof(x.as) <: Caccessor{<:Carray{<:Cconst{<:Cstruct}}}
	@test typeof(x.as[1]) <: Caccessor{<:Cconst{<:Cstruct}}
	@test typeof(x.as[1].i) === Cint
	@test typeof(x.as[1].ci) === Cint
	@test typeof(x.acs) <: Caccessor{<:Carray{<:Cconst{<:Cstruct}}}
	@test typeof(x.acs[1]) <: Caccessor{<:Cconst{<:Cstruct}}
	@test typeof(x.acs[1].i) === Cint
	@test typeof(x.acs[1].ci) === Cint
	@test typeof(x.si) === Cint
	@test typeof(x.sci) === Cint
	@test typeof(x.csi) === Cint
	@test typeof(x.csci) === Cint
	@test typeof(x.ui) === Cint
	@test typeof(x.uci) === Cint
	@test typeof(x.cui) === Cint
	@test typeof(x.cuci) === Cint
	
	@test f(x) == 0
	@test @allocated(f(x)) == 0
	
	@test x.i == 0
	@test_throws ErrorException x.i = 1
	@test x.i == 0
	
	@test x.s.i == 0
	@test_throws ErrorException x.s.i = 2
	@test x.s.i == 0
	
	@test x.u.i == 0
	@test_throws ErrorException x.u.i = 3
	@test x.u.i == 0
	
	@test x.si == 0
	@test_throws ErrorException x.si = 4
	@test x.si == 0
	
	@test x.ui == 0
	@test_throws ErrorException x.ui = 5
	@test x.ui == 0
	
	@test f(x) == 0
	@test @allocated(f(x)) == 0
	
	
	@eval @cstruct SelfRef {
		ptr::Ptr{Cconst(SelfRef)}
	}
	@test sizeof(SelfRef) == sizeof(Ptr)
end

