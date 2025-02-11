

@testset "type accessors" begin
	@eval module CBinding_accessors
		using CBinding
		c``
		
		c"""
		struct AccessorInner {
			int i;
			int j:12;
		};
		
		struct AccessorOuter {
			int i;
			int j:12;
			struct AccessorInner inner;
			struct AccessorInner *ptr;
			struct {
				struct AccessorInner innerer;
			};
		};
		"""
	end
	
	mod = @eval CBinding_accessors
	
	ptr = Libc.malloc(@eval mod c"struct AccessorOuter")
	@test ptr != C_NULL
	
	x = reinterpret(Cptr{UInt8}, ptr)
	@test ptr.i == x
	@test ptr.inner == x+sizeof(Cint)*2
	@test ptr.inner.i == x+sizeof(Cint)*2
	@test ptr.ptr == x+sizeof(Cint)*2+sizeof(@eval mod c"struct AccessorInner")
	@test ptr.innerer == x+sizeof(Cint)*2+sizeof(@eval mod c"struct AccessorInner")+sizeof(@eval mod c"struct AccessorInner *")
	@test ptr.innerer.i == x+sizeof(Cint)*2+sizeof(@eval mod c"struct AccessorInner")+sizeof(@eval mod c"struct AccessorInner *")
	
	obj = (@eval mod c"struct AccessorOuter")()
	@test obj.i == 0
	@test obj.j == 0
	@test obj.inner.i == 0
	@test obj.inner.j == 0
	@test obj.ptr == C_NULL
	@test obj.innerer.i == 0
	@test obj.innerer.j == 0
	
	ptr[] = obj
	@test ptr.i[] == obj.i == 0
	@test ptr.j == obj.j == 0
	@test ptr.inner.i[] == obj.inner.i == 0
	@test ptr.inner.j == obj.inner.j == 0
	@test ptr.ptr[] == obj.ptr == C_NULL
	@test ptr.innerer.i[] == obj.inner.i == 0
	@test ptr.innerer.j == obj.inner.j == 0
	
	ptr.i[] = 1234
	ptr.j = 1
	ptr.inner.i[] = 4321
	ptr.inner.j = 2
	ptr.ptr[] = ptr.inner
	ptr.innerer[] = ptr.inner[]
	
	@test ptr.i[] == 1234
	@test ptr.j == 1
	@test ptr.inner.i[] == 4321
	@test ptr.inner.j == 2
	@test ptr.ptr[] == ptr.inner
	@test ptr.ptr.i[] == ptr.inner.i[]
	@test ptr.ptr.j == ptr.inner.j
	@test ptr.innerer.i[] == 4321
	@test ptr.innerer.j == 2
	
	ptr[] = obj
	@test ptr.i[] == obj.i == 0
	@test ptr.j == obj.j == 0
	@test ptr.inner.i[] == obj.inner.i == 0
	@test ptr.inner.j == obj.inner.j == 0
	@test ptr.ptr[] == obj.ptr == C_NULL
	@test ptr.innerer.i[] == obj.inner.i == 0
	@test ptr.innerer.j == obj.inner.j == 0
	
	Libc.free(ptr)
end

