

function checkJL(expr, val)
	def = expr
	def = replace(def, r"(\w+)::(\w+):(\d+)" => s"(\1:\3)::\2")
	
	X = @eval module $(gensym())
		using CBinding
		c`-std=c99`
		c"""
		#include <stdalign.h>
		"""s
		const X = @c_str $(expr)
	end
	
	x = Base.invokelatest(X.X)
	result = []
	push!(result, "$(string(sizeof(x))): $(bytes2hex(UInt8[getfield(x, :mem)...,]))")
	types = Base.invokelatest(fieldtypes, X.X)
	for (ind, prop) in enumerate(Base.invokelatest(fieldnames, X.X))
		v1 = sizeof(types[ind]) < sizeof(val) ? Core.Intrinsics.trunc_int(types[ind], val) : reinterpret(types[ind], val)
		x = Base.invokelatest(X.X; (prop => v1,)...)
		v2 = Base.invokelatest(getproperty, x, prop)
		x = Base.invokelatest(X.X; (prop => v2,)...)
		v3 = Base.invokelatest(getproperty, x, prop)
		@test v2 === v3
		push!(result, "$(String(prop)): $(bytes2hex(UInt8[getfield(x, :mem)...,]))")
	end
	return result
end


function checkC(expr, val)
	props = []
	for line in split(expr, '\n')
		m = match(r"^\s*(?:_Alignas\S+\s+)?((?:(?:char|short|int|long|float|double|}|}\s+__attribute__\S+)\s+)+)([cexsilfd]+)[:\d]*;\s*$", line)
		isnothing(m) || push!(props, m.captures[2] => strip(m.captures[1]))
	end
	m = match(r"^\s*(struct|union)\s+(\S+)", expr)
	(kind, name) = m.captures[end-1:end]
	
	use = []
	push!(use, """
		$(kind) $(name) x; memset(&x, 0, sizeof(x));
		printf("%ld: ", sizeof(x));
		for (int i = 0;i < sizeof(x);i++) printf("%02x", (unsigned int)(*(((unsigned char*)&x)+i)));
		printf("\\n");
		"""
	)
	for (prop, typ) in props
		setprop = "x.$(prop)"
		if typ == "float"
			setprop = "*((unsigned int *)&($(setprop))) = $(repr(Core.Intrinsics.trunc_int(UInt64, val)));"
		elseif typ == "double"
			setprop = "*((unsigned long long *)&($(setprop))) = $(repr(Core.Intrinsics.trunc_int(UInt64, val)));"
		elseif typ == "long double"
			setprop = """
				*(((unsigned long long *)&($(setprop)))+0) = $(repr(Core.Intrinsics.trunc_int(UInt64, val)));
				*(((unsigned long long *)&($(setprop)))+1) = $(repr(Core.Intrinsics.trunc_int(UInt64, val>>64)));"""
		else
			setprop = "$(setprop) = $(repr(Core.Intrinsics.trunc_int(UInt64, val)));"
		end
		push!(use, """
			$(kind) $(name) x; memset(&x, 0, sizeof(x));
			$(setprop)
			printf("%s: ", $(repr(prop)));
			for (int i = 0;i < sizeof(x);i++) printf("%02x", (unsigned int)(*(((unsigned char*)&x)+i)));
			printf("\\n");
			"""
		)
	end
	use = "{\n"*join(use, "}\n{\n")*"}\n"
	
	code = """
		#include <stdio.h>
		#include <stdalign.h>
		#include <string.h>
		
		$(expr)
		
		int main(int argc, char **argv) {
			$(use)
			
			return 0;
		}
		"""
	
	return withenv() do
		bin = CBinding.libclang.Clang_jll.clang()
		tmp = tempname()
		open(f -> write(f, code), tmp*".c", "w+")
		run(`gcc -Wno-overflow -Wno-constant-conversion -Wno-address-of-packed-member -std=c99 -o $(tmp) $(tmp).c`)
		return readlines(`$(tmp)`)
	end
end



