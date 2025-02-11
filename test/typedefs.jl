

@testset "c\"typedef ...\"" begin
	@eval module CBinding_typedefs
		using CBinding
		c``
		
		c"""
		typedef struct {
		} __attribute__((packed)) EmptyStructTypedef;
		
		typedef struct {
			char c;
		} __attribute__((packed)) CcharStructTypedef;
		
		typedef union {
			int i;
		} __attribute__((packed)) CintUnionTypedef;
		
		typedef enum {
			CENUM_TYPEDEF_1,
			CENUM_TYPEDEF_2 = 1 << 8,
			CENUM_TYPEDEF_3 = CENUM_TYPEDEF_2,
		} __attribute__((packed)) CenumTypedef;
		
		typedef unsigned int CuintArrayTypedef[32];
		
		typedef int CintTypedef;
		"""
	end
	
	mod = @eval CBinding_typedefs
	
	@test sizeof(@eval mod c"EmptyStructTypedef") == 0
	
	@test sizeof(@eval mod c"CcharStructTypedef") == sizeof(Cchar)
	@test :c in fieldnames(@eval mod c"CcharStructTypedef")
	
	@test sizeof(@eval mod c"CintUnionTypedef") == sizeof(Cint)
	@test :i in fieldnames(@eval mod c"CintUnionTypedef")
	
	@test sizeof(@eval mod c"CenumTypedef") == 2
	@test (@eval mod c"CENUM_TYPEDEF_3") != (@eval mod c"CENUM_TYPEDEF_1")
	@test (@eval mod c"CENUM_TYPEDEF_3") == (@eval mod c"CENUM_TYPEDEF_2")
	
	@test sizeof(@eval mod c"CuintArrayTypedef") == sizeof(Cuint)*32
	
	@test sizeof(@eval mod c"CintTypedef") == sizeof(Cint)
end

