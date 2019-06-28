todo"add ability to show a Cfunction's signature, so perhaps storing arg names is needed"

struct Cfunction{RetT, ArgsT<:Tuple}
	let constructor = false end
end

Cfunction{RetT, ArgsT}(ptr::Ptr{Cvoid}) where {RetT, ArgsT<:Tuple} = reinterpret(Ptr{Cfunction{RetT, ArgsT}}, ptr)
Cfunction{RetT, ArgsT}(lib::Clibrary, sym::Symbol) where {RetT, ArgsT<:Tuple} = Cfunction{RetT, ArgsT}(Libdl.dlsym(lib.handle, sym))
function Cfunction{RetT, ArgsT}(libs::Vector{Clibrary}, sym::Symbol) where {RetT, ArgsT<:Tuple}
	for lib in libs
		handle = Libdl.dlsym(lib.handle, sym, throw_error = false)
		handle === nothing || return Cfunction{RetT, ArgsT}(handle)
	end
	return Cfunction{RetT, ArgsT}(Libdl.dlsym(last(libs).handle, sym))
end

# NOTE:  this returns a tuple (since the user must retain a reference to func for the function pointer to remain usable)
Cfunction{RetT, ArgsT}(func::Base.CFunction) where {RetT, ArgsT<:Tuple} = (Cfunction{RetT, ArgsT}(Base.unsafe_convert(Ptr{Cvoid}, func)), func)

@generated function Cfunction{RetT, ArgsT}(func::Function) where {RetT, ArgsT<:Tuple}
	_tuplize(::Type{Tuple{}}) where {T<:Tuple} = ()
	_tuplize(::Type{T}) where {T<:Tuple} = (Base.tuple_type_head(T), _tuplize(Base.tuple_type_tail(T))...,)
	
	types = _tuplize(ArgsT)
	return quote
		$(Expr(:meta, :inline))
		return Cfunction{RetT, ArgsT}(@cfunction($(Expr(:$, :func)), RetT, ($(types...),)))
	end
end


# calling conventions
const STDCALL  = Val{:stdcall}
const CDECL    = Val{:cdecl}
const FASTCALL = Val{:fastcall}
const THISCALL = Val{:thiscall}


# https://www.gnu.org/software/libc/manual/html_node/How-Variadic.html
# it appears that chars and ints are promoted to 32-bit ints and floats are promoted to doubles when used as varargs
cconvert_vararg(::Type{CDECL}, ::Type{T}) where {T} = T
cconvert_vararg(::Type{CDECL}, ::Type{T}) where {T<:Signed} = sizeof(T) < sizeof(Cint) ? Cint : T
cconvert_vararg(::Type{CDECL}, ::Type{T}) where {T<:Unsigned} = sizeof(T) < sizeof(Cuint) ? Cuint : T
cconvert_vararg(::Type{CDECL}, ::Type{T}) where {T<:Cchar} = sizeof(T) < sizeof(Cint) ? Cint : T
cconvert_vararg(::Type{CDECL}, ::Type{T}) where {T<:AbstractFloat} = sizeof(T) < sizeof(Cdouble) ? Cdouble : T


# these define a type to add to the type tuple when ccalling variadic functions
cconvert_default(::Type{T}) where {T} = error("Sorry, `$(T)` is not yet usable for variadic functions, provide `CBinding.cconvert_default(::Type{$(T)}) = CConvertType` to define how to pass it to a variadic function call")
cconvert_default(::Type{T}) where {T<:AbstractString} = Cstring
cconvert_default(::Type{T}) where {T<:Char} = Cchar
cconvert_default(::Type{T}) where {T<:Union{Integer, AbstractFloat, Ref}} = T   # this covers Ptr too, Ptr <: Ref
cconvert_default(::Type{T}) where {E, T<:AbstractArray{E}} = Ptr{E}


todo"default for convention might be system dependent, e.g. windows would be stdcall"
todo"some compilers use different calling convention for variadic functions"
(f::Ptr{Cfunction{RetT, ArgsT}})(args...; kwargs...) where {RetT, ArgsT<:Tuple} = invoke(f, args...; kwargs...)
@generated function invoke(f::Ptr{Cfunction{RetT, ArgsT}}, args...; convention::Type{Convention} = CDECL) where {RetT, ArgsT<:Tuple, Convention<:Val}
	error = nothing
	_tuplize(::Type{Tuple{}}) = ()
	_tuplize(::Type{Tuple{}}, argT, argsT...) = (error = :(throw(MethodError(f, args))) ; ())
	_tuplize(::Type{Tuple{Vararg}}) = (:(Ptr{Cvoid}...),)  # HACK: extra `Ptr{Cvoid}...` is being added to trigger vararg ccall behavior rather than regular behavior (if there is a difference in the backend)
	_tuplize(::Type{Tuple{Vararg}}, argT, argsT...) = (cconvert_vararg(Convention, cconvert_default(argT)), _tuplize(Tuple{Vararg}, argsT...)...,)
	_tuplize(::Type{T}) where {T<:Tuple} = (error = :(throw(MethodError(f, args))) ; ())
	_tuplize(::Type{T}, argT, argsT...) where {T<:Tuple} = (Base.tuple_type_head(T), _tuplize(Base.tuple_type_tail(T), argsT...)...,)
	
	_convention(::Type{Val{S}}) where {S} = S
	
	types = _tuplize(ArgsT, args...)
	return !isnothing(error) ? error : quote
		$(Expr(:meta, :inline))
		ccall(reinterpret(Ptr{Cvoid}, f), $(_convention(Convention)), RetT, ($(types...),), $(map(i -> :(args[$(i)]), eachindex(args))...),)
	end
