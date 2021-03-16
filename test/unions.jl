

@testset "c\"union ...\"" begin
	@eval c``
	
	@eval c"""
	union OpaqueUnion;
	"""
	@eval c"""
	union OpaqueUnion;
	"""
	@test_throws ErrorException sizeof(c"union OpaqueUnion")
	@test sizeof(c"union OpaqueUnion *") == sizeof(Ptr{Cvoid})
	
	@eval c"""
	union EmptyUnion {
	} __attribute__((packed));
	"""
	@test sizeof(c"union EmptyUnion") == 0
	
	@eval c"""
	union CcharUnion {
		char c;
	} __attribute__((packed));
	"""
	@test sizeof(c"union CcharUnion") == sizeof(Cchar)
	@test :c in fieldnames(c"union CcharUnion")
	
	@eval c"""
	union CintUnion {
		int i;
	} __attribute__((packed));
	"""
	@test sizeof(c"union CintUnion") == sizeof(Cint)
	@test :i in fieldnames(c"union CintUnion")
	
	@eval c"""
	union CunionCintUnion {
		union CintUnion i;
	} __attribute__((packed));
	"""
	@test sizeof(c"union CunionCintUnion") == sizeof(c"union CintUnion")
	@test :i in fieldnames(c"union CunionCintUnion")
	
	@eval c"""
	union CintCcharUnion {
		union CintUnion i;
		union CcharUnion c;
	} __attribute__((packed));
	"""
	@test sizeof(c"union CintCcharUnion") == max(sizeof(c"union CintUnion"), sizeof(c"union CcharUnion"))
	@test :i in fieldnames(c"union CintCcharUnion")
	@test :c in fieldnames(c"union CintCcharUnion")
	
	@eval c"""
	union CcharCintPackedUnion {
		union CcharUnion c;
		union CintUnion i;
	} __attribute__((packed));
	"""
	@test sizeof(c"union CcharCintPackedUnion") == max(sizeof(c"union CintUnion"), sizeof(c"union CcharUnion"))
	@test :c in fieldnames(c"union CcharCintPackedUnion")
	@test :i in fieldnames(c"union CcharCintPackedUnion")
	
	@eval c"""
	union CcharCintAlignedUnion {
		union CcharUnion c;
		_Alignas(sizeof(union CintUnion)*2) union CintUnion i;
	} __attribute__((packed));
	"""
	@test sizeof(c"union CcharCintAlignedUnion") == max(max(sizeof(c"union CintUnion"), sizeof(Cint))*2, max(sizeof(c"union CcharUnion"), sizeof(Cint)))
	@test :c in fieldnames(c"union CcharCintAlignedUnion")
	@test :i in fieldnames(c"union CcharCintAlignedUnion")
	
	@eval c"""
	union CunionUnion {
		union {
			unsigned char c[4];
			unsigned short s[2];
			unsigned int i;
		} __attribute__((packed));
	} __attribute__((packed));
	"""
	@test :c in fieldnames(c"union CunionUnion")
	@test :s in fieldnames(c"union CunionUnion")
	@test :i in fieldnames(c"union CunionUnion")
	
	cuu = c"union CunionUnion"()
	@test cuu.i == 0
	@test cuu.c[1] == 0
	@test cuu.c[4] == 0
	@test cuu.s[1] == 0
	@test cuu.s[2] == 0
	
	cuu = c"union CunionUnion"(cuu, i = 0xff0000ff)
	@test cuu.i == 0xff0000ff
	@test cuu.c[1] == 0xff
	@test cuu.c[4] == 0xff
	@test cuu.s[1] != 0
	@test cuu.s[2] != 0
	
	@eval c"""
	union PtrToUnionUnion;
	"""
	@eval c"""
	union PtrToPtrToUnionUnion {
		union PtrToUnionUnion *p;
	} __attribute__((packed));
	"""
	@eval c"""
	union PtrToUnionUnion {
		union PtrToUnionUnion *p;
	} __attribute__((packed));
	"""
	@test sizeof(c"union PtrToPtrToUnionUnion") == sizeof(Ptr)
	@test :p in fieldnames(c"union PtrToPtrToUnionUnion")
	@test sizeof(c"union PtrToUnionUnion") == sizeof(Ptr)
	@test :p in fieldnames(c"union PtrToUnionUnion")
	
	@eval c"""
	union Cint32BitfieldUnion {
		int i:32;
	} __attribute__((packed));
	"""
	@test sizeof(c"union Cint32BitfieldUnion") == sizeof(Cint)
	@test :i in fieldnames(c"union Cint32BitfieldUnion")
	
	@eval c"""
	union Cuint32BitfieldUnion {
		unsigned int u:32;
	} __attribute__((packed));
	"""
	@test sizeof(c"union Cuint32BitfieldUnion") == sizeof(Cuint)
	@test :u in fieldnames(c"union Cuint32BitfieldUnion")
	
	@eval c"""
	union Cint2BitfieldUnion {
		int i:2;
	} __attribute__((packed));
	"""
	@test sizeof(c"union Cint2BitfieldUnion") == 1
	@test :i in fieldnames(c"union Cint2BitfieldUnion")
	
	@eval c"""
	union Cuint2BitfieldUnion {
		unsigned int u:2;
	} __attribute__((packed));
	"""
	@test sizeof(c"union Cuint2BitfieldUnion") == 1
	@test :u in fieldnames(c"union Cuint2BitfieldUnion")
	
	@eval c"""
	union Cuint32Cint32BitfieldsUnion {
		unsigned int u:32;
		int i:32;
	} __attribute__((packed));
	"""
	@test sizeof(c"union Cuint32Cint32BitfieldsUnion") == sizeof(Cuint)
	@test :u in fieldnames(c"union Cuint32Cint32BitfieldsUnion")
	@test :i in fieldnames(c"union Cuint32Cint32BitfieldsUnion")
	
	@eval c"""
	union Cuint16Cint16BitfieldsUnion {
		unsigned int u:16;
		int i:16;
	} __attribute__((packed));
	"""
	@test sizeof(c"union Cuint16Cint16BitfieldsUnion") == 2
	@test :u in fieldnames(c"union Cuint16Cint16BitfieldsUnion")
	@test :i in fieldnames(c"union Cuint16Cint16BitfieldsUnion")
	
	bfUnion = c"union Cuint16Cint16BitfieldsUnion"()
	@test bfUnion.u == 0
	@test bfUnion.i == 0
	
	bfUnion = c"union Cuint16Cint16BitfieldsUnion"(bfUnion, i = Cint(-1))
	@test bfUnion.u == 0xffff
	@test bfUnion.i == -1
	
	bfUnion = c"union Cuint16Cint16BitfieldsUnion"(bfUnion, u = Cuint(0x0001))
	@test bfUnion.u == 0x0001
	@test bfUnion.i == 1
	
	@eval c"""
	union Cint16Cint16BitfieldsUnion {
		int i1:16;
		int i2:16;
	} __attribute__((packed));
	"""
	@test sizeof(c"union Cint16Cint16BitfieldsUnion") == 2
	
	@eval c"""
	union Cint16CintBitfieldsUnion {
		int bf:16;
		int i;
	} __attribute__((packed));
	"""
	@test sizeof(c"union Cint16CintBitfieldsUnion") == sizeof(Cint)
end

