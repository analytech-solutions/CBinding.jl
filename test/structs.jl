

@testset "c\"struct ...\"" begin
	@eval c``
	
	@eval c"""
	struct OpaqueStruct;
	"""
	@eval c"""
	struct OpaqueStruct;
	"""
	@test_throws ErrorException sizeof(c"struct OpaqueStruct")
	@test sizeof(c"struct OpaqueStruct *") == sizeof(Ptr{Cvoid})
	
	@eval c"""
	struct EmptyStruct {
	} __attribute__((packed));
	"""
	@test sizeof(c"struct EmptyStruct") == 0
	
	@eval c"""
	struct CcharStruct {
		char c;
	} __attribute__((packed));
	"""
	@test sizeof(c"struct CcharStruct") == sizeof(Cchar)
	@test :c in fieldnames(c"struct CcharStruct")
	
	@eval c"""
	struct CintStruct {
		int i;
	} __attribute__((packed));
	"""
	@test sizeof(c"struct CintStruct") == sizeof(Cint)
	@test :i in fieldnames(c"struct CintStruct")
	
	@eval c"""
	struct CstructStruct {
		struct CintStruct i;
	} __attribute__((packed));
	"""
	@test sizeof(c"struct CstructStruct") == sizeof(c"struct CintStruct")
	@test :i in fieldnames(c"struct CstructStruct")
	
	@eval c"""
	struct CintCcharStruct {
		struct CintStruct i;
		struct CcharStruct c;
	} __attribute__((packed));
	"""
	@test sizeof(c"struct CintCcharStruct") == sizeof(c"struct CintStruct")+sizeof(c"struct CcharStruct")
	@test :i in fieldnames(c"struct CintCcharStruct")
	@test :c in fieldnames(c"struct CintCcharStruct")
	
	@eval c"""
	struct CcharCintPackedStruct {
		struct CcharStruct c;
		struct CintStruct i;
	} __attribute__((packed));
	"""
	@test sizeof(c"struct CcharCintPackedStruct") == sizeof(c"struct CintStruct")+sizeof(c"struct CcharStruct")
	@test :c in fieldnames(c"struct CcharCintPackedStruct")
	@test :i in fieldnames(c"struct CcharCintPackedStruct")
	
	@eval c"""
	struct CcharCintAlignedStruct {
		struct CcharStruct c;
		_Alignas(sizeof(struct CintStruct)*2) struct CintStruct i;
	} __attribute__((packed));
	"""
	@test sizeof(c"struct CcharCintAlignedStruct") == max(sizeof(c"struct CintStruct")*4, max(sizeof(c"struct CintStruct"), sizeof(Cint))+max(sizeof(c"struct CcharStruct"), sizeof(Cint)))
	@test :c in fieldnames(c"struct CcharCintAlignedStruct")
	@test :i in fieldnames(c"struct CcharCintAlignedStruct")
	
	@eval c"""
	struct CunionStruct {
		union {
			unsigned char c[4];
			unsigned short s[2];
			unsigned int i;
		} __attribute__((packed));
	} __attribute__((packed));
	"""
	@test :c in fieldnames(c"struct CunionStruct")
	@test :s in fieldnames(c"struct CunionStruct")
	@test :i in fieldnames(c"struct CunionStruct")
	
	cus = c"struct CunionStruct"()
	@test cus.i == 0
	@test cus.c[1] == 0
	@test cus.c[4] == 0
	@test cus.s[1] == 0
	@test cus.s[2] == 0
	
	cus = c"struct CunionStruct"(cus, i = 0xff0000ff)
	@test cus.i == 0xff0000ff
	@test cus.c[1] == 0xff
	@test cus.c[4] == 0xff
	@test cus.s[1] != 0
	@test cus.s[2] != 0
	
	@eval c"""
	struct PtrToStructStruct;
	"""
	@eval c"""
	struct PtrToPtrToStructStruct {
		struct PtrToStructStruct *p;
	} __attribute__((packed));
	"""
	@eval c"""
	struct PtrToStructStruct {
		struct PtrToStructStruct *p;
	} __attribute__((packed));
	"""
	@test sizeof(c"struct PtrToPtrToStructStruct") == sizeof(Ptr)
	@test :p in fieldnames(c"struct PtrToPtrToStructStruct")
	@test sizeof(c"struct PtrToStructStruct") == sizeof(Ptr)
	@test :p in fieldnames(c"struct PtrToStructStruct")
	
	@eval c"""
	struct Cint32Bitfield {
		int i:32;
	} __attribute__((packed));
	"""
	@test sizeof(c"struct Cint32Bitfield") == sizeof(Cint)
	@test :i in fieldnames(c"struct Cint32Bitfield")
	
	@eval c"""
	struct Cuint32Bitfield {
		unsigned int u:32;
	} __attribute__((packed));
	"""
	@test sizeof(c"struct Cuint32Bitfield") == sizeof(Cuint)
	@test :u in fieldnames(c"struct Cuint32Bitfield")
	
	@eval c"""
	struct Cint2Bitfield {
		int i:2;
	} __attribute__((packed));
	"""
	@test sizeof(c"struct Cint2Bitfield") == sizeof(Cchar)
	@test :i in fieldnames(c"struct Cint2Bitfield")
	
	bf = c"struct Cint2Bitfield"()
	@test bf.i == 0
	for i in -3:3
		bf = c"struct Cint2Bitfield"(i = i)
		@test bf.i == (-2:1)[mod(i+2, 4)+1]
	end
	
	@eval c"""
	struct Cuint2Bitfield {
		unsigned int u:2;
	} __attribute__((packed));
	"""
	@test sizeof(c"struct Cuint2Bitfield") == sizeof(Cchar)
	@test :u in fieldnames(c"struct Cuint2Bitfield")
	
	@eval c"""
	struct Cuint32Cint32Bitfields {
		unsigned int u:32;
		int i:32;
	} __attribute__((packed));
	"""
	@test sizeof(c"struct Cuint32Cint32Bitfields") == sizeof(Cuint)+sizeof(Cint)
	@test :u in fieldnames(c"struct Cuint32Cint32Bitfields")
	@test :i in fieldnames(c"struct Cuint32Cint32Bitfields")
	
	@eval c"""
	struct Cuint16Cint16Bitfields {
		unsigned int u:16;
		int i:16;
	} __attribute__((packed));
	"""
	@test sizeof(c"struct Cuint16Cint16Bitfields") == sizeof(Cuint)
	@test :u in fieldnames(c"struct Cuint16Cint16Bitfields")
	@test :i in fieldnames(c"struct Cuint16Cint16Bitfields")
	
	bf = c"struct Cuint16Cint16Bitfields"()
	@test bf.u == 0
	@test bf.i == 0
	
	bf = c"struct Cuint16Cint16Bitfields"(bf, i = Cint(-1))
	@test bf.u == 0
	@test bf.i == -1
	
	bf = c"struct Cuint16Cint16Bitfields"(bf, u = Cuint(0x0001))
	@test bf.u == 0x0001
	@test bf.i == -1
	
	@eval c"""
	struct Cint16Cint16Bitfields {
		int i1:16;
		int i2:16;
	} __attribute__((packed));
	"""
	@test sizeof(c"struct Cint16Cint16Bitfields") == sizeof(Cuint)
	
	@eval c"""
	struct Cint16CintBitfields {
		unsigned int u:16;
		int i;
	} __attribute__((packed));
	"""
	@test sizeof(c"struct Cint16CintBitfields") == 2+sizeof(Cint)
	@test :u in fieldnames(c"struct Cint16CintBitfields")
	@test :i in fieldnames(c"struct Cint16CintBitfields")
	
	# https://github.com/analytech-solutions/CBinding.jl/issues/6
	@eval c"""
	struct AnonymousAggregateField {
		union {
			int x;
			char y;
		} u;
	};
	"""
	aaf = c"struct AnonymousAggregateField"(u = (x = -1,))
	@test aaf.u.x == -1
	aaf = c"struct AnonymousAggregateField"(aaf, u = (x = 0,))
	@test aaf.u.x == 0
	
	@eval c"""
	struct NestedAnonymousAggregateField {
		union {
			union {
				int z;
			} x;
			char y;
		} u;
	};
	"""
	aaf = c"struct NestedAnonymousAggregateField"(u = (x = (z = -1,),))
	@test aaf.u.x.z == -1
	aaf = c"struct NestedAnonymousAggregateField"(aaf, u = (x = (z = 0,),))
	@test aaf.u.x.z == 0
	
	# https://github.com/analytech-solutions/CBinding.jl/issues/8
	@eval c"""
	struct BrokenLayout {
		struct {
			int y;
			int z;
		} x;
	};
	"""
	bl = c"struct BrokenLayout"()
	@test bl.x.y == 0 && bl.x.z == 0
	bl = c"struct BrokenLayout"(bl, x = (z = 123,))
	@test bl.x.y == 0 && bl.x.z == 123
	
	@eval c"""
	struct ArrayOfStruct {
		struct BrokenLayout x[2];
	};
	"""
	@test sizeof(c"struct ArrayOfStruct") == 2*2*sizeof(Cint)
	aos = c"struct ArrayOfStruct"()
	@test typeof(aos) <: c"struct ArrayOfStruct"
	@test typeof(aos.x) <: Carray
	@test typeof(aos.x[2]) <: c"struct BrokenLayout"
	@test typeof(aos.x[2].x) <: Cstruct
	@test typeof(aos.x[2].x.y) <: Cint
	
	@eval c"""
	enum SmallEnum {
		SMALL_1 = 1,
		SMALL_2 = 2,
		SMALL_3 = 4,
	};
	"""
	@eval c"""
	struct SmallEnumBitfield {
		enum SmallEnum a:8;
		enum SmallEnum b:8;
	};
	"""
	@test sizeof(c"struct SmallEnumBitfield") == sizeof(c"enum SmallEnum")
	x = c"struct SmallEnumBitfield"()
	@test getfield(x, :mem) == (0x00, 0x00, 0x00, 0x00)
	x = c"struct SmallEnumBitfield"(x, a = c"SMALL_1")
	@test getfield(x, :mem) == (convert(UInt8, c"SMALL_1"), 0x00, 0x00, 0x00)
	x = c"struct SmallEnumBitfield"(x, b = c"SMALL_3")
	@test getfield(x, :mem) == (convert(UInt8, c"SMALL_1"), convert(UInt8, c"SMALL_3"), 0x00, 0x00)
end

