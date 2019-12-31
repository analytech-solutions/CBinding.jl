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
function Cfunction{RetT, ArgsT}(func::Function) where {RetT, ArgsT<:Tuple}
	_concrete(::Type{Tuple{}}) = Tuple{}
	_concrete(::Type{T}) where {T<:Tuple} = Base.tuple_type_cons(concrete(Base.tuple_type_head(T)), _concrete(Base.tuple_type_tail(T)))
	
	preciseRetT = concrete(RetT)
	preciseArgsT = _concrete(ArgsT)
	return Cfunction{RetT, ArgsT}(_cfunction(preciseRetT, preciseArgsT, func))
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


struct DeferredPtr{CF<:Cfunction, name<:Val, lib<:Val}
end

# functions to manufacture a precisely typed function pointer to invoke with ccall
_extend(::Type{Tuple{}}) = Tuple{}
_extend(::Type{Tuple{}}, argT, argsT...) = throw(MethodError(f, args))
_extend(::Type{Tuple{Vararg}}) = Tuple{Vararg}  # NOTE: leave the extra `Vararg` to preserve the variadic function call semantics
_extend(::Type{Tuple{Vararg}}, argT, argsT...) = Base.tuple_type_cons(concrete(cconvert_vararg(ConvT, cconvert_default(argT))), _extend(Tuple{Vararg}, argsT...))
_extend(::Type{T}) where {T<:Tuple} = throw(MethodError(f, args))
_extend(::Type{T}, argT, argsT...) where {T<:Tuple} = Base.tuple_type_cons(concrete(Base.tuple_type_head(T)), _extend(Base.tuple_type_tail(T), argsT...))
_extend(::Type{Cfunction{RetT, ArgsT, ConvT}}, args...) where {RetT, ArgsT<:Tuple, ConvT<:Cconvention} = Cfunction{concrete(RetT), _extend(ArgsT, map(typeof, args)...), ConvT}

(f::DeferredPtr{Cfunction{RetT, ArgsT}, Val{name}, Val{lib}})(args...) where {RetT, ArgsT<:Tuple, name, lib} = reinterpret(DeferredPtr{Cfunction{RetT, ArgsT, default_convention(ArgsT)}, Val{name}, Val{lib}}, f)(args...)
(f::DeferredPtr{Cfunction{RetT, ArgsT, ConvT}, Val{name}, Val{lib}})(args...) where {RetT, ArgsT<:Tuple, ConvT<:Cconvention, name, lib} = _ccall(reinterpret(DeferredPtr{_extend(Cfunction{RetT, ArgsT, ConvT}, args...), Val{name}, Val{lib}}, f), args...)

(f::Ptr{Cfunction{RetT, ArgsT}})(args...) where {RetT, ArgsT<:Tuple} = Cfunction{RetT, ArgsT, default_convention(ArgsT)}(reinterpret(Ptr{Cvoid}, f))(args...)
(f::Ptr{Cfunction{RetT, ArgsT, ConvT}})(args...) where {RetT, ArgsT<:Tuple, ConvT<:Cconvention} = _ccall(reinterpret(Ptr{_extend(Cfunction{RetT, ArgsT, ConvT}, args...)}, f), args...)

@generated function _ccall(f::Union{Ptr{Cfunction{RetT, ArgsT, ConvT}}, DeferredPtr{Cfunction{RetT, ArgsT, ConvT}, Val{name}, Val{lib}}}, args...) where {RetT, ArgsT<:Tuple, ConvT<:Cconvention, name, lib}
	_tuplize(::Type{Tuple{}}) = ()
	_tuplize(::Type{Tuple{Vararg}}) = (:(Ptr{Cvoid}...),)  # NOTE: `Ptr{Cvoid}...` is being added to trigger vararg ccall behavior rather than regular behavior (if there is a difference in the backend)
	_tuplize(::Type{T}) where {T<:Tuple} = (Base.tuple_type_head(T), _tuplize(Base.tuple_type_tail(T))...,)
	
	f = f isa Ptr ? :(reinterpret(Ptr{Cvoid}, f)) : :(($(QuoteNode(name)), $(String(lib))))
	return quote
		return ccall($(f), $(convention(ConvT)), RetT, ($(_tuplize(ArgsT)...),), $(map(i -> :(args[$(i)]), eachindex(args))...),)
	end
end



macro ccallback(expr...) return _ccallback(__module__, expr...) end

function _ccallback(mod::Module, expr::Expr)
	((Base.is_expr(expr, :function, 2) || Base.is_expr(expr, :(=), 2)) && Base.is_expr(expr.args[2], :block)) || error("Expectd @ccallback to receive a function expression, but found `$(expr)`")
	sig = expr.args[1]
	
	Base.is_expr(sig, :(::), 2) || error("Expected @ccallback function signature to have a return type specified `func(arg::ArgType)::RetType = ...`")
	rettype = sig.args[2]
	
	(Base.is_expr(sig.args[1], :call) && length(sig.args[1].args) >= 1) || error("Expected @ccallback to receive a function signature, but found `$(sig.args[1])`")
	name = sig.args[1].args[1]
	args = sig.args[1].args[2:end]
	
	argtypes = []
	for arg in args
		Base.is_expr(arg, :(::), 2) || error("Expected @ccallback function signature to have argument types specified `func(arg::ArgType)::RetType = ...`")
		push!(argtypes, arg.args[2])
	end
	
	sym = gensym(Symbol(:C, name))
	return quote
		$(esc(expr))
		($(esc(sym)), $(esc(gensym(name)))) = Cfunction{$(esc(rettype)), Tuple{$(map(esc, argtypes)...)}}($(esc(name)))
		$(esc(sym))
	end
end

@generated function _cfunction(::Type{RetT}, ::Type{ArgsT}, func::Function) where {RetT, ArgsT<:Tuple}
	_tuplize(::Type{Tuple{}}) = ()
	_tuplize(::Type{T}) where {T<:Tuple} = (Base.tuple_type_head(T), _tuplize(Base.tuple_type_tail(T))...,)
	
	return quote
		return @cfunction($(Expr(:$, :func)), RetT, ($(_tuplize(ArgsT)...),))
	end
end

