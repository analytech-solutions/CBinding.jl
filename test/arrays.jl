

@testset "c\"... x[N];\"" begin
	c``
	
	@eval c"""
	typedef char CcharArray[2];
	"""
	@test sizeof(c"CcharArray") == sizeof(Cchar)*2
	
	@eval c"""
	typedef struct {
		int i;
	} CstructArray[10];
	"""
	@test sizeof(c"CstructArray") == sizeof(Cint)*10
	
	@eval c"""
	struct CStruct {
		char c;
		int i;
	} __attribute__((packed));
	typedef struct CStruct CStructArray[2];
	"""
	@test sizeof(c"CStructArray") == (sizeof(Cchar)+sizeof(Cint))*2
	
	@eval c"""
	struct Opaque;
	typedef struct Opaque *PtrArray[3];
	"""
	@test sizeof(c"PtrArray") == sizeof(Cptr)*3
	
	pa = c"PtrArray"()
	@test sizeof(pa) == sizeof(Cptr)*3
	@test length(pa) == 3
	@test eltype(pa) <: c"struct Opaque *"
	@test pa[1] isa c"struct Opaque *"
	
	for i in eachindex(pa)
		pa = c"PtrArray"(pa, i => C_NULL)
		@test pa[i] == C_NULL
		pa = c"PtrArray"(pa, i => c"struct Opaque *"(1234))
		@test pa[i] != C_NULL
	end
	
	pa = c"PtrArray"()
	for ptr in pa
		@test ptr == C_NULL
	end
	
	ca = c"CStructArray"()
	@test length(ca) == 2
	@test eltype(ca) <: c"struct CStruct"
	@test ca[2] isa c"struct CStruct"
	
	@eval c"""
	typedef int CarrayArray[4][2];
	"""
	@test sizeof(c"CarrayArray") == sizeof(Cint)*4*2
	@test eltype(c"CarrayArray") <: c"int[2]"
	@test eltype(eltype(c"CarrayArray")) <: Cint
	
	ca = c"CarrayArray"()
	@test length(ca) == 4
	@test length(ca[1]) == 2
	for i in eachindex(ca), j in eachindex(ca[i])
		@test ca[i][j] == 0
	end
	
	@eval c"""
	struct UnknownLengthArray {
		int len;
		char str[];
	};
	"""
	@test sizeof(c"struct UnknownLengthArray") == sizeof(Cint)
	
	ula = c"struct UnknownLengthArray"()
	@test ula.len == 0
	@test ula.str isa Carray{Cchar}
	@test length(ula.str) == 0
	
	len = 10
	ptr = Libc.malloc(sizeof(c"struct UnknownLengthArray") + len*sizeof(Cchar))
	
	ula = Cptr{c"struct UnknownLengthArray"}(ptr)
	@test ula.len isa Cptr{Cint}
	@test ula.len == ptr
	
	ula.len[] = len
	@test ula.str isa Cptr{<:Carray{Cchar}}
	@test ula.str == ptr + sizeof(Cint)
	@test ula.str[1] isa Cptr{Cchar}
	@test ula.str[1] == ptr + sizeof(Cint)
	@test ula.str[5] isa Cptr{Cchar}
	@test ula.str[5] == ptr + sizeof(Cint) + 4*sizeof(Cchar)
	
	ula.str[1][] = 1
	ula.str[5][] = 5
	@test ula.str[1][] == 1
	@test ula.str[5][] == 5
	
	Libc.free(ptr)
	
	# https://github.com/analytech-solutions/CBinding.jl/issues/66
	@eval c"""
	struct file_format {
		unsigned char Header[2000];
	};
	"""
	x = c"struct file_format"(Header = "test")
	@test x.Header[2] == Int('e')
	@test x.Header[2000] == 0
end


