# CBinding.jl

[![Linux](https://api.travis-ci.com/analytech-solutions/CBinding.jl.svg?branch=master)](https://travis-ci.com/analytech-solutions/CBinding.jl) [![Windows](https://ci.appveyor.com/api/projects/status/4ecxdyj51lfnk4df/branch/master?svg=true)](https://ci.appveyor.com/project/krrutkow/cbinding-jl/branch/master)

This package provides improvements for specifying and using C bindings in Julia.
CBinding.jl has the goal of making it easier to correctly connect Julia to your C API and libraries.
We have highlighted in our blog post many of the issues encountered when [using C libraries from Julia](https://analytech-solutions.com/analytech-solutions/blog/cbinding.html), and those issues have fueled us to develop this package.

# Usage

CBinding.jl provides some missing functionality and more precise specification capabilities than those provided by the builtin Julia facilities for interfacing C.
All of the functionality and correctness of the CBinding.jl package has been compared to the behavior of GCC on x86_64 and AArch64 Linux distributions.
Since many aspects of C are platform or compiler defined, the behavior of API's built for other platforms or compilers may not be matched by this package.
Any help to test and develop against other setups is very much welcome!

## C Aggregate and Array Types

CBinding.jl provides a statically-sized C array similar to the static array constructs found in some other Julia packages.
An array definition is obtained by using the`@carray ElementType[SIZE]` syntax, which is provided to ease in the transcribing of C to Julia.
When used within the context of a `@cunion`, `@cstruct`, or `@ctypedef` macro, `ElementType[SIZE]` can be used directly to define arrays.

The `union` and `struct` aggregate types in C are described in very similar ways using CBinding.jl.
Both require the bit range of each aggregate field to be specified in order to support the different field packing approaches used in C.
Aggregate fields can be nested and anonymous aggregate fields can be used as well - two significant improvements over the usual Julian approach.

```jl
julia> using CBinding

julia> @cstruct MyFirstCStruct {    # struct MyFirstCStruct {
           i::Cint                  #     int i;
       }                            # };

julia> @ctypedef MySecondType @cstruct MySecondCStruct {    # typedef struct MySecondCStruct {
           i::Cint                                          #     int i;
           j::Cint                                          #     int j;
           @cunion {                                        #     union {
               w::Cuchar[sizeof(Cint)÷sizeof(Cuchar)]       #         unsigned char w[sizeof(int)/sizeof(unsigned char)];
               x::Cint                                      #         int x;
               (y::_[4])::@cstruct {                        #         struct {
                   c::Cuchar                                #             unsigned char c;
               }                                            #         } y[4];
               z::MyFirstCStruct[1]                         #         struct MyFirstCStruct z[1];
           }                                                #     };
           m::MyFirstCStruct                                #     struct MyFirstCStruct m;
       }                                                    # } MySecondType;
```

As you can see, type definition syntax closely mimics that of C, which you should find helpful when transcribing more complicated types or API's with numerous types.
There are a few syntax differences to note though:

- a `@ctypedef` is specified with the type name before the definition rather than after (as is done in C)  
- likewise, an aggregate field is specified in the Julia `fieldName::FieldType` syntax rather than the C style of `FieldType fieldName`
- in C a single line can specified multiple types (like `SomeType a, *b, c[4]`), but with our syntax these are expressed as a tuple (`(a, b::Ptr{_}, c::_[4])::SomeType`) with the use of an underscore `_` to mean "plug in type here"
- Julia does not support forward declarations, so CBinding.jl uses some very dubious methods to simulate the capability which may cause grief and confusion for users when types don't appear as they should

The generic constructor provided by CBinding.jl allows you to create an aggregate with uninitialized values, zero-initialized values, or from existing an existing aggregate object.
It is also possible to use keyword arguments to specify values for particular fields within the aggregate as well.
Pass the `zero` function to the constructor to create a zero-initialized object (an alternative is to pass the aggregate type to the `zero` function).
The "undef" constructor is also defined and does nothing to initialize the memory region of the allocated object, so it is optimal to use in situations where an object will be fully initialized with particular values provided as keyword arguments.

```jl
julia> garbage = MySecondCStruct(undef)    # struct MySecondCStruct garbage;
MySecondCStruct(i=-340722048, j=32586, w=UInt8[0x00, 0x00, 0x00, 0x00], x=0, y=<anonymous-struct>[(c=0x00), (c=0x00), (c=0x00), (c=0x00)], z=MyFirstCStruct[(i=0)], m=MyFirstCStruct(i=0))

julia> zeroed = MySecondCStruct(zero)    # struct MySecondCStruct zeroed; memset(&zeroed, 0, sizeof(zeroed));
MySecondCStruct(i=0, j=0, w=UInt8[0x00, 0x00, 0x00, 0x00], x=0, y=<anonymous-struct>[(c=0x00), (c=0x00), (c=0x00), (c=0x00)], z=MyFirstCStruct[(i=0)], m=MyFirstCStruct(i=0))
```

Accessing the data fields within a C aggregate type works the way you would expect with one noteworthy detail.
Notice that when modifying fields within a union (e.g. `zeroed.y[3].c = 0xff`) the change is also observed in the other fields in the union (`zeroed.w`, `zeroed.x`, and `zeroed.y`).

```jl
julia> zeroed.i = 100
100

julia> zeroed
MySecondCStruct(i=100, j=0, w=UInt8[0x00, 0x00, 0x00, 0x00], x=0, y=<anonymous-struct>[(c=0x00), (c=0x00), (c=0x00), (c=0x00)], z=MyFirstCStruct[(i=0)], m=MyFirstCStruct(i=0))

julia> zeroed.y[3].c = 0xff
0xff

julia> zeroed
MySecondCStruct(i=100, j=0, w=UInt8[0x00, 0x00, 0xff, 0x00], x=16711680, y=<anonymous-struct>[(c=0x00), (c=0x00), (c=0xff), (c=0x00)], z=MyFirstCStruct[(i=16711680)], m=MyFirstCStruct(i=0))
```

When accessing a nested aggregate (or array) type, a `Caccessor` object is used to maintain a reference to the enclosing object.
To get the aggregate itself that a `Caccessor` is referring to you must use `[]` similar to Julia `Ref` usage.
This will lead to some surprising results/behavior if you forget this detail.
The implemented `Base.show` function will also cause the `Caccessor` to appear as if you are working with the aggregate, so trust `typeof`.

```jl
julia> typeof(zeroed.m)
Caccessor{MyFirstCStruct,MySecondCStruct,Val{12}}

julia> typeof(zeroed.m[])
MyFirstCStruct

julia> sizeof(zeroed.m)
8

julia> sizeof(zeroed.m[])
4

julia> zeroed.m
MyFirstCStruct(i=0)

julia> zeroed.m = MyFirstCStruct(zero, i = 42)
MyFirstCStruct(i=42)

julia> zeroed.m
MyFirstCStruct(i=42)

julia> zeroed.m[] = MyFirstCStruct(zero, i = 0)
MyFirstCStruct(i=0)

julia> zeroed.m
MyFirstCStruct(i=0)
```

## C Field Alignment

By default, the fields in aggregates use native alignment to match the default alignment in C, but it is possible to denote packed aggregates using `__packed__`, similar to using a `__attribute__((packed))` attribute in C.
CBinding.jl also features the `@calign` macro to describe additional alignment requirements when defining aggregate types.

```jl
julia> @cstruct MyUnalignedCStruct {    # struct MyUnalignedCStruct {
           c::Cchar                     #     char c;
           i::Cint                      #     int i;
           @cunion {                    #     union {
               f::Cfloat                #         float f;
               d::Cdouble               #         double d;
           }                            #     };
       } __packed__                     # } __attribute__((packed));
MyUnalignedCStruct

julia> sizeof(MyUnalignedCStruct)
13

julia> @cstruct MyAlignedCStruct {    # struct MyAlignedCStruct {
           c::Cchar                   #     char c;
           i::Cint                    #     int i;
           @cunion {                  #     union {
               f::Cfloat              #         float f;
               d::Cdouble             #         double d;
           }                          #     };
       }                              # };

julia> sizeof(MyAlignedCStruct)
16

julia> @cstruct MyStrictlyAlignedCStruct {                           # struct MyStrictlyAlignedCStruct {
           @calign 1   # align next field at 1 byte                  #     alignas(1) char c;
           c::Cchar                                                  #     alignas(int) int i;
           @calign sizeof(Cint)   # align next field at 4 bytes      #     alignas(double) union {
           i::Cint                                                   #         alignas(float) float f;
           @calign sizeof(Cdouble)   # align largest nested field    #         alignas(double) double d;
           @cunion {                                                 #     };
               @calign sizeof(Cfloat)                                # };
               f::Cfloat
               @calign sizeof(Cdouble)
               d::Cdouble
           }
       }
MyStrictlyAlignedCStruct

julia> sizeof(MyStrictlyAlignedCStruct)
16
```

## C Const-ness

One feature of C that doesn't necessarily port well into Julia is the `const` modifier on types.
The aggregate types provided by CBinding.jl are mutable by default, but the `Cconst` type can be used to create an immutable `struct` form of the type.
This mechanism can be used in a way that is _similar_ to the `const` modifier in C.

```jl
julia> @cstruct ConstStruct {    # struct ConstStruct {
           i::Cint               #     int i;
           j::Cconst{Cint}       #     int const j;
       }                         # };
ConstStruct

julia> s = ConstStruct(zero, i = 1, j = 2)
ConstStruct(i=1, j=2)

julia> s.i = 3
3

julia> s
ConstStruct(i=3, j=2)

julia> s.j = 4
ERROR: Unable to change the value of a Cconst field
Stacktrace:
 [1] error(::String) at ./error.jl:33
  ⁝

julia> c = Cconst(s)
Cconst(ConstStruct(i=3, j=2))

julia> c.i = 5
ERROR: Unable to change the value of a Cconst field
Stacktrace:
 [1] error(::String) at ./error.jl:33
  ⁝

julia> s.i = 5
5

julia> s
ConstStruct(i=5, j=2)

julia> c  # notice that `i` is not changed, `c` is a constant _copy_ of `s`
Cconst(ConstStruct(i=3, j=2))
```

Run time and memory usage can be improved by using `Cconst` wrapped types as well.
If you do not wish to modify any fields in an aggregate, then it is recommended that you use the `Cconst` form of the object.

## C Enumerations

We also provide an implementation of C-style enumeration with a syntax very similar to that of C.
Enumerations may be defined by using the `@cenum` macro in typedef or aggregate type macros and may be specified as either anonymous or named types.
The values of an enumeration must evaluate to integers, and can reference values defined earlier.
Usage of enumerations and values is generally promoted to integer arithmetic.

```jl
julia> @cenum MyNamedEnum {    # enum MyNamedEnum {
           VALUE_1,            #     VALUE_1,
           VALUE_2,            #     VALUE_2,
           VALUE_3,            #     VALUE_3
       }                       # };
MyNamedEnum

julia> e = MyNamedEnum(VALUE_3)
MyNamedEnum(<VALUE_3>(0x00000002))

julia> e = MyNamedEnum(VALUE_1)
MyNamedEnum(<VALUE_1>(0x00000000))

julia> e | VALUE_3
2

julia> @cstruct EnumStruct {    # struct EnumStruct {
           e::@cenum {          #     enum {
               X = 1<<0,        #         X = 1<<0,
               Y = 1<<1,        #         Y = 1<<1,
               Z = 1<<2,        #         Z = 1<<2
           }                    #     } e;
       }                        # };
EnumStruct

julia> e = EnumStruct(zero)
EnumStruct(e=<anonymous-enum>(0x00000000))

julia> e.e = X|Y|Z
7

julia> e
EnumStruct(e=<anonymous-enum>(0x00000007))
```

CBinding.jl also allows you to apply an alignment strategy, such as `__packed__`, to an enumeration definition.
An alignment strategy can be applied to both standalone enumeration types and enumerations nested within unions or structures.

```jl
julia> @cenum MyPackedNamedEnum {    # enum MyPackedNamedEnum {
           PACKED_VALUE_1,           #     PACKED_VALUE_1,
           PACKED_VALUE_2,           #     PACKED_VALUE_2,
           PACKED_VALUE_3,           #     PACKED_VALUE_3
       } __packed__                  # } __attribute__((packed));
MyPackedNamedEnum

julia> sizeof(MyNamedEnum)
4

julia> sizeof(MyPackedNamedEnum)
1
```

## C Bit Fields

Specifying C bit fields is another feature provided by CBinding.jl.
Bit fields can be defined with `(fieldName:FIELD_BITS)::FieldType` where `FIELD_BITS` is an Integer number of bits and `FieldType` is either `Cint` or `Cuint`.

```jl
julia> @cstruct BitfieldStruct {    # struct BitfieldStruct {
           (i:2)::Cint              #     int i:2;
           (j:2)::Cuint             #     unsigned int j:2;
       }                            # };
BitfieldStruct

julia> bf = BitfieldStruct(zero)
BitfieldStruct(i=0, j=0x00000000)

julia> sizeof(bf)
4

julia> for i in 1:5
           bf.i = i ; @show bf
       end
bf = BitfieldStruct(i=1, j=0x00000000)
bf = BitfieldStruct(i=-2, j=0x00000000)
bf = BitfieldStruct(i=-1, j=0x00000000)
bf = BitfieldStruct(i=0, j=0x00000000)
bf = BitfieldStruct(i=1, j=0x00000000)

julia> for i in 1:5
           bf.j = i ; @show bf
       end
bf = BitfieldStruct(i=1, j=0x00000001)
bf = BitfieldStruct(i=1, j=0x00000002)
bf = BitfieldStruct(i=1, j=0x00000003)
bf = BitfieldStruct(i=1, j=0x00000000)
bf = BitfieldStruct(i=1, j=0x00000001)
```

## C Libraries

Interfacing C libraries is done through a `Clibrary` object.
Once the library object is available, it can be used for obtaining global variables or functions directly.
This approach allows for multiple libraries to be loaded without causing symbol conflicts.

```jl
julia> lib = Clibrary()  # dlopens the Julia process    # void *lib = dlopen(NULL, RTLD_LAZY|RTLD_DEEPBIND|RTLD_LOCAL); 
Clibrary(Ptr{Nothing} @0x000061eefd6a1000)

julia> lib2 = Clibrary("/path/to/library.so")  # dlopens the library    # void *lib2 = dlopen("/path/to/library.so", RTLD_LAZY|RTLD_DEEPBIND|RTLD_LOCAL);
Clibrary(Ptr{Nothing} @0x00006c1ce98c5000)
```

## C Global Variables

A simple wrapper type, `Cglobal`, is provided to obtain global variables from a library.

```jl
julia> val = Cglobal{Ptr{Cvoid}}(lib, :jl_nothing)    # const void **val = dlsym(lib, "jl_nothing");
Cglobal{Ptr{Nothing}}(Ptr{Ptr{Nothing}} @0x00007fc384893bb8)

julia> val[]   # dereference val
Ptr{Nothing} @0x00007fc3735ce008
```

The new `@cextern` macro is the recommended method of binding global variables.
It is a more concise Julian representation that closely mirrors the C syntax.
This macro also includes the ability to use anonymous types in the definition of global variables.

```jl
julia> @cextern jl_base_module::Ptr{@cstruct jl_module_t}    # extern struct _jl_module_t *jl_base_module;
Cglobal{Ptr{jl_module_t}}(Ptr{Ptr{jl_module_t}} @0x00007f84ce375230)
```

## C Functions

This package adds the ability to specify function pointers in a type-safe way to Julia, similar to how you would in C.
You may specify a `Cfunction` pointer directly, or use the constructor to load a symbol from a bound library.
The parametric types to `Cfunction` are used to specify the return type and the tuple of argument types for the function referenced.
The additional type-safety will help you avoid many mishaps when calling C functions.

```jl
julia> CFuncType = Cfunction{Clong, Tuple{Ptr{Clong}}}    # type of the function `long func(long *);`
Cfunction{Int64,Tuple{Ptr{Int64}},ConvT} where ConvT<:Cconvention

julia> CFuncPtrType = Ptr{CFuncType}    # long (*func)(long *);
Ptr{Cfunction{Int64,Tuple{Ptr{Int64}},ConvT} where ConvT<:Cconvention}

julia> func = CFuncType(lib, :time)    # long (*func)(long *) = dlsym(lib, "time");
Ptr{Cfunction{Int64,Tuple{Ptr{Int64}},ConvT} where ConvT<:Cconvention} @0x00007fff95de08c0

julia> @cstruct tm {
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
tm

julia> localtime = Cfunction{Ptr{tm}, Tuple{Ptr{Clong}}}(lib, :localtime)    # struct tm *(*localtime)(long *) = dlsym(lib, "localtime");
Ptr{Cfunction{Ptr{tm},Tuple{Ptr{Int64}},ConvT} where ConvT<:Cconvention} @0x0000652bdb253fd0
```

CBinding.jl also makes a function pointer (`Ptr{<:Cfunction}`) callable.
So, just as you would in C, you can simply call the function pointer to invoke it.

```jl
julia> func(C_NULL)
1560708358

julia> t = Ref(Clong(0))
Base.RefValue{Int64}(0)

julia> func(t)
1560708359

julia> t[]   # dereference t
1560708359

julia> p = localtime(t)
Ptr{tm} @0x00007f4afa08b300

julia> unsafe_load(p)   # dereference p
tm(sec=59, min=5, hour=14, mday=16, mon=5, year=119, wday=0, yday=166, isdst=1)
```

It is also possible to create type-safe function pointers to Julia functions for use in C code.
A closure is automatically created for the wrapped function and returned along with the C function pointer, so a reference to the closure (`Base.CFunction`) must be kept to keep the function pointer valid.
One important thing to note is that the Julia function used is not (yet) guarded, so the argument and return types of the Julia function must match that of the Cfunction signature.
The new `@ccallback` macro is now the recommended method of creating function pointers from Julia functions.

```jl
julia> (Cadd, add) = Cfunction{Cint, Tuple{Cint, Cint}}() do x::Cint, y::Cint
           return Cint(x + y)
       end
(Ptr{Cfunction{Int32,Tuple{Int32,Int32},Cconvention{:cdecl}}} @0x00007fc34e4dfa40, Base.CFunction(Ptr{Nothing} @0x00007fc34e4dfa40, getfield(Main, Symbol("##5#6"))(), Ptr{Nothing} @0x0000000000000000, Ptr{Nothing} @0x0000000000000000))

julia> Cadd(2, 3)  # ccall the C function pointer, arguments are Base.cconvert-ed automatically
5

julia> add.f(Cint(2), Cint(3))  # directly call the Julia function
5

julia> Cadd = @ccallback function add(x::Cint, y::Cint)::Cint
           return x + y
       end
```

## C Variadic Functions

Declaring a variadic function pointer can be done using a `Vararg` argument type (which must be the last argument).
The variadic function calling capability provided with CBinding.jl is not limited in the ways that native Julia ccall usage is.
This enables Julia the ability to perform real-world variadic function usage as demonstrated with an example of binding to `printf` and then calling it below.

```jl
julia> func = Cfunction{Cint, Tuple{Cstring, Vararg}}(lib, :printf)    # int (*func)(char *, ...) = dlsym(lib, "printf");
Ptr{Cfunction{Int32,Tuple{Cstring,Vararg{Any,N} where N},ConvT} where ConvT<:Cconvention} @0x000061eefc388930

julia> func("%s i%c %ld great demo of CBinding.jl v%3.1lf%c\n", "this", 's', 1, 0.1, '!')
this is 1 great demo of CBinding.jl v0.1!
42
```

## Binding Julia with a C library

The new `@cbindings` and `@cextern` macros provide the recommended method of binding C functions with Julia.
Its intended use is for creating optimized function bindings rather than loading function pointers.
It provides a more concise Julian representation that closely mirrors the C syntax.
The `@cextern` macro also includes the ability to use anonymous types in the definition of function.

```jl
julia> @cextern time(ptr::Ptr{Clong})::Clong
time (generic function with 1 method)

julia> @cextern localtime(ptr::Ptr{Clong})::Ptr{tm}
localtime (generic function with 1 method)

julia> @cextern printf(format::Cstring, vals...)::Cint
printf (generic function with 1 method)

julia> time(t)
1560708359

julia> unsafe_load(localtime(t))
tm(sec=59, min=5, hour=14, mday=16, mon=5, year=119, wday=0, yday=166, isdst=1)

julia> printf("%s i%c %ld great demo of CBinding.jl v%3.1lf%c\n", "this", 's', 1, 0.1, '!')
this is 1 great demo of CBinding.jl v0.1!
42
```

The `@cbindings` macro can be used to cleanly group and target bindings to a particular library.
Any `@ctypedef`, `@cstruct`, `@cextern`, etc. macro usage can be placed within a `@cbindings` macro as well.

```jl
module CJulia
  using CBinding
  
  @cbindings "./path/to/libjulia.so" begin
    @ctypedef jl_nullable_float64_t @cstruct {
      hasvalue::UInt8
      value::Cdouble
    }
    
    @ctypedef jl_value_t @cstruct _jl_value_t
    
    @cextern jl_gc_enable(on::Cint)::Cint
    @cextern jl_gc_is_enabled()::Cint
    
    @cextern jl_gc_alloc_0w()::Ptr{jl_value_t}
    @cextern jl_gc_alloc_1w()::Ptr{jl_value_t}
    @cextern jl_gc_alloc_2w()::Ptr{jl_value_t}
    @cextern jl_gc_alloc_3w()::Ptr{jl_value_t}
    @cextern jl_gc_allocobj(sz::Csize_t)::Ptr{jl_value_t}
    
    @cextern jl_base_module::Ptr{@cstruct jl_module_t}
  end
end
```

