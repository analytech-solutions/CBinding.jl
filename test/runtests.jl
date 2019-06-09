using Test: @testset, @test, @test_throws
using CBinding


@testset "CBinding" begin
	@testset "@cstruct" begin
		@cstruct EmptyStruct 0 begin
		end
		@test sizeof(EmptyStruct) == 0
		
		@cstruct CcharStruct 8 begin
			1:8 => c::Cchar
		end
		@test sizeof(CcharStruct) == sizeof(Cchar)
		@test :c in propertynames(CcharStruct)
		
		@cstruct CintStruct 32 begin
			1:32 => i::Cint
		end
		@test sizeof(CintStruct) == sizeof(Cint)
		@test :i in propertynames(CintStruct)
		
		@cstruct CstructStruct 32 begin
			1:32 => i::CintStruct
		end
		@test sizeof(CstructStruct) == sizeof(CintStruct)
		@test :i in propertynames(CstructStruct)
		
		@cstruct CintCcharStruct 40 begin
			1:32 => i::CintStruct
			33:40 => c::CcharStruct
		end
		@test sizeof(CintCcharStruct) == sizeof(CintStruct)+sizeof(CcharStruct)
		@test :i in propertynames(CintCcharStruct)
		@test :c in propertynames(CintCcharStruct)
		
		@cstruct CcharCintPackedStruct 40 begin
			1:8 => c::CcharStruct
			9:40 => i::CintStruct
		end
		@test sizeof(CcharCintPackedStruct) == sizeof(CintStruct)+sizeof(CcharStruct)
		@test :c in propertynames(CcharCintPackedStruct)
		@test :i in propertynames(CcharCintPackedStruct)
		
		@cstruct CcharCintAlignedStruct 64 begin
			1:8 => c::CcharStruct
			33:64 => i::CintStruct
		end
		@test sizeof(CcharCintAlignedStruct) == max(sizeof(CintStruct), sizeof(Cint))+max(sizeof(CcharStruct), sizeof(Cint))
		@test :c in propertynames(CcharCintAlignedStruct)
		@test :i in propertynames(CcharCintAlignedStruct)
		
		@cstruct CunionStruct 32 begin
			1:32 => ::@cunion 32 begin
				1:32 => c::Cchar[4]
				1:32 => s::Cshort[2]
				1:32 => i::Cint
			end
		end
		@test :c in propertynames(CunionStruct)
		@test :s in propertynames(CunionStruct)
		@test :i in propertynames(CunionStruct)
		
		@cstruct BitfieldStruct 32 begin
			1:2 => byte1::Cint
			3:5 => byte2::Cint
			6:21 => byte3::Cint
			22:32 => byte4::Cint
		end
		@test sizeof(BitfieldStruct) == sizeof(Cint)
		#BitfieldStruct(byte1 = 0, byte2 = 0, byte3 = 0, byte4 = 0)
	end
	
	
	@testset "@cunion" begin
	end
	
	
	@testset "@cstruct + @cunion" begin
	end
	
	
	@testset "Clibrary" begin
	end
	
	
	@testset "Cglobal + Cglobalconst" begin
	end
	
	
	@testset "Caggregate" begin
	end
end

