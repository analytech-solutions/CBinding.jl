todo"add ability to show a Cfunction's signature, so perhaps storing arg names is needed"


struct Cfunction{RetT, ArgsT<:Tuple, ConvT<:Cconvention}
	let constructor = false end
end

Base.Ptr{FuncT}(args...) where {FuncT<:Cfunction} = FuncT(args...)

Cfunction{RetT, ArgsT, ConvT}(ptr::Ptr{Cvoid}) where {RetT, ArgsT<:Tuple, ConvT<:Cconvention} = reinterpret(Ptr{Cfunction{RetT, ArgsT, ConvT}}, ptr)
Cfunction{RetT, ArgsT}(ptr::Ptr{Cvoid}) where {RetT, ArgsT<:Tuple} = reinterpret(Ptr{Cfunction{RetT, ArgsT}}, ptr)

Cfunction{RetT, ArgsT, ConvT}(lib::Clibrary, sym::Symbol) where {RetT, ArgsT<:Tuple, ConvT<:Cconvention} = Cfunction{RetT, ArgsT, ConvT}(sym, lib)
Cfunction{RetT, ArgsT}(lib::Clibrary, sym::Symbol) where {RetT, ArgsT<:Tuple} = Cfunction{RetT, ArgsT}(sym, lib)

Cfunction{RetT, ArgsT, ConvT}(sym::Symbol, lib::Clibrary, libs::Clibrary...) where {RetT, ArgsT<:Tuple, ConvT<:Cconvention} = Cfunction{RetT, ArgsT, ConvT}(_dlsym(sym, lib, libs...))
Cfunction{RetT, ArgsT}(sym::Symbol, lib::Clibrary, libs::Clibrary...) where {RetT, ArgsT<:Tuple} = Cfunction{RetT, ArgsT}(_dlsym(sym, lib, libs...))

# NOTE:  this returns a tuple (since the user must retain a reference to func for the function pointer to remain usable)
Cfunction{RetT, ArgsT}(func::Base.CFunction) where {RetT, ArgsT<:Tuple} = (Cfunction{RetT, ArgsT, default_convention(ArgsT)}(Base.unsafe_convert(Ptr{Cvoid}, func)), func)

@generated function Cfunction{RetT, ArgsT}(func::Function) where {RetT, ArgsT<:Tuple}
	_tuplize(::Type{Tuple{}}) where {T<:Tuple} = ()
	_tuplize(::Type{T}) where {T<:Tuple} = (Base.tuple_type_head(T), _tuplize(Base.tuple_type_tail(T))...,)
	
	types = _tuplize(ArgsT)
	return quote
		$(Expr(:meta, :inline))
		return Cfunction{RetT, ArgsT}(Base.@cfunction($(Expr(:$, :func)), RetT, ($(types...),)))
	end
end

convention(::Type{Cfunction{RetT, ArgsT, ConvT}}) where {RetT, ArgsT<:Tuple, ConvT<:Cconvention} = convention(ConvT)
convention(::Type{Cconvention{SymT}}) where {SymT} = SymT
convention(conv::Cconvention) = convention(typeof(conv))

todo"determine the correct default conventions for each platform"
todo"some compilers use different calling convention for variadic functions"
todo"identify what is Julia's calling convention"
default_convention(::Type{ArgsT}) where {ArgsT<:Tuple} = ifelse(Sys.iswindows(), STDCALL, CDECL)


# https://www.gnu.org/software/libc/manual/html_node/How-Variadic.html
# it appears that chars and ints are promoted to 32-bit ints and floats are promoted to doubles when used as varargs
cconvert_vararg(::Type{CDECL}, ::Type{T}) where {T} = T
cconvert_vararg(::Type{CDECL}, ::Type{T}) where {T<:Signed} = ifelse(sizeof(T) < sizeof(Cint), Cint, T)
cconvert_vararg(::Type{CDECL}, ::Type{T}) where {T<:Unsigned} = ifelse(sizeof(T) < sizeof(Cuint), Cuint, T)
cconvert_vararg(::Type{CDECL}, ::Type{T}) where {T<:Cchar} = ifelse(sizeof(T) < sizeof(Cint), Cint, T)
cconvert_vararg(::Type{CDECL}, ::Type{T}) where {T<:AbstractFloat} = ifelse(sizeof(T) < sizeof(Cdouble), Cdouble, T)


# these define a type to add to the type tuple when ccalling variadic functions
cconvert_default(::Type{T}) where {T} = error("Sorry, `$(T)` is not yet usable for variadic functions, provide `CBinding.cconvert_default(::Type{$(T)}) = CConvertType` to define how to pass it to a variadic function call")
cconvert_default(::Type{T}) where {T<:AbstractString} = Cstring
cconvert_default(::Type{T}) where {T<:Char} = Cchar
cconvert_default(::Type{T}) where {T<:Union{Integer, AbstractFloat, Ref}} = T   # this covers Ptr too, Ptr <: Ref
cconvert_default(::Type{T}) where {E, T<:AbstractArray{E}} = Ptr{E}


(f::Ptr{Cfunction{RetT, ArgsT}})(args...) where {RetT, ArgsT<:Tuple} = Cfunction{RetT, ArgsT, default_convention(ArgsT)}(reinterpret(Ptr{Cvoid}, f))(args...)
(f::Ptr{Cfunction{RetT, ArgsT, ConvT}})(args...) where {RetT, ArgsT<:Tuple, ConvT<:Cconvention} = invoke(f, args...)
@generated function invoke(f::Ptr{Cfunction{RetT, ArgsT, ConvT}}, args...) where {RetT, ArgsT<:Tuple, ConvT<:Cconvention}
	error = nothing
	_tuplize(::Type{Tuple{}}) = ()
	_tuplize(::Type{Tuple{}}, argT, argsT...) = (error = :(throw(MethodError(f, args))) ; ())
	_tuplize(::Type{Tuple{Vararg}}) = (:(Ptr{Cvoid}...),)  # HACK: extra `Ptr{Cvoid}...` is being added to trigger vararg ccall behavior rather than regular behavior (if there is a difference in the backend)
	_tuplize(::Type{Tuple{Vararg}}, argT, argsT...) = (cconvert_vararg(ConvT, cconvert_default(argT)), _tuplize(Tuple{Vararg}, argsT...)...,)
	_tuplize(::Type{T}) where {T<:Tuple} = (error = :(throw(MethodError(f, args))) ; ())
	_tuplize(::Type{T}, argT, argsT...) where {T<:Tuple} = (Base.tuple_type_head(T), _tuplize(Base.tuple_type_tail(T), argsT...)...,)
	
	types = _tuplize(ArgsT, args...)
	return !isnothing(error) ? error : quote
		$(Expr(:meta, :inline))
		ccall(reinterpret(Ptr{Cvoid}, f), $(convention(ConvT)), RetT, ($(types...),), $(map(i -> :(args[$(i)]), eachindex(args))...),)
	end
end
