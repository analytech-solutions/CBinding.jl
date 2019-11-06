
@testset "@cstruct" begin
	@cstruct OpaqueStruct
	@cstruct OpaqueStruct
	@test_throws ErrorException sizeof(OpaqueStruct)
	@test sizeof(Ptr{OpaqueStruct}) == sizeof(Ptr{Cvoid})
	
	@cstruct EmptyStruct {
	} __packed__
	@test sizeof(EmptyStruct) == 0
	
	@cstruct CcharStruct {
		c::Cchar
	} __packed__
	@test sizeof(CcharStruct) == sizeof(Cchar)
	@test :c in propertynames(CcharStruct)
	
	@cstruct CintStruct {
		i::Cint
	} __packed__
	@test sizeof(CintStruct) == sizeof(Cint)
	@test :i in propertynames(CintStruct)
	
	@cstruct CstructStruct {
		i::CintStruct
	} __packed__
	@test sizeof(CstructStruct) == sizeof(CintStruct)
	@test :i in propertynames(CstructStruct)
	
	@cstruct CintCcharStruct {
		i::CintStruct
		c::CcharStruct
	} __packed__
	@test sizeof(CintCcharStruct) == sizeof(CintStruct)+sizeof(CcharStruct)
	@test :i in propertynames(CintCcharStruct)
	@test :c in propertynames(CintCcharStruct)
	
	@cstruct CcharCintPackedStruct {
		c::CcharStruct
		i::CintStruct
	} __packed__
	@test sizeof(CcharCintPackedStruct) == sizeof(CintStruct)+sizeof(CcharStruct)
	@test :c in propertynames(CcharCintPackedStruct)
	@test :i in propertynames(CcharCintPackedStruct)
	
	@cstruct CcharCintAlignedStruct {
		c::CcharStruct
		@calign sizeof(CintStruct)
		i::CintStruct
	} __packed__
	@test sizeof(CcharCintAlignedStruct) == max(sizeof(CintStruct), sizeof(Cint))+max(sizeof(CcharStruct), sizeof(Cint))
	@test :c in propertynames(CcharCintAlignedStruct)
	@test :i in propertynames(CcharCintAlignedStruct)
	
	@cstruct CunionStruct {
		@cunion {
			c::Cuchar[4]
			s::Cushort[2]
			i::Cuint
		} __packed__
	} __packed__
	@test :c in propertynames(CunionStruct)
	@test :s in propertynames(CunionStruct)
	@test :i in propertynames(CunionStruct)
	
	@cstruct PtrToStructStruct
	@cstruct PtrToPtrToStructStruct {
		p::Ptr{PtrToStructStruct}
	} __packed__
	@cstruct PtrToStructStruct {
		p::Ptr{PtrToStructStruct}
	} __packed__
	@test sizeof(PtrToPtrToStructStruct) == sizeof(Ptr)
	@test :p in propertynames(PtrToPtrToStructStruct)
	@test sizeof(PtrToStructStruct) == sizeof(Ptr)
	@test :p in propertynames(PtrToStructStruct)
	
	cus = CunionStruct()
	@test cus.i == 0
	@test cus.c[1] == 0
	@test cus.c[4] == 0
	@test cus.s[1] == 0
	@test cus.s[2] == 0
	cus.i = 0xff0000ff
	@test cus.i == 0xff0000ff
	@test cus.c[1] == 0xff
	@test cus.c[4] == 0xff
	@test cus.s[1] != 0
	@test cus.s[2] != 0
	
	
	@cstruct Cint32Bitfield {
		(i:32)::Cint
	} __packed__
	@test sizeof(Cint32Bitfield) == sizeof(Cint)
	@test :i in propertynames(Cint32Bitfield)
	
	@cstruct Cuint32Bitfield {
		(u:32)::Cuint
	} __packed__
	@test sizeof(Cuint32Bitfield) == sizeof(Cuint)
	@test :u in propertynames(Cuint32Bitfield)
	
	@cstruct Cint2Bitfield {
		(i:2)::Cint
	} __packed__
	@test sizeof(Cint2Bitfield) == sizeof(Cchar)
	@test :i in propertynames(Cint2Bitfield)
	
	@cstruct Cuint2Bitfield {
		(u:2)::Cuint
	} __packed__
	@test sizeof(Cuint2Bitfield) == sizeof(Cchar)
	@test :u in propertynames(Cuint2Bitfield)
	
	@cstruct Cuint32Cint32Bitfields {
		(u:32)::Cuint
		(i:32)::Cint
	} __packed__
	@test sizeof(Cuint32Cint32Bitfields) == sizeof(Cuint)+sizeof(Cint)
	@test :u in propertynames(Cuint32Cint32Bitfields)
	@test :i in propertynames(Cuint32Cint32Bitfields)
	
	@cstruct Cuint16Cint16Bitfields {
		(u:16)::Cuint
		(i:16)::Cint
	} __packed__
	@test sizeof(Cuint16Cint16Bitfields) == sizeof(Cuint)
	@test :u in propertynames(Cuint16Cint16Bitfields)
	@test :i in propertynames(Cuint16Cint16Bitfields)
	
	@cstruct Cint16Cint16Bitfields {
		(i1:16)::Cint
		(i2:16)::Cint
	} __packed__
	@test sizeof(Cint16Cint16Bitfields) == sizeof(Cuint)
	
	@cstruct Cint16CalignCint16Bitfields {
		(i1:16)::Cint
		@calign sizeof(Cint)
		(i2:16)::Cint
	} __packed__
	@test sizeof(Cint16CalignCint16Bitfields) == sizeof(Cint)*2
	
	@cstruct Cint16CintBitfields {
		(u:16)::Cuint
		i::Cint
	} __packed__
	@test sizeof(Cint16CintBitfields) == 2+sizeof(Cint)
	@test :u in propertynames(Cint16CintBitfields)
	@test :i in propertynames(Cint16CintBitfields)
	
	bf = Cuint16Cint16Bitfields()
	@test bf.u == 0
	@test bf.i == 0
	bf.i = Cint(-1)
	@test bf.u == 0
	@test bf.i == -1
	bf.u = Cuint(0x0001)
	@test bf.u == 0x0001
	@test bf.i == -1
	
	bf = Cint16CalignCint16Bitfields()
	@test bf.i1 == 0
	@test bf.i2 == 0
	bf.i1 = -1
	@test bf.i1 == -1
	@test bf.i2 == 0
	bf.i2 = -1
	@test bf.i1 == -1
	@test bf.i2 == -1
	bf.i2 = 32768
	@test bf.i1 == -1
	@test bf.i2 < 0
	
	# https://github.com/analytech-solutions/CBinding.jl/issues/6
	@cstruct AnonymousAggregateField {
		u::@cunion {
			x::Cint
			y::Cchar
		}
	}
	aaf = AnonymousAggregateField(u = (x = -1,))
	@test aaf.u.x == -1
	aaf.u = (x = 0,)
	@test aaf.u.x == 0
	
	@cstruct NestedAnonymousAggregateField {
		u::@cunion {
			x::@cunion {
				z::Cint
			}
			y::Cchar
		}
	}
	aaf = NestedAnonymousAggregateField(u = (x = (z = -1,),))
	@test aaf.u.x.z == -1
	aaf.u = (x = (z = 0,),)
	@test aaf.u.x.z == 0
	
	# https://github.com/analytech-solutions/CBinding.jl/issues/8
	@cstruct BrokenLayout {
		x::@cstruct {
			y::Cint
			z::Cint
		}
	}
	bl = BrokenLayout()
	@test bl.x.y == 0 && bl.x.z == 0
	bl.x.z = 123
	@test bl.x.y == 0 && bl.x.z == 123
	
	@cstruct ArrayOfStruct {
		x::BrokenLayout[2]
	}
	@test sizeof(ArrayOfStruct) == 2*2*sizeof(Cint)
	aos = ArrayOfStruct()
	@test typeof(aos.x) <: CBinding.Caccessor
	@test typeof(aos.x[]) <: Carray
	@test typeof(aos.x[2]) <: CBinding.Caccessor
	@test typeof(aos.x[2][]) <: BrokenLayout
	@test typeof(aos.x[2].x) <: CBinding.Caccessor
	@test typeof(aos.x[2].x.y) <: Cint
end

