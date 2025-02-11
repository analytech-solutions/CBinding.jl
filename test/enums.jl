

@testset "c\"enum ...\"" begin
	@eval module CBinding_enums
		using CBinding
		c``
		
		c"""
		enum OpaqueEnum;
		enum OpaqueEnum;
		
		enum SimpleEnum;
		enum SimpleEnum {
			SE1,
			SE2,
			SE3,
		};
		
		enum LessSimpleEnum {
			LSE1,
			LSE2,
			LSE3 = -1,
		};
		
		enum ComplexEnum {
			CE1 = 1,
			CE2 = CE1,
			CE3 = 0,
			CE4,
		};
		
		enum TrickyEnum {
			TE1 = -1,
			TE2 = 0xffffffff,
		};
		
		enum PackedSimpleEnum {
			PSE1,
			PSE2,
			PSE3,
		} __attribute__((packed));
		
		enum PackedLessSimpleEnum {
			PLSE1,
			PLSE2,
			PLSE3 = -1,
		} __attribute__((packed));
		
		enum PackedComplexEnum {
			PCE1 = 1,
			PCE2 = PCE1,
			PCE3 = 0,
			PCE4,
		} __attribute__((packed));
		
		enum PackedTrickyEnum {
			PTE1 = -1,
			PTE2 = 0xffffffff,
		} __attribute__((packed));
		"""
	end
	
	mod = @eval CBinding_enums
	
	@test_throws ErrorException sizeof(@eval mod c"enum OpaqueEnum")
	@test sizeof(@eval mod c"enum OpaqueEnum *") == sizeof(Ptr{Cvoid})
	
	@test sizeof(@eval mod c"enum SimpleEnum") == 4
	@test (@eval mod c"SE1") == 0
	@test (@eval mod c"SE2") == 1
	@test (@eval mod c"SE3") == 2
	
	@test sizeof(@eval mod c"enum LessSimpleEnum") == 4
	@test (@eval mod c"LSE1") == 0
	@test (@eval mod c"LSE2") == 1
	@test (@eval mod c"LSE3") == -1
	
	@test sizeof(@eval mod c"enum ComplexEnum") == 4
	@test (@eval mod c"CE1") == 1
	@test (@eval mod c"CE2") == 1
	@test (@eval mod c"CE3") == 0
	@test (@eval mod c"CE4") == 1
	
	@test sizeof(@eval mod c"enum TrickyEnum") == 8
	@test (@eval mod c"TE1") == -1
	@test (@eval mod c"TE2") == 0xffffffff
	
	@test sizeof(@eval mod c"enum PackedSimpleEnum") == 1
	@test (@eval mod c"PSE1") == 0
	@test (@eval mod c"PSE2") == 1
	@test (@eval mod c"PSE3") == 2
	
	@test sizeof(@eval mod c"enum PackedLessSimpleEnum") == 1
	@test (@eval mod c"PLSE1") == 0
	@test (@eval mod c"PLSE2") == 1
	@test (@eval mod c"PLSE3") == -1
	
	@test sizeof(@eval mod c"enum PackedComplexEnum") == 1
	@test (@eval mod c"PCE1") == 1
	@test (@eval mod c"PCE2") == 1
	@test (@eval mod c"PCE3") == 0
	@test (@eval mod c"PCE4") == 1
	
	@test sizeof(@eval mod c"enum PackedTrickyEnum") == 8
	@test (@eval mod c"PTE1") == -1
	@test (@eval mod c"PTE2") == 0xffffffff
end