const LAYOUT_TESTS = [
"""struct T {
};""",

"""struct T {
	char c;
};""",

"""struct T {
	short s;
};""",

"""struct T {
	int i;
};""",

"""struct T {
	long l;
};""",

"""struct T {
	long long ll;
};""",

"""struct T {
	char x;
	char c;
};""",

"""struct T {
	char x;
	short s;
};""",

"""struct T {
	char x;
	int i;
};""",

"""struct T {
	char x;
	long l;
};""",

"""struct T {
	char x;
	long long ll;
};""",

"""struct T {
	char x;
	float f;
};""",

"""struct T {
	char x;
	double d;
};""",

"""struct T {
	char x;
	long double ld;
};""",

"""struct T {
	char c:3;
};""",

"""struct T {
	short s:3;
};""",

"""struct T {
	int i:3;
};""",

"""struct T {
	long l:3;
};""",

"""struct T {
	long long ll:3;
};""",

"""struct T {
	char x:3;
	char c;
};""",

"""struct T {
	char x:3;
	short s;
};""",

"""struct T {
	char x:3;
	int i;
};""",

"""struct T {
	char x:3;
	long l;
};""",

"""struct T {
	char x:3;
	long long ll;
};""",

"""struct T {
	char x:3;
	float f;
};""",

"""struct T {
	char x:3;
	double d;
};""",

"""struct T {
	char x:3;
	long double ld;
};""",

"""struct T {
	char c:3;
	char x;
};""",

"""struct T {
	short s:3;
	char x;
};""",

"""struct T {
	int i:3;
	char x;
};""",

"""struct T {
	long l:3;
	char x;
};""",

"""struct T {
	long long ll:3;
	char x;
};""",

"""struct T {
	char x:3;
	char c:3;
};""",

"""struct T {
	char x:3;
	short s:3;
};""",

"""struct T {
	char x:3;
	int i:3;
};""",

"""struct T {
	char x:3;
	long l:3;
};""",

"""struct T {
	char x:3;
	long long ll:3;
};""",

"""struct T {
	char x:3;
	char c:5;
};""",

"""struct T {
	char x:3;
	short s:13;
};""",

"""struct T {
	char x:3;
	int i:29;
};""",

"""struct T {
	char x:3;
	long l:29;
};""",

"""struct T {
	char x:3;
	long long ll:61;
};""",

"""struct T {
	char x:3;
	struct {
		char c:3;
	};
};""",

"""struct T {
	char x:3;
	struct {
		short s:3;
	};
};""",

"""struct T {
	char x:3;
	struct {
		int i:3;
	};
};""",

"""struct T {
	char x:3;
	struct {
		long l:3;
	};
};""",

"""struct T {
	char x:3;
	struct {
		long long ll:3;
	};
};""",

"""struct T {
	char x:3;
	struct {
		char c:3;
	};
};""",

"""struct T {
	short x:3;
	struct {
		short s:3;
	};
};""",

"""struct T {
	int x:3;
	struct {
		int i:3;
	};
};""",

"""struct T {
	long x:3;
	struct {
		long l:3;
	};
};""",

"""struct T {
	long long x:3;
	struct {
		long long ll:3;
	};
};""",

"""struct T {
	char x:3;
	union {
		char c:3;
	};
};""",

"""struct T {
	char x:3;
	union {
		short s:3;
	};
};""",

"""struct T {
	char x:3;
	union {
		int i:3;
	};
};""",

"""struct T {
	char x:3;
	union {
		long l:3;
	};
};""",

"""struct T {
	char x:3;
	union {
		long long ll:3;
	};
};""",

"""struct T {
	char x:3;
	union {
		char c:3;
	};
};""",

"""struct T {
	short x:3;
	union {
		short s:3;
	};
};""",

"""struct T {
	int x:3;
	union {
		int i:3;
	};
};""",

"""struct T {
	long x:3;
	union {
		long l:3;
	};
};""",

"""struct T {
	long long x:3;
	union {
		long long ll:3;
	};
};""",

"""struct T {
	char x:3;
	_Alignas(sizeof(char)*2) struct {
		char c:3;
	};
};""",

"""struct T {
	short x:3;
	_Alignas(sizeof(short)*2) struct {
		short s:3;
	};
};""",

"""struct T {
	int x:3;
	_Alignas(sizeof(int)*2) struct {
		int i:3;
	};
};""",

"""struct T {
	long x:3;
	_Alignas(sizeof(long)*2) struct {
		long l:3;
	};
};""",

"""struct T {
	long long x:3;
	_Alignas(sizeof(long long)*2) struct {
		long long ll:3;
	};
};""",

"""struct T {
	char x:3;
	struct {
		_Alignas(sizeof(int)*2) char c;
	};
};""",

"""struct T {
	short x:3;
	struct {
		_Alignas(sizeof(int)*2) char c;
	};
};""",

"""struct T {
	int x:3;
	struct {
		_Alignas(sizeof(int)*2) char c;
	};
};""",

"""struct T {
	long x:3;
	struct {
		_Alignas(sizeof(int)*2) char c;
	};
};""",

"""struct T {
	long long x:3;
	struct {
		_Alignas(sizeof(int)*2) char c;
	};
};""",

"""struct T {
	char x:3;
	struct {
		char c:3;
	} __attribute__((packed));
};""",

"""struct T {
	char x:3;
	struct {
		short s:3;
	} __attribute__((packed));
};""",

"""struct T {
	char x:3;
	struct {
		int i:3;
	} __attribute__((packed));
};""",

"""struct T {
	char x:3;
	struct {
		long l:3;
	} __attribute__((packed));
};""",

"""struct T {
	char x:3;
	struct {
		long long ll:3;
	} __attribute__((packed));
};""",

"""struct T {
	char x:3;
	struct {
		char c:3;
	} __attribute__((packed));
};""",

"""struct T {
	short x:3;
	struct {
		short s:3;
	} __attribute__((packed));
};""",

"""struct T {
	int x:3;
	struct {
		int i:3;
	} __attribute__((packed));
};""",

"""struct T {
	long x:3;
	struct {
		long l:3;
	} __attribute__((packed));
};""",

"""struct T {
	long long x:3;
	struct {
		long long ll:3;
	} __attribute__((packed));
};""",

"""struct T {
	char x:3;
	union {
		char c:3;
	} __attribute__((packed));
};""",

"""struct T {
	char x:3;
	union {
		short s:3;
	} __attribute__((packed));
};""",

"""struct T {
	char x:3;
	union {
		int i:3;
	} __attribute__((packed));
};""",

"""struct T {
	char x:3;
	union {
		long l:3;
	} __attribute__((packed));
};""",

"""struct T {
	char x:3;
	union {
		long long ll:3;
	} __attribute__((packed));
};""",

"""struct T {
	char x:3;
	union {
		char c:3;
	} __attribute__((packed));
};""",

"""struct T {
	short x:3;
	union {
		short s:3;
	} __attribute__((packed));
};""",

"""struct T {
	int x:3;
	union {
		int i:3;
	} __attribute__((packed));
};""",

"""struct T {
	long x:3;
	union {
		long l:3;
	} __attribute__((packed));
};""",

"""struct T {
	long long x:3;
	union {
		long long ll:3;
	} __attribute__((packed));
};""",

"""struct T {
	char x:3;
	_Alignas(sizeof(char)*2) struct {
		char c:3;
	} __attribute__((packed));
};""",

"""struct T {
	short x:3;
	_Alignas(sizeof(short)*2) struct {
		short s:3;
	} __attribute__((packed));
};""",

"""struct T {
	int x:3;
	_Alignas(sizeof(int)*2) struct {
		int i:3;
	} __attribute__((packed));
};""",

"""struct T {
	long x:3;
	_Alignas(sizeof(long)*2) struct {
		long l:3;
	} __attribute__((packed));
};""",

"""struct T {
	long long x:3;
	_Alignas(sizeof(long long)*2) struct {
		long long ll:3;
	} __attribute__((packed));
};""",

"""struct T {
	char x:3;
	struct {
		_Alignas(sizeof(int)*2) char c;
	} __attribute__((packed));
};""",

"""struct T {
	short x:3;
	struct {
		_Alignas(sizeof(int)*2) char c;
	} __attribute__((packed));
};""",

"""struct T {
	int x:3;
	struct {
		_Alignas(sizeof(int)*2) char c;
	} __attribute__((packed));
};""",

"""struct T {
	long x:3;
	struct {
		_Alignas(sizeof(int)*2) char c;
	} __attribute__((packed));
};""",

"""struct T {
	long long x:3;
	struct {
		_Alignas(sizeof(int)*2) char c;
	} __attribute__((packed));
};""",

"""struct T {
	enum {
		VAL1,
		VAL2,
		VAL3,
	} e;
};""",

"""struct T {
	enum {
		VAL1,
		VAL2 = VAL1,
		VAL3 = 1 << 10,
	} e;
};""",

"""struct T {
	enum {
		VAL1 = -1,
		VAL2 = 0,
		VAL3 = 1,
	} e;
};""",

"""struct T {
	enum {
		VAL1 = -1,
		VAL2 = 0,
		VAL3 = 0xffffffff,
	} e;
};""",

"""struct T {
	char x;
	enum {
		VAL1,
		VAL2,
		VAL3,
	} e;
};""",

"""struct T {
	char x;
	enum {
		VAL1,
		VAL2 = VAL1,
		VAL3 = 1 << 10,
	} e;
};""",

"""struct T {
	char x;
	enum {
		VAL1 = -1,
		VAL2 = 0,
		VAL3 = 1,
	} e;
};""",

"""struct T {
	char x;
	enum {
		VAL1 = -1,
		VAL2 = 0,
		VAL3 = 0xffffffff,
	} e;
};""",

"""struct T {
	char x:3;
	enum {
		VAL1,
		VAL2,
		VAL3,
	} e;
};""",

"""struct T {
	char x:3;
	enum {
		VAL1,
		VAL2 = VAL1,
		VAL3 = 1 << 10,
	} e;
};""",

"""struct T {
	char x:3;
	enum {
		VAL1 = -1,
		VAL2 = 0,
		VAL3 = 1,
	} e;
};""",

"""struct T {
	char x:3;
	enum {
		VAL1 = -1,
		VAL2 = 0,
		VAL3 = 0xffffffff,
	} e;
};""",

"""struct T {
	enum {
		VAL1,
		VAL2,
		VAL3,
	} __attribute__((packed)) e;
};""",

"""struct T {
	enum {
		VAL1,
		VAL2 = VAL1,
		VAL3 = 1 << 10,
	} __attribute__((packed)) e;
};""",

"""struct T {
	enum {
		VAL1 = -1,
		VAL2 = 0,
		VAL3 = 1,
	} __attribute__((packed)) e;
};""",

"""struct T {
	enum {
		VAL1 = -1,
		VAL2 = 0,
		VAL3 = 0xffffffff,
	} __attribute__((packed)) e;
};""",

"""struct T {
	char x;
	enum {
		VAL1,
		VAL2,
		VAL3,
	} __attribute__((packed)) e;
};""",

"""struct T {
	char x;
	enum {
		VAL1,
		VAL2 = VAL1,
		VAL3 = 1 << 10,
	} __attribute__((packed)) e;
};""",

"""struct T {
	char x;
	enum {
		VAL1 = -1,
		VAL2 = 0,
		VAL3 = 1,
	} __attribute__((packed)) e;
};""",

"""struct T {
	char x;
	enum {
		VAL1 = -1,
		VAL2 = 0,
		VAL3 = 0xffffffff,
	} __attribute__((packed)) e;
};""",

"""struct T {
	char x:3;
	enum {
		VAL1,
		VAL2,
		VAL3,
	} __attribute__((packed)) e;
};""",

"""struct T {
	char x:3;
	enum {
		VAL1,
		VAL2 = VAL1,
		VAL3 = 1 << 10,
	} __attribute__((packed)) e;
};""",

"""struct T {
	char x:3;
	enum {
		VAL1 = -1,
		VAL2 = 0,
		VAL3 = 1,
	} __attribute__((packed)) e;
};""",

"""struct T {
	char x:3;
	enum {
		VAL1 = -1,
		VAL2 = 0,
		VAL3 = 0xffffffff,
	} __attribute__((packed)) e;
};""",
]
