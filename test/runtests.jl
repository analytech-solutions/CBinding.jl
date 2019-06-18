using Test: @testset, @test, @test_throws
using CBinding


@testset "CBinding" begin
	@testset "@cstruct" begin
		@cstruct EmptyStruct {
		}
		@test sizeof(EmptyStruct) == 0
		
		@cstruct CcharStruct {
			c::Cchar
		}
		@test sizeof(CcharStruct) == sizeof(Cchar)
		@test :c in propertynames(CcharStruct)
		
		@cstruct CintStruct {
			i::Cint
		}
		@test sizeof(CintStruct) == sizeof(Cint)
		@test :i in propertynames(CintStruct)
		
		@cstruct CstructStruct {
			i::CintStruct
		}
		@test sizeof(CstructStruct) == sizeof(CintStruct)
		@test :i in propertynames(CstructStruct)
		
		@cstruct CintCcharStruct {
			i::CintStruct
			c::CcharStruct
		}
		@test sizeof(CintCcharStruct) == sizeof(CintStruct)+sizeof(CcharStruct)
		@test :i in propertynames(CintCcharStruct)
		@test :c in propertynames(CintCcharStruct)
		
		@cstruct CcharCintPackedStruct {
			c::CcharStruct
			i::CintStruct
		}
		@test sizeof(CcharCintPackedStruct) == sizeof(CintStruct)+sizeof(CcharStruct)
		@test :c in propertynames(CcharCintPackedStruct)
		@test :i in propertynames(CcharCintPackedStruct)
		
		@cstruct CcharCintAlignedStruct {
			c::CcharStruct
			@calign sizeof(CintStruct)
			i::CintStruct
		}
		@test sizeof(CcharCintAlignedStruct) == max(sizeof(CintStruct), sizeof(Cint))+max(sizeof(CcharStruct), sizeof(Cint))
		@test :c in propertynames(CcharCintAlignedStruct)
		@test :i in propertynames(CcharCintAlignedStruct)
		
		@cstruct CunionStruct {
			@cunion {
				c::Cchar[4]
				s::Cshort[2]
				i::Cint
			}
		}
		@test :c in propertynames(CunionStruct)
		@test :s in propertynames(CunionStruct)
		@test :i in propertynames(CunionStruct)
		
		@cstruct PtrToStructStruct {
			p::Ptr{PtrToStructStruct}
		}
		@test sizeof(PtrToStructStruct) == sizeof(Ptr)
		@test :p in propertynames(PtrToStructStruct)
	end
	
	
	@testset "@cunion" begin
		@cunion EmptyUnion {
		}
		@test sizeof(EmptyUnion) == 0
		
		@cunion CcharUnion {
			c::Cchar
		}
		@test sizeof(CcharUnion) == sizeof(Cchar)
		@test :c in propertynames(CcharUnion)
		
		@cunion CintUnion {
			i::Cint
		}
		@test sizeof(CintUnion) == sizeof(Cint)
		@test :i in propertynames(CintUnion)
		
		@cunion CunionUnion {
			i::CintUnion
		}
		@test sizeof(CunionUnion) == sizeof(CintUnion)
		@test :i in propertynames(CunionUnion)
		
		@cunion CintCcharUnion {
			i::CintUnion
			c::CcharUnion
		}
		@test sizeof(CintCcharUnion) == max(sizeof(CintUnion), sizeof(CcharUnion))
		@test :i in propertynames(CintCcharUnion)
		@test :c in propertynames(CintCcharUnion)
		
		@cunion CcharCintPackedUnion {
			c::CcharUnion
			i::CintUnion
		}
		@test sizeof(CcharCintPackedUnion) == max(sizeof(CintUnion), sizeof(CcharUnion))
		@test :c in propertynames(CcharCintPackedUnion)
		@test :i in propertynames(CcharCintPackedUnion)
		
		@cunion CcharCintAlignedUnion {
			c::CcharUnion
			@calign sizeof(CintUnion)
			i::CintUnion
		}
		@test sizeof(CcharCintAlignedUnion) == max(max(sizeof(CintUnion), sizeof(Cint)), max(sizeof(CcharUnion), sizeof(Cint)))
		@test :c in propertynames(CcharCintAlignedUnion)
		@test :i in propertynames(CcharCintAlignedUnion)
		
		@cunion CunionUnion {
			@cunion {
				c::Cuchar[4]
				s::Cushort[2]
				i::Cuint
			}
		}
		@test :c in propertynames(CunionUnion)
		@test :s in propertynames(CunionUnion)
		@test :i in propertynames(CunionUnion)
		
		@cunion PtrToUnionUnion {
			p::Ptr{PtrToUnionUnion}
		}
		@test sizeof(PtrToUnionUnion) == sizeof(Ptr)
		@test :p in propertynames(PtrToUnionUnion)
		
		cuu = CunionUnion()
		@test cuu.i == 0
		@test cuu.c[1] == 0
		@test cuu.c[4] == 0
		@test cuu.s[1] == 0
		@test cuu.s[2] == 0
		cuu.i = 0xff0000ff
		@test cuu.i == 0xff0000ff
		@test cuu.c[1] == 0xff
		@test cuu.c[4] == 0xff
		@test cuu.s[1] != 0
		@test cuu.s[2] != 0
	end
	
	
	@testset "@carray" begin
		CcharArray = @carray Cchar[2]
		@test sizeof(CcharArray) == sizeof(Cchar)*2
		
		CstructArray = @carray (@cstruct {
			i::Cint
		})[10]
		@test sizeof(CstructArray) == sizeof(Cint)*10
		
		@cstruct CStruct {
			i::Cint
		}
		CStructArray = @carray CStruct[2]
		@test sizeof(CStructArray) == sizeof(Cint)*2
		
		@cstruct Opaque
		PtrArray = @carray Ptr{Opaque}[3]
		@test sizeof(PtrArray) == sizeof(Ptr)*3
		
		pa = PtrArray(undef)
		@test sizeof(pa) == sizeof(Ptr)*3
		@test length(pa) == 3
		@test eltype(pa) === Ptr{Opaque}
		@test pa[1] isa Ptr{Opaque}
		
		for i in eachindex(pa)
			pa[i] = C_NULL
			@test pa[i] == C_NULL
			pa[i] = Ptr{Opaque}(1)
			@test pa[i] != C_NULL
		end
		
		pa = PtrArray()
		for ptr in pa
			@test ptr == C_NULL
		end
		
		ca = CStructArray()
		@test length(ca) == 2
		@test eltype(ca) === CStruct
		@test ca[2] isa Caccessor{CStruct}
		
		CarrayArray = @carray Cint[4][2]
		@test sizeof(CarrayArray) == sizeof(Cint)*4*2
		@test eltype(CarrayArray) === @carray Cint[4]
		@test eltype(eltype(CarrayArray)) === Cint
		
		ca = CarrayArray()
		@test length(ca) == 2
		@test length(ca[1]) == 4
		for i in eachindex(ca), j in eachindex(ca[i])
			@test ca[i] isa Caccessor{@carray Cint[4]}
			@test ca[i][j] == 0
		end
	end
	
	
	@testset "@ctypedef" begin
		@eval @ctypedef EmptyStructTypedef @cstruct {
		}
		@test sizeof(EmptyStructTypedef) == 0
		
		@eval @ctypedef CcharStructTypedef @cstruct {
			c::Cchar
		}
		@test sizeof(CcharStructTypedef) == sizeof(Cchar)
		@test :c in propertynames(CcharStructTypedef)
		
		@eval @ctypedef CintUnionTypedef @cunion {
			i::Cint
		}
		@test sizeof(CintUnionTypedef) == sizeof(Cint)
		@test :i in propertynames(CintUnionTypedef)
		
		@eval @ctypedef CuintArrayTypedef Cuint[32]
		@test sizeof(CuintArrayTypedef) == sizeof(Cuint)*32
		
		@eval @ctypedef CintTypedef Cint
		@test sizeof(CintTypedef) == sizeof(Cint)
	end
	
	
	@testset "Clibrary" begin
	end
	
	
	@testset "Cglobal + Cglobalconst" begin
	end
	
	
	@testset "Caggregate" begin
	end
end

