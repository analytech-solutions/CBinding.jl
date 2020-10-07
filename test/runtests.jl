using Test: @testset, @test, @test_throws, @test_broken
using Random
using CBinding


function checkJL(expr, val)
	def = expr
	def = replace(def, r"(\w+)::(\w+):(\d+)" => s"(\1:\3)::\2")
	
	X = @eval module $(gensym())
		using CBinding
		@ctypedef X $(Meta.parse(def))
	end
	
	x = Base.invokelatest(X.X, zero)
	result = []
	push!(result, "$(string(sizeof(x))): $(bytes2hex(UInt8[getfield(x, :mem)...,]))")
	types = Base.invokelatest(CBinding.propertytypes, x)
	for (ind, prop) in enumerate(Base.invokelatest(propertynames, x))
		x = Base.invokelatest(X.X, zero)
		v1 = sizeof(types[ind]) < sizeof(val) ? Core.Intrinsics.trunc_int(types[ind], val) : reinterpret(types[ind], val)
		Base.invokelatest(setproperty!, x, prop, v1)
		v2 = Base.invokelatest(getproperty, x, prop)
		Base.invokelatest(setproperty!, x, prop, v2)
		v3 = Base.invokelatest(getproperty, x, prop)
		@test v2 === v3
		push!(result, "$(String(prop)): $(bytes2hex(UInt8[getfield(x, :mem)...,]))")
	end
	return result
end


FILE_COUNT = 0
function checkC(expr, val)
	global FILE_COUNT
	FILE_COUNT += 1
	file = string(FILE_COUNT, pad = 4)
	expectedFile = joinpath(ifelse(sizeof(Clong) == sizeof(Cint), "expected-windows", "expected"), "$(file).txt")
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
		def = replace(def, r"} (\w+) (__attribute__[^;]+)" => s"} \2 \1")
		
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
	
	
	include("cstruct.jl")
	include("cunion.jl")
	include("carray.jl")
	include("cenum.jl")
	include("ctypedef.jl")
	include("cconst.jl")
	include("clibrary.jl")
	include("cglobal.jl")
	include("cfunction.jl")
	include("cextern.jl")
	
	
	@testset "Caccessor" begin
		@cstruct AccessorInner {
			i::Cint
		}
		
		@cstruct AccessorOuter {
			i::Cint
			inner::AccessorInner
			ptr::Ptr{AccessorInner}
		}
		
		x = AccessorOuter(zero)
		@test x.i == 0
		@test x.inner.i == 0
		@test x.ptr == C_NULL
		
		x.ptr = reinterpret(Ptr{AccessorInner}, pointer_from_objref(x))
		@test x.ptr != C_NULL
		@test x.ptr.i == 0
		
		x.i = 1234
		@test x.i == 1234
		@test x.inner.i == 0
		@test x.ptr.i == 1234
	end
end

