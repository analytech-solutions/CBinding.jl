using Test: @testset, @test, @test_throws, @test_broken
using Random
using CBinding


function checkJL(expr, val)
	def = expr
	def = replace(def, r"(\n\s+)([^:\n]+)(::)([^:\n]+)(:)(\d+)" => s"\1(\2\5\6)\3\4")
	
	X = @eval module $(gensym())
		using CBinding
		@ctypedef X $(Meta.parse(def))
	end
	
	x = Base.invokelatest(X.X)
	result = []
	push!(result, "$(string(sizeof(x))): $(bytes2hex(UInt8[getfield(x, :mem)...,]))")
	types = Base.invokelatest(CBinding.propertytypes, x)
	for (ind, prop) in enumerate(Base.invokelatest(propertynames, x))
		x = Base.invokelatest(X.X)
		Base.invokelatest(setproperty!, x, prop, sizeof(types[ind]) < sizeof(val) ? Core.Intrinsics.trunc_int(types[ind], val) : reinterpret(types[ind], val))
		push!(result, "$(String(prop)): $(bytes2hex(UInt8[getfield(x, :mem)...,]))")
	end
	return result
end


FILE_COUNT = 0
function checkC(expr, val)
	global FILE_COUNT
	FILE_COUNT += 1
	file = string(FILE_COUNT, pad = 4)
	expectedFile = joinpath("expected", "$(file).txt")
	if !isfile(expectedFile) || get(ENV, "GENERATE_EXPECTED", nothing) == "1"
		props = []
		for line in split(expr, '\n')
			m = match(r"^\s*([^:]+)::(Cchar|Cshort|Cint|Clonglong|Cuchar|Cushort|Cuint|Culonglong|Culong|Cfloat|Cdouble|Clongdouble|Clong|@cenum)", line)
			isnothing(m) || push!(props, m.captures[end-1] => m.captures[end])
		end
		m = match(r"^\s*@c(struct|union)\s+(\S+)", expr)
		(kind, name) = m.captures[end-1:end]
		
		def = expr
		def = replace(def, r"(\n\s+)([^:\n]+)(::@cenum)([^}]+)(})" => s"\1enum\4\5 \2")
		def = replace(def, "\n" => ";\n")
		def = replace(def, "{;" => "{")
		def = replace(def, ",;" => ",")
		def = replace(def, "__packed__" => "__attribute__((__packed__))")
		def = replace(def, r"@c(struct|union)" => s"\1")
		def = replace(def, r"@calign\s+([^;]+);\n" => s"alignas(\1)")
		def = replace(def, r"(\w+)::(Cchar|Cshort|Cint|Clonglong|Cuchar|Cushort|Cuint|Culonglong|Culong|Cfloat|Cdouble|Clongdouble|Clong)" => s"\2 \1")
		def = replace(def, "Cchar" => "signed char")
		def = replace(def, "Cshort" => "signed short")
		def = replace(def, "Cint" => "signed int")
		def = replace(def, "Clonglong" => "signed long long")
		def = replace(def, "Cuchar" => "unsigned char")
		def = replace(def, "Cushort" => "unsigned short")
		def = replace(def, "Cuint" => "unsigned int")
		def = replace(def, "Culonglong" => "unsigned long long")
		def = replace(def, "Culong" => "unsigned long")
		def = replace(def, "Cfloat" => "float")
		def = replace(def, "Cdouble" => "double")
		def = replace(def, "Clongdouble" => "long double")
		def = replace(def, "Clong" => "signed long")
		
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
			if typ == "Cfloat"
				setprop = "*((unsigned int *)&($(setprop))) = $(repr(Core.Intrinsics.trunc_int(UInt64, val)));"
			elseif typ == "Cdouble"
				setprop = "*((unsigned long long *)&($(setprop))) = $(repr(Core.Intrinsics.trunc_int(UInt64, val)));"
			elseif typ == "Clongdouble"
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
			#include <inttypes.h>
			
			$(def)
			
			int main(int argc, char **argv) {
				$(use)
				
				return 0;
			}
			"""
		
		open(f -> write(f, code), ".$(file).c", "w+")
		run(`gcc -Wno-overflow -std=c99 -o check .$(file).c`)
		expected = read(`./check`)
		open(f -> write(f, expected), expectedFile, "w+")
	end
	
	return readlines(expectedFile)
end


include("layout-tests.jl")

@testset "CBinding" begin
	@testset "Layout algorithms" begin
		rng = MersenneTwister(0)
		for _test in LAYOUT_TESTS
			for aggregate in ("@cstruct", "@cunion")
				for strategy in ("__packed__", "__native__")
					for val in (:random, :ones)
						val = val === :ones ? Core.Intrinsics.sext_int(UInt128, 0xff) : rand(rng, UInt128)
						test = replace(_test, r"^\s*@cstruct" => aggregate)
						test = replace(test, r"}\s*$" => "} $(strategy)\n")
						@debug test
						@test checkC(test, val) == checkJL(test, val)
					end
				end
			end
		end
	end
	
	
	@testset "@cstruct" begin
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
		@test sizeof(Cuint16Cint16Bitfields) == sizeof(Cuint)
		
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
	end
	
	
	@testset "@cunion" begin
		@cunion EmptyUnion {
		} __packed__
		@test sizeof(EmptyUnion) == 0
		
		@cunion CcharUnion {
			c::Cchar
		} __packed__
		@test sizeof(CcharUnion) == sizeof(Cchar)
		@test :c in propertynames(CcharUnion)
		
		@cunion CintUnion {
			i::Cint
		} __packed__
		@test sizeof(CintUnion) == sizeof(Cint)
		@test :i in propertynames(CintUnion)
		
		@cunion CunionUnion {
			i::CintUnion
		} __packed__
		@test sizeof(CunionUnion) == sizeof(CintUnion)
		@test :i in propertynames(CunionUnion)
		
		@cunion CintCcharUnion {
			i::CintUnion
			c::CcharUnion
		} __packed__
		@test sizeof(CintCcharUnion) == max(sizeof(CintUnion), sizeof(CcharUnion))
		@test :i in propertynames(CintCcharUnion)
		@test :c in propertynames(CintCcharUnion)
		
		@cunion CcharCintPackedUnion {
			c::CcharUnion
			i::CintUnion
		} __packed__
		@test sizeof(CcharCintPackedUnion) == max(sizeof(CintUnion), sizeof(CcharUnion))
		@test :c in propertynames(CcharCintPackedUnion)
		@test :i in propertynames(CcharCintPackedUnion)
		
		@cunion CcharCintAlignedUnion {
			c::CcharUnion
			@calign sizeof(CintUnion)
			i::CintUnion
		} __packed__
		@test sizeof(CcharCintAlignedUnion) == max(max(sizeof(CintUnion), sizeof(Cint)), max(sizeof(CcharUnion), sizeof(Cint)))
		@test :c in propertynames(CcharCintAlignedUnion)
		@test :i in propertynames(CcharCintAlignedUnion)
		
		@cunion CunionUnion {
			@cunion {
				c::Cuchar[4]
				s::Cushort[2]
				i::Cuint
			} __packed__
		} __packed__
		@test :c in propertynames(CunionUnion)
		@test :s in propertynames(CunionUnion)
		@test :i in propertynames(CunionUnion)
		
		@cunion PtrToPtrToUnionUnion {
			p::Ptr{PtrToUnionUnion}
		} __packed__
		@cunion PtrToUnionUnion {
			p::Ptr{PtrToUnionUnion}
		} __packed__
		@test sizeof(PtrToPtrToUnionUnion) == sizeof(Ptr)
		@test :p in propertynames(PtrToPtrToUnionUnion)
		@test sizeof(PtrToUnionUnion) == sizeof(Ptr)
		@test :p in propertynames(PtrToUnionUnion)
		
		cuu = CunionUnion()
		@test cuu.i == 0
		@test cuu.c[1] == 0
		@test cuu.c[4] == 0
		@test cuu.s[1] == 0
		@test cuu.s[2] == 0
		cuu.i = 0xff0000ff
		@test cuu.i == 0xff0000ff
		@test cuu.c[1] == 0xff
		@test cuu.c[4] == 0xff
		@test cuu.s[1] != 0
		@test cuu.s[2] != 0
		
		
		@cunion Cint32BitfieldUnion {
			(i:32)::Cint
		} __packed__
		@test sizeof(Cint32BitfieldUnion) == sizeof(Cint)
		@test :i in propertynames(Cint32BitfieldUnion)
		
		@cunion Cuint32BitfieldUnion {
			(u:32)::Cuint
		} __packed__
		@test sizeof(Cuint32BitfieldUnion) == sizeof(Cuint)
		@test :u in propertynames(Cuint32BitfieldUnion)
		
		@cunion Cint2BitfieldUnion {
			(i:2)::Cint
		} __packed__
		@test sizeof(Cint2BitfieldUnion) == 1
		@test :i in propertynames(Cint2BitfieldUnion)
		
		@cunion Cuint2BitfieldUnion {
			(u:2)::Cuint
		} __packed__
		@test sizeof(Cuint2BitfieldUnion) == 1
		@test :u in propertynames(Cuint2BitfieldUnion)
		
		@cunion Cuint32Cint32BitfieldsUnion {
			(u:32)::Cuint
			(i:32)::Cint
		} __packed__
		@test sizeof(Cuint32Cint32BitfieldsUnion) == sizeof(Cuint)
		@test :u in propertynames(Cuint32Cint32BitfieldsUnion)
		@test :i in propertynames(Cuint32Cint32BitfieldsUnion)
		
		@cunion Cuint16Cint16BitfieldsUnion {
			(u:16)::Cuint
			(i:16)::Cint
		} __packed__
		@test sizeof(Cuint16Cint16BitfieldsUnion) == 2
		@test :u in propertynames(Cuint16Cint16BitfieldsUnion)
		@test :i in propertynames(Cuint16Cint16BitfieldsUnion)
		
		@cunion Cint16Cint16BitfieldsUnion {
			(i1:16)::Cint
			(i2:16)::Cint
		} __packed__
		@test sizeof(Cuint16Cint16BitfieldsUnion) == 2
		
		@cunion Cint16CalignCint16BitfieldsUnion {
			(i1:16)::Cint
			@calign sizeof(Cint)
			(i2:16)::Cint
		} __packed__
		@test sizeof(Cint16CalignCint16BitfieldsUnion) == sizeof(Cint)
		
		@cunion Cint16CintBitfieldsUnion {
			(bf:16)::Cint
			i::Cint
		} __packed__
		@test sizeof(Cint16CintBitfieldsUnion) == sizeof(Cint)
		
		bfUnion = Cuint16Cint16BitfieldsUnion()
		@test bfUnion.u == 0
		@test bfUnion.i == 0
		bfUnion.i = Cint(-1)
		@test bfUnion.u == 0xffff
		@test bfUnion.i == -1
		bfUnion.u = Cuint(0x0001)
		@test bfUnion.u == 0x0001
		@test bfUnion.i == 1
		
		bfUnion = Cint16CalignCint16BitfieldsUnion()
		@test bfUnion.i1 == 0
		@test bfUnion.i2 == 0
		bfUnion.i1 = -1
		@test bfUnion.i1 == -1
		@test bfUnion.i2 == -1
		bfUnion.i2 = 0
		@test bfUnion.i1 == 0
		@test bfUnion.i2 == 0
		bfUnion.i2 = 32768
		@test bfUnion.i1 < 0
		@test bfUnion.i2 < 0
	end
	
	
	@testset "@carray" begin
		CcharArray = @carray Cchar[2]
		@test sizeof(CcharArray) == sizeof(Cchar)*2
		
		CstructArray = @carray (@cstruct {
			i::Cint
		} __packed__)[10]
		@test sizeof(CstructArray) == sizeof(Cint)*10
		
		@cstruct CStruct {
			i::Cint
		} __packed__
		CStructArray = @carray CStruct[2]
		@test sizeof(CStructArray) == sizeof(Cint)*2
		
		@cstruct Opaque
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
		
		pa = PtrArray()
		for ptr in pa
			@test ptr == C_NULL
		end
		
		ca = CStructArray()
		@test length(ca) == 2
		@test eltype(ca) === CStruct
		@test ca[2] isa CBinding.Caccessor{CStruct}
		
		CarrayArray = @carray Cint[4][2]
		@test sizeof(CarrayArray) == sizeof(Cint)*4*2
		@test eltype(CarrayArray) === @carray Cint[4]
		@test eltype(eltype(CarrayArray)) === Cint
		
		ca = CarrayArray()
		@test length(ca) == 2
		@test length(ca[1]) == 4
		for i in eachindex(ca), j in eachindex(ca[i])
			@test ca[i] isa CBinding.Caccessor{@carray Cint[4]}
			@test ca[i][j] == 0
		end
	end
	
	
	@testset "@ctypedef" begin
		@eval @ctypedef EmptyStructTypedef @cstruct {
		} __packed__
		@test sizeof(EmptyStructTypedef) == 0
		
		@eval @ctypedef CcharStructTypedef @cstruct {
			c::Cchar
		} __packed__
		@test sizeof(CcharStructTypedef) == sizeof(Cchar)
		@test :c in propertynames(CcharStructTypedef)
		
		@eval @ctypedef CintUnionTypedef @cunion {
			i::Cint
		} __packed__
		@test sizeof(CintUnionTypedef) == sizeof(Cint)
		@test :i in propertynames(CintUnionTypedef)
		
		@eval @ctypedef CuintArrayTypedef Cuint[32]
		@test sizeof(CuintArrayTypedef) == sizeof(Cuint)*32
		
		@eval @ctypedef CintTypedef Cint
		@test sizeof(CintTypedef) == sizeof(Cint)
	end
	
	
	@testset "Clibrary" begin
		lib1 = Clibrary()
		lib2 = Clibrary()
		@test lib1.handle != Ptr{Cvoid}(0)
		@test lib1 == lib2
		
		lib3 = Clibrary(Base.libm_name)
		lib4 = Clibrary(Base.libm_name)
		@test lib3.handle != Ptr{Cvoid}(0)
		@test lib3 == lib4
		
		@test lib1 != lib3
	end
	
	
	@testset "Cfunction" begin
		lib = Clibrary()
		
		val = Cglobalconst{Ptr{Cvoid}}(lib, :jl_nothing)
		@test val.handle != Ptr{Cvoid}(0)
		@test val[] == unsafe_load(cglobal(:jl_nothing, Ptr{Cvoid}))
	end
	
	
	@testset "Cfunction" begin
		lib = Clibrary()
		
		f1 = Cfunction{Clong, Tuple{Ptr{Clong}}}(lib, :time)
		@test typeof(f1) === Ptr{Cfunction{Clong, Tuple{Ptr{Clong}}}}
		@test typeof(f1(C_NULL)) === Clong
		@test f1(C_NULL) isa Clong
		@test_throws MethodError f1(0)
		
		before = f1(C_NULL)
		sleep(3)
		after = f1(C_NULL)
		@test before < after
		
		f2 = Cfunction{Clong, Tuple{}}(lib, :jl_gc_total_bytes)
		@test typeof(f2) === Ptr{Cfunction{Clong, Tuple{}}}
		@test typeof(f2()) === Clong
		@test f2() isa Clong
		@test_throws MethodError f2("no arguments, please!")
		
		f3 = Cfunction{Cint, Tuple{Ptr{Cchar}, Cstring, Vararg}}(lib, :sprintf)
		@test typeof(f3) === Ptr{Cfunction{Cint, Tuple{Ptr{Cchar}, Cstring, Vararg}}}
		str = zeros(Cchar, 100)
		@test typeof(f3(str, "")) === Cint
		@test f3(str, "%s %ld\n", "testing printf", 1234) == 20
		@test unsafe_string(pointer(str)) == "testing printf 1234\n"
		@test f3(str, "%s i%c %ld great test of CBinding.jl v%3.1lf%c\n", "This", 's', 1, 0.1, '!') == length("This is 1 great test of CBinding.jl v0.1!\n")
		@test unsafe_string(pointer(str)) == "This is 1 great test of CBinding.jl v0.1!\n"
		@test_throws MethodError f3(1234)
		@test_throws MethodError f3(1234, "still wrong")
		
		(Cadd, add) = Cfunction{Cint, Tuple{Cint, Cint}}() do val1, val2
			return val1+val2
		end
		@test typeof(Cadd) === Ptr{Cfunction{Cint, Tuple{Cint, Cint}}}
		@test typeof(add.f) <: Function
		@test typeof(Cadd(Cint(10), Cint(3))) === typeof(add.f(Cint(10), Cint(3)))
		@test Cadd(Cint(10), Cint(3)) == add.f(Cint(10), Cint(3))
		
		@cstruct time_t {
			val::Clong
		}
		@cstruct tm {
			sec::Cint
			min::Cint
			hour::Cint
			mday::Cint
			mon::Cint
			year::Cint
			wday::Cint
			yday::Cint
			isdst::Cint
		}
		time = Cfunction{time_t, Tuple{Ptr{time_t}}}(lib, :time)
		localtime = Cfunction{Ptr{tm}, Tuple{Ptr{time_t}}}(lib, :localtime)
		
		t = Ref(time_t())
		@test t[].val == 0
		time(t)
		@test t[].val != 0
		
		p = localtime(t)
		@test p isa Ptr
		@test p != C_NULL
		
		x = unsafe_load(p)
		@test 2000 < 1900+x.year < 2100  # if this package is still around in 2100...
		
		mktime = Cfunction{time_t, Tuple{Ptr{tm}}}(lib, :mktime)
		u = mktime(p)
		@test u.val == t[].val
	end
end

