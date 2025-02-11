

@testset "c\"... x[N];\"" begin
	@eval module CBinding_arrays
		using CBinding
		c``
		
		c"""
		typedef char CcharArray[2];
		
		typedef struct {
			int i;
		} CstructArray[10];
		
		struct CStruct {
			char c;
			int i;
		} __attribute__((packed));
		typedef struct CStruct CStructArray[2];
		
		struct Opaque;
		typedef struct Opaque *PtrArray[3];
		
		typedef int CarrayArray[4][2];
		
		struct UnknownLengthArray {
			int len;
			char str[];
		};
		
		struct file_format {
			unsigned char Header[2000];
		};
		"""
	end
	
	mod = @eval CBinding_arrays
	
	@test sizeof(@eval mod c"CcharArray") == sizeof(Cchar)*2
	
	@test sizeof(@eval mod c"CstructArray") == sizeof(Cint)*10
	
	@test sizeof(@eval mod c"CStructArray") == (sizeof(Cchar)+sizeof(Cint))*2
	
	@test sizeof(@eval mod c"PtrArray") == sizeof(Cptr)*3
	
	pa = (@eval mod c"PtrArray")()
	@test sizeof(pa) == sizeof(Cptr)*3
	@test length(pa) == 3
	@test eltype(pa) <: (@eval mod c"struct Opaque *")
	@test pa[1] isa (@eval mod c"struct Opaque *")
	
	for i in eachindex(pa)
		pa = (@eval mod c"PtrArray")(pa, i => C_NULL)
		@test pa[i] == C_NULL
		pa = (@eval mod c"PtrArray")(pa, i => (@eval mod c"struct Opaque *")(1234))
		@test pa[i] != C_NULL
	end
	
	pa = (@eval mod c"PtrArray")()
	for ptr in pa
		@test ptr == C_NULL
	end
	
	ca = (@eval mod c"CStructArray")()
	@test length(ca) == 2
	@test eltype(ca) <: (@eval mod c"struct CStruct")
	@test ca[2] isa (@eval mod c"struct CStruct")
	
	@test sizeof(@eval mod c"CarrayArray") == sizeof(Cint)*4*2
	@test eltype(@eval mod c"CarrayArray") <: (@eval mod c"int[2]")
	@test eltype(eltype(@eval mod c"CarrayArray")) <: Cint
	
	ca = (@eval mod c"CarrayArray")()
	@test length(ca) == 4
	@test length(ca[1]) == 2
	for i in eachindex(ca), j in eachindex(ca[i])
		@test ca[i][j] == 0
	end
	
	@test sizeof(@eval mod c"struct UnknownLengthArray") == sizeof(Cint)
	
	ula = (@eval mod c"struct UnknownLengthArray")()
	@test ula.len == 0
	@test ula.str isa Carray{Cchar}
	@test length(ula.str) == 0
	
	len = 10
	ptr = Libc.malloc(sizeof(@eval mod c"struct UnknownLengthArray") + len*sizeof(Cchar))
	
	ula = Cptr{@eval mod c"struct UnknownLengthArray"}(ptr)
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
	x = (@eval mod c"struct file_format")(Header = "test")
	@test x.Header[2] == Int('e')
	@test x.Header[2000] == 0
end


