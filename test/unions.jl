

@testset "c\"union ...\"" begin
	@eval module CBinding_unions
		using CBinding
		c``
		
		c"""
		union OpaqueUnion;
		union OpaqueUnion;
		
		union EmptyUnion {
		} __attribute__((packed));
		
		union CcharUnion {
			char c;
		} __attribute__((packed));
		
		union CintUnion {
			int i;
		} __attribute__((packed));
		
		union CunionCintUnion {
			union CintUnion i;
		} __attribute__((packed));
		
		union CintCcharUnion {
			union CintUnion i;
			union CcharUnion c;
		} __attribute__((packed));
		
		union CcharCintPackedUnion {
			union CcharUnion c;
			union CintUnion i;
		} __attribute__((packed));
		
		union CcharCintAlignedUnion {
			union CcharUnion c;
			_Alignas(sizeof(union CintUnion)*2) union CintUnion i;
		} __attribute__((packed));
		
		union CunionUnion {
			union {
				unsigned char c[4];
				unsigned short s[2];
				unsigned int i;
			} __attribute__((packed));
		} __attribute__((packed));
		
		
		union PtrToUnionUnion;
		
		union PtrToPtrToUnionUnion {
			union PtrToUnionUnion *p;
		} __attribute__((packed));
		
		union PtrToUnionUnion {
			union PtrToUnionUnion *p;
		} __attribute__((packed));
		
		union Cint32BitfieldUnion {
			int i:32;
		} __attribute__((packed));
		
		union Cuint32BitfieldUnion {
			unsigned int u:32;
		} __attribute__((packed));
		
		union Cint2BitfieldUnion {
			int i:2;
		} __attribute__((packed));
		
		
		union Cuint2BitfieldUnion {
			unsigned int u:2;
		} __attribute__((packed));
		
		union Cuint32Cint32BitfieldsUnion {
			unsigned int u:32;
			int i:32;
		} __attribute__((packed));
		
		union Cuint16Cint16BitfieldsUnion {
			unsigned int u:16;
			int i:16;
		} __attribute__((packed));
		
		union Cint16Cint16BitfieldsUnion {
			int i1:16;
			int i2:16;
		} __attribute__((packed));
		
		union Cint16CintBitfieldsUnion {
			int bf:16;
			int i;
		} __attribute__((packed));
		"""
	end
	
	mod = @eval CBinding_unions
	
	@test_throws ErrorException sizeof(@eval mod c"union OpaqueUnion")
	@test sizeof(@eval mod c"union OpaqueUnion *") == sizeof(Ptr{Cvoid})
	
	@test sizeof(@eval mod c"union EmptyUnion") == 0
	
	@test sizeof(@eval mod c"union CcharUnion") == sizeof(Cchar)
	@test :c in fieldnames(@eval mod c"union CcharUnion")
	
	@test sizeof(@eval mod c"union CintUnion") == sizeof(Cint)
	@test :i in fieldnames(@eval mod c"union CintUnion")
	
	@test sizeof(@eval mod c"union CunionCintUnion") == sizeof(@eval mod c"union CintUnion")
	@test :i in fieldnames(@eval mod c"union CunionCintUnion")
	
	@test sizeof(@eval mod c"union CintCcharUnion") == max(sizeof(@eval mod c"union CintUnion"), sizeof(@eval mod c"union CcharUnion"))
	@test :i in fieldnames(@eval mod c"union CintCcharUnion")
	@test :c in fieldnames(@eval mod c"union CintCcharUnion")
	
	@test sizeof(@eval mod c"union CcharCintPackedUnion") == max(sizeof(@eval mod c"union CintUnion"), sizeof(@eval mod c"union CcharUnion"))
	@test :c in fieldnames(@eval mod c"union CcharCintPackedUnion")
	@test :i in fieldnames(@eval mod c"union CcharCintPackedUnion")
	
	@test sizeof(@eval mod c"union CcharCintAlignedUnion") == max(max(sizeof(@eval mod c"union CintUnion"), sizeof(Cint))*2, max(sizeof(@eval mod c"union CcharUnion"), sizeof(Cint)))
	@test :c in fieldnames(@eval mod c"union CcharCintAlignedUnion")
	@test :i in fieldnames(@eval mod c"union CcharCintAlignedUnion")
	
	@test :c in fieldnames(@eval mod c"union CunionUnion")
	@test :s in fieldnames(@eval mod c"union CunionUnion")
	@test :i in fieldnames(@eval mod c"union CunionUnion")
	
	cuu = (@eval mod c"union CunionUnion")()
	@test cuu.i == 0
	@test cuu.c[1] == 0
	@test cuu.c[4] == 0
	@test cuu.s[1] == 0
	@test cuu.s[2] == 0
	
	cuu = (@eval mod c"union CunionUnion")(cuu, i = 0xff0000ff)
	@test cuu.i == 0xff0000ff
	@test cuu.c[1] == 0xff
	@test cuu.c[4] == 0xff
	@test cuu.s[1] != 0
	@test cuu.s[2] != 0
	
	@test sizeof(@eval mod c"union PtrToPtrToUnionUnion") == sizeof(Ptr)
	@test :p in fieldnames(@eval mod c"union PtrToPtrToUnionUnion")
	@test sizeof(@eval mod c"union PtrToUnionUnion") == sizeof(Ptr)
	@test :p in fieldnames(@eval mod c"union PtrToUnionUnion")
	
	@test sizeof(@eval mod c"union Cint32BitfieldUnion") == sizeof(Cint)
	@test :i in fieldnames(@eval mod c"union Cint32BitfieldUnion")
	
	@test sizeof(@eval mod c"union Cuint32BitfieldUnion") == sizeof(Cuint)
	@test :u in fieldnames(@eval mod c"union Cuint32BitfieldUnion")
	
	@test sizeof(@eval mod c"union Cint2BitfieldUnion") == 1
	@test :i in fieldnames(@eval mod c"union Cint2BitfieldUnion")
	
	@test sizeof(@eval mod c"union Cuint2BitfieldUnion") == 1
	@test :u in fieldnames(@eval mod c"union Cuint2BitfieldUnion")
	
	@test sizeof(@eval mod c"union Cuint32Cint32BitfieldsUnion") == sizeof(Cuint)
	@test :u in fieldnames(@eval mod c"union Cuint32Cint32BitfieldsUnion")
	@test :i in fieldnames(@eval mod c"union Cuint32Cint32BitfieldsUnion")
	
	@test sizeof(@eval mod c"union Cuint16Cint16BitfieldsUnion") == 2
	@test :u in fieldnames(@eval mod c"union Cuint16Cint16BitfieldsUnion")
	@test :i in fieldnames(@eval mod c"union Cuint16Cint16BitfieldsUnion")
	
	bfUnion = (@eval mod c"union Cuint16Cint16BitfieldsUnion")()
	@test bfUnion.u == 0
	@test bfUnion.i == 0
	
	bfUnion = (@eval mod c"union Cuint16Cint16BitfieldsUnion")(bfUnion, i = Cint(-1))
	@test bfUnion.u == 0xffff
	@test bfUnion.i == -1
	
	bfUnion = (@eval mod c"union Cuint16Cint16BitfieldsUnion")(bfUnion, u = Cuint(0x0001))
	@test bfUnion.u == 0x0001
	@test bfUnion.i == 1
	
	@test sizeof(@eval mod c"union Cint16Cint16BitfieldsUnion") == 2
	
	@test sizeof(@eval mod c"union Cint16CintBitfieldsUnion") == sizeof(Cint)
end

