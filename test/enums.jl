

@testset "c\"enum ...\"" begin
	@eval c``
	
	@eval c"""
	enum OpaqueEnum;
	"""
	@eval c"""
	enum OpaqueEnum;
	"""
	@test_throws ErrorException sizeof(c"enum OpaqueEnum")
	@test sizeof(c"enum OpaqueEnum *") == sizeof(Ptr{Cvoid})
	
	@eval c"""
	enum SimpleEnum;
	"""
	@eval c"""
	enum SimpleEnum {
		SE1,
		SE2,
		SE3,
	};
	"""
	@test sizeof(c"enum SimpleEnum") == 4
	@test c"SE1" == 0
	@test c"SE2" == 1
	@test c"SE3" == 2
	
	@eval c"""
	enum LessSimpleEnum {
		LSE1,
		LSE2,
		LSE3 = -1,
	};
	"""
	@test sizeof(c"enum LessSimpleEnum") == 4
	@test c"LSE1" == 0
	@test c"LSE2" == 1
	@test c"LSE3" == -1
	
	@eval c"""
	enum ComplexEnum {
		CE1 = 1,
		CE2 = CE1,
		CE3 = 0,
		CE4,
	};
	"""
	@test sizeof(c"enum ComplexEnum") == 4
	@test c"CE1" == 1
	@test c"CE2" == 1
	@test c"CE3" == 0
	@test c"CE4" == 1
	
	@eval c"""
	enum TrickyEnum {
		TE1 = -1,
		TE2 = 0xffffffff,
	};
	"""
	@test sizeof(c"enum TrickyEnum") == 8
	@test c"TE1" == -1
	@test c"TE2" == 0xffffffff
	
	@eval c"""
	enum PackedSimpleEnum {
		PSE1,
		PSE2,
		PSE3,
	} __attribute__((packed));
	"""
	@test sizeof(c"enum PackedSimpleEnum") == 1
	@test c"PSE1" == 0
	@test c"PSE2" == 1
	@test c"PSE3" == 2
	
	@eval c"""
	enum PackedLessSimpleEnum {
		PLSE1,
		PLSE2,
		PLSE3 = -1,
	} __attribute__((packed));
	"""
	@test sizeof(c"enum PackedLessSimpleEnum") == 1
	@test c"PLSE1" == 0
	@test c"PLSE2" == 1
	@test c"PLSE3" == -1
	
	@eval c"""
	enum PackedComplexEnum {
		PCE1 = 1,
		PCE2 = PCE1,
		PCE3 = 0,
		PCE4,
	} __attribute__((packed));
	"""
	@test sizeof(c"enum PackedComplexEnum") == 1
	@test c"PCE1" == 1
	@test c"PCE2" == 1
	@test c"PCE3" == 0
	@test c"PCE4" == 1
	
	@eval c"""
	enum PackedTrickyEnum {
		PTE1 = -1,
		PTE2 = 0xffffffff,
	} __attribute__((packed));
	"""
	@test sizeof(c"enum PackedTrickyEnum") == 8
	@test c"PTE1" == -1
	@test c"PTE2" == 0xffffffff
end

