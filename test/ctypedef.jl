

@testset "@ctypedef" begin
	@eval @ctypedef EmptyStructTypedef @cstruct {
	} __packed__
	@test sizeof(EmptyStructTypedef) == 0
	
	@eval @ctypedef CcharStructTypedef @cstruct {
		c::Cchar
	} __packed__
	@test sizeof(CcharStructTypedef) == sizeof(Cchar)
	@test :c in propertynames(CcharStructTypedef)
	
	@eval @ctypedef CintUnionTypedef @cunion {
		i::Cint
	} __packed__
	@test sizeof(CintUnionTypedef) == sizeof(Cint)
	@test :i in propertynames(CintUnionTypedef)
	
	@eval @ctypedef CenumTypedef @cenum {
		CENUM_TYPEDEF_1,
		CENUM_TYPEDEF_2 = 1 << 8,
		CENUM_TYPEDEF_3 = CENUM_TYPEDEF_2,
	} __packed__
	@test sizeof(CenumTypedef) == 2
	@test CENUM_TYPEDEF_3 != CENUM_TYPEDEF_1
	@test CENUM_TYPEDEF_3 == CENUM_TYPEDEF_2
	
	@eval @ctypedef CuintArrayTypedef Cuint[32]
	@test sizeof(CuintArrayTypedef) == sizeof(Cuint)*32
	
	@eval @ctypedef CintTypedef Cint
	@test sizeof(CintTypedef) == sizeof(Cint)
end

