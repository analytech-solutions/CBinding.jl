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
				c::Cchar[4]
				s::Cshort[2]
				i::Cint
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
	end
	
	
	@testset "@cstruct + @cunion" begin
	end
	
	
	@testset "@carray" begin
		CcharArray = @carray Cchar[2]
		@test sizeof(CcharArray) == sizeof(Cchar)*2
		
		CstructArray = @carray (@cstruct {
			i::Cint
		})[10]
		@test sizeof(CstructArray) == sizeof(Cint)*10
		
		PtrArray = @carray Ptr{@cstruct Opaque}[3]
		@test sizeof(PtrArray) == sizeof(Ptr)*3
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

