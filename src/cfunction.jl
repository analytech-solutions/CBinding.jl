todo"add ability to show a Cfunction's signature, so perhaps storing arg names is needed"

struct Cfunction{RetT, ArgsT<:Tuple}
	let constructor = false end
end

Cfunction{RetT, ArgsT}(ptr::Ptr{Cvoid}) where {RetT, ArgsT<:Tuple} = reinterpret(Ptr{Cfunction{RetT, ArgsT}}, ptr)
Cfunction{RetT, ArgsT}(lib::Clibrary, sym::Symbol) where {RetT, ArgsT<:Tuple} = Cfunction{RetT, ArgsT}(Libdl.dlsym(lib.handle, sym))

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

function bind(f::Ref{Ptr{Cfunction{RetT, ArgsT}}}, sym, libs::Clibrary...) where {RetT, ArgsT<:Tuple}
		for (ind, lib) in enumerate(libs)
			handle = Libdl.dlsym(lib.handle, sym, throw_error = ind == length(libs))
			if !isnothing(handle)
				f[] = reinterpret(Ptr{Cfunction{RetT, ArgsT}}, handle)
				break
			end
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


todo"some compilers use different calling convention for variadic functions"
(f::Ptr{Cfunction{RetT, ArgsT}})(args...; kwargs...) where {RetT, ArgsT<:Tuple} = invoke(f, args...; kwargs...)
@generated function invoke(f::Ptr{Cfunction{RetT, ArgsT}}, args...; convention::Type{Convention} = @static Sys.iswindows() ? STDCALL : CDECL) where {RetT, ArgsT<:Tuple, Convention<:Val}
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