end


# alignment strategies
const ALIGN_NATIVE = Val{:native}
const ALIGN_PACKED = Val{:packed}

alignof(::Type{ALIGN_PACKED}, ::Type{<:Any}) = 1

alignof(::Type{ALIGN_PACKED}, ::Type{CA}) where {_CA<:Carray, CA<:Union{_CA, Caccessor{_CA}}} = 1
alignof(::Type{ALIGN_PACKED}, ::Type{CA}) where {_CA<:Caggregate, CA<:Union{_CA, Caccessor{_CA}}} = 1

alignof(::Type{ALIGN_NATIVE}, ::Type{CA}) where {_CA<:Carray, CA<:Union{_CA, Caccessor{_CA}}} = alignof(ALIGN_NATIVE, eltype(_CA))
alignof(::Type{ALIGN_NATIVE}, ::Type{CA}) where {_CA<:Caggregate, CA<:Union{_CA, Caccessor{_CA}}} = _computelayout(_CA, alignment = true)

const (_i8a, _i16a, _i32a, _i64a, _f32a, _f64a) = let
	(i8a, i16a, i32a, i64a, f32a, f64a) = refs = ((Ref{UInt}() for i in 1:6)...,)
	ccall("jl_native_alignment",
		Nothing,
		(Ptr{UInt}, Ptr{UInt}, Ptr{UInt}, Ptr{UInt}, Ptr{UInt}, Ptr{UInt}),
		i8a, i16a, i32a, i64a, f32a, f64a
	)
	(Int(r[]) for r in refs)
end
alignof(::Type{ALIGN_NATIVE}, ::Type{UInt8})   = _i8a
alignof(::Type{ALIGN_NATIVE}, ::Type{UInt16})  = _i16a
alignof(::Type{ALIGN_NATIVE}, ::Type{UInt32})  = _i32a
alignof(::Type{ALIGN_NATIVE}, ::Type{UInt64})  = _i64a
alignof(::Type{ALIGN_NATIVE}, ::Type{Float32}) = _f32a
alignof(::Type{ALIGN_NATIVE}, ::Type{Float64}) = _f64a
alignof(::Type{ALIGN_NATIVE}, ::Type{S}) where {S<:Signed} = alignof(ALIGN_NATIVE, unsigned(S))

function checked_alignof(x, y)
	a = alignof(x, y)
	a == 0 || a == nextpow(2, a) || error("Alignment must be a power of 2")
	return a
end

padding(::Type{ALIGN_PACKED}, offset::Int, align::Int) = (align%8) == 0 ? padding(ALIGN_NATIVE, offset, align) : 0
padding(::Type{ALIGN_PACKED}, offset::Int, typ::DataType, bits::Int = 0) = bits == 0 ? padding(ALIGN_PACKED, offset, checked_alignof(ALIGN_PACKED, typ)*8) : 0

padding(::Type{ALIGN_NATIVE}, offset::Int, align::Int) = -offset & (align - 1)
function padding(::Type{ALIGN_NATIVE}, offset::Int, typ::DataType, bits::Int = 0)
	pad = padding(ALIGN_NATIVE, offset, checked_alignof(ALIGN_NATIVE, typ)*8)
	return 0 < bits <= pad ? 0 : pad
end

_computelayout(::Type{CA}; kwargs...) where {_CA<:Caggregate, CA<:Union{_CA, Caccessor{_CA}}} = _computelayout(_strategy(CA), CA, _fields(CA); kwargs...)
function _computelayout(strategy::DataType, ::Type{CA}, fields::Tuple; total::Bool = false, alignment::Bool = false) where {_CA<:Caggregate, CA<:Union{_CA, Caccessor{_CA}}}
	op = CA <: Cstruct ? (+) : (max)
	
	align = 1  # in bytes
	size = 0  # in bits
	result = ()  # ((symbol, (type, bits), offset), ...)
	for (sym, typ) in fields
		start = CA <: Cstruct ? size : 0
		if sym === :_ && typ <: Caggregate
			offset = op(start, padding(strategy, start, typ))
			result = (result..., map(((s, t, o),) -> (s, t, offset+o), _computelayout(typ))...)
			align = max(align, checked_alignof(strategy, typ))
			size = op(size, padding(strategy, start, typ) + sizeof(typ)*8)
		elseif isnothing(sym)
			align = max(align, typ)
			size = op(size, padding(strategy, start, typ*8))
		else
			if typ isa Tuple
				(typ, bits) = typ
			else
				bits = 0
			end
			
			offset = op(start, padding(strategy, start, typ, bits))
			if sym !== :_
				result = (result..., (sym, (bits == 0 ? typ : (typ, bits)), offset))
			end
			align = max(align, checked_alignof(strategy, typ))
			size = op(size, padding(strategy, start, typ, bits) + (bits == 0 ? sizeof(typ)*8 : bits))
		end
	end
	
	if alignment
		return align
	end
	
	if total
		size += padding(strategy, size, align*8)
		size += -size & (8-1)  # ensure size is divisible by 8
		return size
	end
	
	return result
end
