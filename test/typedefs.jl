

@testset "c\"typedef ...\"" begin
	@eval c``
	
	@eval c"""
	typedef struct {
	} __attribute__((packed)) EmptyStructTypedef;
	"""
	@test sizeof(c"EmptyStructTypedef") == 0
	
	@eval c"""
	typedef struct {
		char c;
	} __attribute__((packed)) CcharStructTypedef;
	"""
	@test sizeof(c"CcharStructTypedef") == sizeof(Cchar)
	@test :c in fieldnames(c"CcharStructTypedef")
	
	@eval c"""
	typedef union {
		int i;
	} __attribute__((packed)) CintUnionTypedef;
	"""
	@test sizeof(c"CintUnionTypedef") == sizeof(Cint)
	@test :i in fieldnames(c"CintUnionTypedef")
	
	@eval c"""
	typedef enum {
		CENUM_TYPEDEF_1,
		CENUM_TYPEDEF_2 = 1 << 8,
		CENUM_TYPEDEF_3 = CENUM_TYPEDEF_2,
	} __attribute__((packed)) CenumTypedef;
	"""
	@test sizeof(c"CenumTypedef") == 2
	@test c"CENUM_TYPEDEF_3" != c"CENUM_TYPEDEF_1"
	@test c"CENUM_TYPEDEF_3" == c"CENUM_TYPEDEF_2"
	
	@eval c"""
	typedef unsigned int CuintArrayTypedef[32];
	"""
	@test sizeof(c"CuintArrayTypedef") == sizeof(Cuint)*32
	
	@eval c"""
	typedef int CintTypedef;
	"""
	@test sizeof(c"CintTypedef") == sizeof(Cint)
end

