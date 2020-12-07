

@testset "@carray" begin
	CcharArray = @carray Cchar[2]
	@test sizeof(CcharArray) == sizeof(Cchar)*2
	
	CstructArray = @carray (@eval @cstruct {
		i::Cint
	} __packed__)[10]
	@test sizeof(CstructArray) == sizeof(Cint)*10
	
	@eval @cstruct CStruct {
		i::Cint
	} __packed__
	CStructArray = @carray CStruct[2]
	@test sizeof(CStructArray) == sizeof(Cint)*2
	
	@eval @cstruct Opaque
	PtrArray = @carray Ptr{Opaque}[3]
	@test sizeof(PtrArray) == sizeof(Ptr)*3
	
	pa = PtrArray(undef)
	@test sizeof(pa) == sizeof(Ptr)*3
	@test length(pa) == 3
	@test eltype(pa) === Ptr{Opaque}
	@test pa[1] isa Ptr{Opaque}
	
	for i in eachindex(pa)
		pa[i] = C_NULL
		@test pa[i] == C_NULL
		pa[i] = Ptr{Opaque}(1)
		@test pa[i] != C_NULL
	end
	
	pa = PtrArray(zero)
	for ptr in pa
		@test ptr == C_NULL
	end
	
	ca = CStructArray(zero)
	@test length(ca) == 2
	@test eltype(ca) === CStruct
	@test ca[2] isa CBinding.Caccessor{CStruct}
	
	CarrayArray = @carray Cint[4][2]
	@test sizeof(CarrayArray) == sizeof(Cint)*4*2
	@test eltype(CarrayArray) === @carray Cint[4]
	@test eltype(eltype(CarrayArray)) === Cint
	
	ca = CarrayArray(zero)
	@test length(ca) == 2
	@test length(ca[1]) == 4
	for i in eachindex(ca), j in eachindex(ca[i])
		@test ca[i] isa CBinding.Caccessor{@carray Cint[4]}
		@test ca[i][j] == 0
	end
end


