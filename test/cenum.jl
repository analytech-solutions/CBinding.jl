

@testset "@cenum" begin
	@eval @cenum SimpleEnum {
		SE1,
		SE2,
		SE3,
	}
	@test sizeof(SimpleEnum) == 4
	@test SE1 == 0
	@test SE2 == 1
	@test SE3 == 2
	
	@eval @cenum LessSimpleEnum {
		LSE1,
		LSE2,
		LSE3 = -1,
	}
	@test sizeof(LessSimpleEnum) == 4
	@test LSE1 == 0
	@test LSE2 == 1
	@test LSE3 == -1
	
	@eval @cenum ComplexEnum {
		CE1 = 1,
		CE2 = CE1,
		CE3 = 0,
		CE4,
	}
	@test sizeof(ComplexEnum) == 4
	@test CE1 == 1
	@test CE2 == 1
	@test CE3 == 0
	@test CE4 == 1
	
	@eval @cenum TrickyEnum {
		TE1 = -1,
		TE2 = 0xffffffff,
	}
	@test sizeof(TrickyEnum) == 8
	@test TE1 == -1
	@test TE2 == 0xffffffff
	
	@eval @cenum PackedSimpleEnum {
		PSE1,
		PSE2,
		PSE3,
	} __packed__
	@test sizeof(PackedSimpleEnum) == 1
	@test PSE1 == 0
	@test PSE2 == 1
	@test PSE3 == 2
	
	@eval @cenum PackedLessSimpleEnum {
		PLSE1,
		PLSE2,
		PLSE3 = -1,
	} __packed__
	@test sizeof(PackedLessSimpleEnum) == 1
	@test PLSE1 == 0
	@test PLSE2 == 1
	@test PLSE3 == -1
	
	@eval @cenum PackedComplexEnum {
		PCE1 = 1,
		PCE2 = PCE1,
		PCE3 = 0,
		PCE4,
	} __packed__
	@test sizeof(PackedComplexEnum) == 1
	@test PCE1 == 1
	@test PCE2 == 1
	@test PCE3 == 0
	@test PCE4 == 1
	
	@eval @cenum PackedTrickyEnum {
		PTE1 = -1,
		PTE2 = 0xffffffff,
	} __packed__
	@test sizeof(PackedTrickyEnum) == 8
	@test PTE1 == -1
	@test PTE2 == 0xffffffff
end

