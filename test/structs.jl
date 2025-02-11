

@testset "c\"struct ...\"" begin
	@eval module CBinding_structs
		using CBinding
		c``
		
		c"""
		struct OpaqueStruct;
		struct OpaqueStruct;
		
		struct EmptyStruct {
		} __attribute__((packed));
		
		struct CcharStruct {
			char c;
		} __attribute__((packed));
		
		struct CintStruct {
			int i;
		} __attribute__((packed));
		
		struct CstructStruct {
			struct CintStruct i;
		} __attribute__((packed));
		
		struct CintCcharStruct {
			struct CintStruct i;
			struct CcharStruct c;
		} __attribute__((packed));
		
		struct CcharCintPackedStruct {
			struct CcharStruct c;
			struct CintStruct i;
		} __attribute__((packed));
		
		struct CcharCintAlignedStruct {
			struct CcharStruct c;
			_Alignas(sizeof(struct CintStruct)*2) struct CintStruct i;
		} __attribute__((packed));
		
		struct CunionStruct {
			union {
				unsigned char c[4];
				unsigned short s[2];
				unsigned int i;
			} __attribute__((packed));
		} __attribute__((packed));
		
		
		struct PtrToStructStruct;
		
		struct PtrToPtrToStructStruct {
			struct PtrToStructStruct *p;
		} __attribute__((packed));
		
		struct PtrToStructStruct {
			struct PtrToStructStruct *p;
		} __attribute__((packed));
		
		struct Cint32Bitfield {
			int i:32;
		} __attribute__((packed));
		
		struct Cuint32Bitfield {
			unsigned int u:32;
		} __attribute__((packed));
		
		struct Cint2Bitfield {
			int i:2;
		} __attribute__((packed));
		
		struct Cuint2Bitfield {
			unsigned int u:2;
		} __attribute__((packed));
		
		struct Cuint32Cint32Bitfields {
			unsigned int u:32;
			int i:32;
		} __attribute__((packed));
		
		struct Cuint16Cint16Bitfields {
			unsigned int u:16;
			int i:16;
		} __attribute__((packed));
		
		struct Cint16Cint16Bitfields {
			int i1:16;
			int i2:16;
		} __attribute__((packed));
		
		struct Cint16CintBitfields {
			unsigned int u:16;
			int i;
		} __attribute__((packed));
		
		
		struct AnonymousAggregateField {
			union {
				int x;
				char y;
			} u;
		};
		
		struct NestedAnonymousAggregateField {
			union {
				union {
					int z;
				} x;
				char y;
			} u;
		};
		
		
		struct BrokenLayout {
			struct {
				int y;
				int z;
			} x;
		};
		
		
		struct ArrayOfStruct {
			struct BrokenLayout x[2];
		};
		
		enum SmallEnum {
			SMALL_1 = 1,
			SMALL_2 = 2,
			SMALL_3 = 4,
		};
		
		struct SmallEnumBitfield {
			enum SmallEnum a:8;
			enum SmallEnum b:8;
		};
		"""
	end
	
	mod = @eval CBinding_structs
	
	@test_throws ErrorException sizeof(@eval mod c"struct OpaqueStruct")
	@test sizeof(@eval mod c"struct OpaqueStruct *") == sizeof(Ptr{Cvoid})
	
	@test sizeof(@eval mod c"struct EmptyStruct") == 0
	
	@test sizeof(@eval mod c"struct CcharStruct") == sizeof(Cchar)
	@test :c in fieldnames(@eval mod c"struct CcharStruct")
	
	@test sizeof(@eval mod c"struct CintStruct") == sizeof(Cint)
	@test :i in fieldnames(@eval mod c"struct CintStruct")
	
	@test sizeof(@eval mod c"struct CstructStruct") == sizeof(@eval mod c"struct CintStruct")
	@test :i in fieldnames(@eval mod c"struct CstructStruct")
	
	@test sizeof(@eval mod c"struct CintCcharStruct") == sizeof(@eval mod c"struct CintStruct")+sizeof(@eval mod c"struct CcharStruct")
	@test :i in fieldnames(@eval mod c"struct CintCcharStruct")
	@test :c in fieldnames(@eval mod c"struct CintCcharStruct")
	
	@test sizeof(@eval mod c"struct CcharCintPackedStruct") == sizeof(@eval mod c"struct CintStruct")+sizeof(@eval mod c"struct CcharStruct")
	@test :c in fieldnames(@eval mod c"struct CcharCintPackedStruct")
	@test :i in fieldnames(@eval mod c"struct CcharCintPackedStruct")
	
	@test sizeof(@eval mod c"struct CcharCintAlignedStruct") == max(sizeof(@eval mod c"struct CintStruct")*4, max(sizeof(@eval mod c"struct CintStruct"), sizeof(Cint))+max(sizeof(@eval mod c"struct CcharStruct"), sizeof(Cint)))
	@test :c in fieldnames(@eval mod c"struct CcharCintAlignedStruct")
	@test :i in fieldnames(@eval mod c"struct CcharCintAlignedStruct")
	
	@test :c in fieldnames(@eval mod c"struct CunionStruct")
	@test :s in fieldnames(@eval mod c"struct CunionStruct")
	@test :i in fieldnames(@eval mod c"struct CunionStruct")
	
	cus = (@eval mod c"struct CunionStruct")()
	@test cus.i == 0
	@test cus.c[1] == 0
	@test cus.c[4] == 0
	@test cus.s[1] == 0
	@test cus.s[2] == 0
	
	cus = (@eval mod c"struct CunionStruct")(cus, i = 0xff0000ff)
	@test cus.i == 0xff0000ff
	@test cus.c[1] == 0xff
	@test cus.c[4] == 0xff
	@test cus.s[1] != 0
	@test cus.s[2] != 0
	
	@test sizeof(@eval mod c"struct PtrToPtrToStructStruct") == sizeof(Ptr)
	@test :p in fieldnames(@eval mod c"struct PtrToPtrToStructStruct")
	@test sizeof(@eval mod c"struct PtrToStructStruct") == sizeof(Ptr)
	@test :p in fieldnames(@eval mod c"struct PtrToStructStruct")
	
	@test sizeof(@eval mod c"struct Cint32Bitfield") == sizeof(Cint)
	@test :i in fieldnames(@eval mod c"struct Cint32Bitfield")
	
	@test sizeof(@eval mod c"struct Cuint32Bitfield") == sizeof(Cuint)
	@test :u in fieldnames(@eval mod c"struct Cuint32Bitfield")
	
	@test sizeof(@eval mod c"struct Cint2Bitfield") == sizeof(Cchar)
	@test :i in fieldnames(@eval mod c"struct Cint2Bitfield")
	
	bf = (@eval mod c"struct Cint2Bitfield")()
	@test bf.i == 0
	for i in -3:3
		bf = (@eval mod c"struct Cint2Bitfield")(i = i)
		@test bf.i == (-2:1)[Base.mod(i+2, 4)+1]
	end
	
	@test sizeof(@eval mod c"struct Cuint2Bitfield") == sizeof(Cchar)
	@test :u in fieldnames(@eval mod c"struct Cuint2Bitfield")
	
	@test sizeof(@eval mod c"struct Cuint32Cint32Bitfields") == sizeof(Cuint)+sizeof(Cint)
	@test :u in fieldnames(@eval mod c"struct Cuint32Cint32Bitfields")
	@test :i in fieldnames(@eval mod c"struct Cuint32Cint32Bitfields")
	
	@test sizeof(@eval mod c"struct Cuint16Cint16Bitfields") == sizeof(Cuint)
	@test :u in fieldnames(@eval mod c"struct Cuint16Cint16Bitfields")
	@test :i in fieldnames(@eval mod c"struct Cuint16Cint16Bitfields")
	
	bf = (@eval mod c"struct Cuint16Cint16Bitfields")()
	@test bf.u == 0
	@test bf.i == 0
	
	bf = (@eval mod c"struct Cuint16Cint16Bitfields")(bf, i = Cint(-1))
	@test bf.u == 0
	@test bf.i == -1
	
	bf = (@eval mod c"struct Cuint16Cint16Bitfields")(bf, u = Cuint(0x0001))
	@test bf.u == 0x0001
	@test bf.i == -1
	
	@test sizeof(@eval mod c"struct Cint16Cint16Bitfields") == sizeof(Cuint)
	
	@test sizeof(@eval mod c"struct Cint16CintBitfields") == 2+sizeof(Cint)
	@test :u in fieldnames(@eval mod c"struct Cint16CintBitfields")
	@test :i in fieldnames(@eval mod c"struct Cint16CintBitfields")
	
	# https://github.com/analytech-solutions/CBinding.jl/issues/6
	aaf = (@eval mod c"struct AnonymousAggregateField")(u = (x = -1,))
	@test aaf.u.x == -1
	aaf = (@eval mod c"struct AnonymousAggregateField")(aaf, u = (x = 0,))
	@test aaf.u.x == 0
	
	aaf = (@eval mod c"struct NestedAnonymousAggregateField")(u = (x = (z = -1,),))
	@test aaf.u.x.z == -1
	aaf = (@eval mod c"struct NestedAnonymousAggregateField")(aaf, u = (x = (z = 0,),))
	@test aaf.u.x.z == 0
	
	# https://github.com/analytech-solutions/CBinding.jl/issues/8
	bl = (@eval mod c"struct BrokenLayout")()
	@test bl.x.y == 0 && bl.x.z == 0
	bl = (@eval mod c"struct BrokenLayout")(bl, x = (z = 123,))
	@test bl.x.y == 0 && bl.x.z == 123
	
	@test sizeof(@eval mod c"struct ArrayOfStruct") == 2*2*sizeof(Cint)
	aos = (@eval mod c"struct ArrayOfStruct")()
	@test typeof(aos) <: (@eval mod c"struct ArrayOfStruct")
	@test typeof(aos.x) <: Carray
	@test typeof(aos.x[2]) <: (@eval mod c"struct BrokenLayout")
	@test typeof(aos.x[2].x) <: Cstruct
	@test typeof(aos.x[2].x.y) <: Cint
	
	@test sizeof(@eval mod c"struct SmallEnumBitfield") == sizeof(@eval mod c"enum SmallEnum")
	x = (@eval mod c"struct SmallEnumBitfield")()
	@test getfield(x, :mem) == (0x00, 0x00, 0x00, 0x00)
	x = (@eval mod c"struct SmallEnumBitfield")(x, a = (@eval mod c"SMALL_1"))
	@test getfield(x, :mem) == (convert(UInt8, (@eval mod c"SMALL_1")), 0x00, 0x00, 0x00)
	x = (@eval mod c"struct SmallEnumBitfield")(x, b = (@eval mod c"SMALL_3"))
	@test getfield(x, :mem) == (convert(UInt8, (@eval mod c"SMALL_1")), convert(UInt8, (@eval mod c"SMALL_3")), 0x00, 0x00)
end

