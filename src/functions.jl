

rettype(::Union{Cptr{CF}, Cbinding{CF, lib, name}}) where {CF<:Cfunction, lib, name} = rettype(CF)
argtypes(::Union{Cptr{CF}, Cbinding{CF, lib, name}}) where {CF<:Cfunction, lib, name} = argtypes(CF)
convention(::Union{Cptr{CF}, Cbinding{CF, lib, name}}) where {CF<:Cfunction, lib, name} = convention(CF)
rettype(::Type{CF}) where {retT, argTs, conv, CF<:Cfunction{retT, argTs, conv}} = retT
argtypes(::Type{CF}) where {retT, argTs, conv, CF<:Cfunction{retT, argTs, conv}} = argTs
convention(::Type{CF}) where {retT, argTs, conv, CF<:Cfunction{retT, argTs, conv}} = conv


# https://www.gnu.org/software/libc/manual/html_node/How-Variadic.html
# it appears that chars and ints are promoted to 32-bit ints and floats are promoted to doubles when used as varargs
cconvert_vararg(::Val{:cdecl}, ::Type{T}) where {T} = T
cconvert_vararg(::Val{:cdecl}, ::Type{T}) where {T<:Signed} = ifelse(sizeof(T) < sizeof(Cint), Cint, T)
cconvert_vararg(::Val{:cdecl}, ::Type{T}) where {T<:Unsigned} = ifelse(sizeof(T) < sizeof(Cuint), Cuint, T)
cconvert_vararg(::Val{:cdecl}, ::Type{T}) where {T<:Cchar} = ifelse(sizeof(T) < sizeof(Cint), Cint, T)
cconvert_vararg(::Val{:cdecl}, ::Type{T}) where {T<:AbstractFloat} = ifelse(sizeof(T) < sizeof(Cdouble), Cdouble, T)


# these define a type to add to the type tuple when ccalling variadic functions
cconvert_default(::Type{T}) where {T} = error("Sorry, `$(T)` is not yet usable for variadic functions, provide `C.cconvert_default(::Type{$(T)}) = CConvertType` to define how to pass it to a variadic function call")
cconvert_default(::Type{T}) where {T<:AbstractString} = Cstring
cconvert_default(::Type{T}) where {T<:Char} = Cchar
cconvert_default(::Type{T}) where {T<:Union{Integer, AbstractFloat, Ref}} = T   # this covers Cptr too, Cptr <: Ref
cconvert_default(::Type{T}) where {E, T<:AbstractArray{E}} = Cptr{E}


(cb::Cbinding{<:Cfunction})(args...) = funccall(cb, args...)
(func::Cptr{<:Cfunction})(args...) = funccall(func, args...)


@generated function funccall(::Type{retT}, ::Type{argTs}, ::Val{conv}, func::Union{Cptr{<:Cfunction}, Cbinding{<:Cfunction, lib, name}}, args...) where {retT, argTs, conv, lib, name}
	return :(ccall(
		$(func <: Cptr ? :(Core.Intrinsics.bitcast(Ptr{Cvoid}, func)) : lib isa Symbol ? :(($(QuoteNode(name)), $(String(lib)))) : QuoteNode(name)),
		$((conv isa Symbol ? (conv,) : ())...),
		$(retT),
		($(((argT <: Cvariadic ? :(Ptr{Cvoid}...) : argT) for argT in argTs)...),),
		$((:(args[$(i)]) for i in eachindex(args))...)
	))
end

@generated function funccall(func::Union{Cptr{CF}, Cbinding{CF, lib, name}}, args...) where {retT, argTs, conv, CF<:Union{Cfunction{retT, argTs}, Cfunction{retT, argTs, conv}}, lib, name}
	function getbitstypes(Ts, ind)
		ind <= length(args) && Ts <: Tuple{} && return nothing  # more args, but no arg types
		ind > length(args) && return Ts <: Tuple{} ? () : Ts <: Tuple{Cvariadic} ? (Cvariadic,) : nothing  # no more args, are there more arg types left?
		
		# make up a new type if its variadic, otherwise keep plugging along
		H  = Ts <: Tuple{Cvariadic} ? :(cconvert_vararg(Val(conv), bitstype(cconvert_default($(args[ind]))))) : Base.tuple_type_head(Ts)
		Ts = Ts <: Tuple{Cvariadic} ? Ts : Base.tuple_type_tail(Ts)
		sig = getbitstypes(Ts, ind+1)
		return isnothing(sig) ? nothing : (:(bitstype($(H))), sig...)
	end
	
	rett  = :(bitstype(retT))
	argts = getbitstypes(argTs, 1)
	convt = conv isa Symbol ? :(conv) : nothing
	
	return isnothing(argts) ? quote
		throw(MethodError(func, args))
	end : quote
		return funccall($(rett), Tuple{$((argt for argt in argts)...)}, Val($(convt)), func, args...)
	end
end



Base.cconvert(::Type{Cptr{CF}}, func::Function) where {retT, argTs, CF<:Cfunction{retT, argTs}} = Cptr{CF}(func)
Base.cconvert(::Type{Cptr{CF}}, func::Base.CFunction) where {retT, argTs, CF<:Cfunction{retT, argTs}} = Cptr{CF}(Base.unsafe_convert(Ptr{Cvoid}(func)))


Cptr{CF}(func::Function) where {CF<:Cfunction} = funccallback(CF, Val(func))
Cptr{CF}(func::Base.CFunction) where {CF<:Cfunction} = Cptr{CF}(func)

@generated function funccallback(::Type{retT}, ::Type{argTs}, ::Val{conv}, ::Val{func}) where {retT, argTs, conv, func}
	return :(Cptr{
		$(conv isa Symbol ? :(Cfunction{retT, argTs, conv}) : :(Cfunction{retT, argTs}))
	}(@cfunction(
		$(func),
		$(retT),
		($((argT for argT in argTs)...),))
	))
end

@generated function funccallback(::Type{CF}, ::Val{func}) where {retT, argTs, conv, CF<:Union{Cfunction{retT, argTs}, Cfunction{retT, argTs, conv}}, func}
	getbitstypes(Ts) = Ts <: Tuple{} ? () : (:(bitstype($(Base.tuple_type_head(Ts)))), getbitstypes(Base.tuple_type_tail(Ts))...)
	
	rett  = :(bitstype(retT))
	argts = getbitstypes(argTs)
	convt = conv isa Symbol ? :(conv) : nothing
	
	return quote
		isbitstype(typeof(func)) ?
			funccallback($(rett), Tuple{$((argt for argt in argts)...)}, Val($(convt)), Val($(func))) :
			error("Method `$(func)` is a closure, please use @cfunction to obtain a Base.CFunction first")
	end
end

