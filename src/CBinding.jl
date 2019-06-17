module CBinding
	import Libdl
	using CEnum: @cenum
	using Todo: @todo_str
	
	
	export Clongdouble, Caggregate, Cstruct, Cunion, Carray, Caccessor, Clibrary, Cglobal, Cglobalconst, Cfunction
	export @ctypedef, @cstruct, @cunion, @carray, @calign
	
	
	# provide a temporary placeholder for 128-bit floating point primitive
	mutable struct Clongdouble
		mem::NTuple{16, UInt8}
		
		Clongdouble() = new()
	end
	
	
	abstract type Caggregate end
	abstract type Cstruct <: Caggregate end
	abstract type Cunion <: Caggregate end
	
	function _fields end
	
	todo"determine if using power-of-2 allocated mem::NTuple will improve anything"
	
	function (::Type{CA})(; kwargs...) where (CA<:Caggregate)
		result = CA(undef)
		if isempty(kwargs)
			setfield!(result, :mem, map(zero, getfield(result, :mem)))
		else
			CA <: Cunion && length(kwargs) > 1 && error("Expected only a single keyword argument when constructing Cunion's")
			foreach(kwarg -> setproperty!(result, kwarg...), kwargs)
		end
		return result
	end
	
	
	isanonymous(ca::Caggregate) = isanonymous(typeof(ca))
	isanonymous(::Type{CA}) where {CA<:Caggregate} = match(r"^##anonymous#\d+$", string(CA.name.name)) !== nothing
	
	function Base.show(io::IO, ::Type{CA}) where {CA<:Caggregate}
		print(io, isanonymous(CA) ? (CA <: Cunion ? "<anonymous-union>" : "<anonymous-struct>") : string(CA.name))
	end
	
	function Base.show(io::IO, ca::Caggregate)
		ca isa get(io, :typeinfo, Nothing) || show(io, typeof(ca))
		print(io, "(")
		for (ind, name) in enumerate(propertynames(typeof(ca)))
			print(io, ind > 1 ? ", " : "")
			print(io, name, "=")
			show(io, getproperty(ca, name))
		end
		print(io, ")")
	end
	
	
	
	mutable struct Carray{T, N, S} <: AbstractArray{T, 1}
		mem::NTuple{S, UInt8}
		
		Carray{T, N, S}(::UndefInitializer) where {T, N, S} = new{T, N, S}()
	end
	Carray{T, N}(u::UndefInitializer) where {T, N} = Carray{T, N, sizeof(Carray{T, N})}(u)
	
	function (::Type{CA})() where (CA<:Carray)
		result = CA(undef)
		setfield!(result, :mem, map(zero, getfield(result, :mem)))
		return result
	end
	
	Base.zero(::Type{CA}) where {CA<:Union{Caggregate, Carray}} = CA()
	Base.sizeof(::Type{CA}) where {T, N, CA<:Carray{T, N}} = sizeof(T)*N
	
	Base.getindex(ca::Carray{T, N}, ind) where {T, N} = unsafe_load(reinterpret(Ptr{T}, pointer_from_objref(ca)), ind)
	Base.setindex!(ca::Carray{T, N}, val, ind) where {T, N} = unsafe_store!(reinterpret(Ptr{T}, pointer_from_objref(ca)), val, ind)
	Base.getindex(ca::Carray{CA, N}, ind) where {CA<:Union{Caggregate, Carray}, N} = Caccessor{CA}(ca, (ind-1)*sizeof(CA))
	
	Base.IndexStyle(::Type{Carray{T, N}}) where {T, N} = IndexLinear()
	Base.size(ca::Carray{T, N}) where {T, N} = (N,)
	Base.length(ca::Carray{T, N}) where {T, N} = N
	Base.eltype(ca::Carray{T, N}) where {T, N} = T
	Base.size(::Type{Carray{T, N}}) where {T, N} = (N,)
	Base.length(::Type{Carray{T, N}}) where {T, N} = N
	Base.eltype(::Type{Carray{T, N}}) where {T, N} = T
	
	Base.iterate(ca::Carray{T, N}, state = 1) where {T, N} = state > N ? nothing : (ca[state], state+1)
	
	
	
	# Caccessor provides a deferred access mechanism to handle nested aggregate fields (in aggregates or arrays) to support correct/efficient behavior of:
	#   a.b[3].c.d = x
	#   y = a.b[3].c.d
	struct Caccessor{CA<:Union{Caggregate, Carray}}
		base::Union{Caggregate, Carray}
		offset::Int
	end
	
	Base.show(io::IO, ca::Caccessor{CA}) where {CA<:Union{Caggregate, Carray}} = show(io, convert(CA, ca))
	
	Caccessor{CA}(ca::Caccessor{<:Union{Caggregate, Carray}}, offset::Int) where {CA<:Union{Caggregate, Carray}} = Caccessor{CA}(getfield(ca, :base), getfield(ca, :offset) + offset)
	
	Base.convert(::Type{CA}, ca::Caccessor{CA}) where {CA<:Union{Caggregate, Carray}} = ca[]
	Base.pointer_from_objref(ca::Caccessor) = pointer_from_objref(getfield(ca, :base))+getfield(ca, :offset)
	
	# functions for when accessor refers to an array
	Base.getindex(ca::Caccessor{CA}) where {T, N, S, CA<:Carray{T, N, S}} = unsafe_load(reinterpret(Ptr{CA}, pointer_from_objref(ca)))
	Base.setindex!(ca::Caccessor{CA}, val::CA) where {T, N, S, CA<:Carray{T, N, S}} = unsafe_store!(reinterpret(Ptr{CA}, pointer_from_objref(ca)), val)
	Base.getindex(ca::Caccessor{CA}, ind) where {T, N, CA<:Carray{T, N}} = unsafe_load(reinterpret(Ptr{T}, pointer_from_objref(ca)), ind)
	Base.setindex!(ca::Caccessor{CA}, val::T, ind) where {T, N, CA<:Carray{T, N}} = unsafe_store!(reinterpret(Ptr{T}, pointer_from_objref(ca)), val, ind)
	Base.getindex(ca::Caccessor{CA}, ind) where {T<:Union{Caggregate, Carray}, N, CA<:Carray{T, N}} = Caccessor{T}(ca, (ind-1)*sizeof(T))
	
	Base.size(ca::Caccessor{CA}) where {T, N, CA<:Carray{T, N}} = (N,)
	Base.length(ca::Caccessor{CA}) where {T, N, CA<:Carray{T, N}} = N
	Base.eltype(ca::Caccessor{CA}) where {T, N, CA<:Carray{T, N}} = T
	Base.size(::Type{Caccessor{CA}}) where {T, N, CA<:Carray{T, N}} = (N,)
	Base.length(::Type{Caccessor{CA}}) where {T, N, CA<:Carray{T, N}} = N
	Base.eltype(::Type{Caccessor{CA}}) where {T, N, CA<:Carray{T, N}} = T
	
	Base.iterate(ca::Caccessor{CA}, state = 1) where {T, N, CA<:Carray{T, N}} = state > N ? nothing : (ca[state], state+1)
	
	# functions for when accessor refers to an aggregate
	Base.getindex(ca::Caccessor{CA}) where {CA<:Caggregate} = unsafe_load(reinterpret(Ptr{CA}, pointer_from_objref(ca)))
	Base.setindex!(ca::Caccessor{CA}, val::CA) where {CA<:Caggregate} = unsafe_store!(reinterpret(Ptr{CA}, pointer_from_objref(ca)), val)
	
	Base.propertynames(ca::CA; kwargs...) where {_CA<:Caggregate, CA<:Union{_CA, Caccessor{_CA}}} = propertynames(CA; kwargs...)
	Base.propertynames(::Type{CA}; kwargs...) where {_CA<:Caggregate, CA<:Union{_CA, Caccessor{_CA}}} = map(((off, sym, typ),) -> sym, _computefields(CA))
	
	_fields(ca::CA) where {_CA<:Caggregate, CA<:Union{_CA, Caccessor{_CA}}} = _fields(_CA)
	
	function _computefields(::Type{CA}) where {_CA<:Caggregate, CA<:Union{_CA, Caccessor{_CA}}}
		result = ()
		offset = 0
		
		function _compute(::Type{ca}) where {ca<:Caggregate}
			start = offset
			for (sym, typ) in _fields(ca)
				off = (ca <: Cunion ? start : offset)
				
				if sym === :_ && typ <: Caggregate
					_compute(typ)
				elseif !isnothing(sym)
					result = (result..., (off, sym, typ))
					offset = off + sizeof(typ)
				else
					offset = off + typ
				end
			end
		end
		
		_compute(_CA)
		return result
	end
	
	@generated function _bitmask(::Val{bits}) where {bits}
		mask = zero(Cuint)
		for i in 1:bits
			mask = (mask << one(Cuint)) | one(Cuint)
		end
		return Cuint(mask)
	end
	
	function Base.getproperty(ca::Union{CA, Caccessor{CA}}, sym::Symbol) where {CA<:Caggregate}
		for (off, nam, typ) in _computefields(typeof(ca))
			sym === nam || continue
			
			if typ <: Caggregate || typ <: Carray
				return Caccessor{typ}(ca, off)
			else
				return unsafe_load(reinterpret(Ptr{typ}, pointer_from_objref(ca)+off))
			end
		end
		return getfield(ca, sym)
	end
	
	function Base.setproperty!(ca::Union{CA, Caccessor{CA}}, sym::Symbol, val) where {CA<:Caggregate}
		for (off, nam, typ) in _computefields(typeof(ca))
			sym === nam || continue
			
			if typ <: Carray
				ca = Caccessor{typ}(ca, off)
				length(val) == length(ca) || error("Length of value does not match the length of the array field it is being assigned to")
				for (i, v) in enumerate(val)
					ca[i] = v
				end
			else
				unsafe_store!(reinterpret(Ptr{typ}, pointer_from_objref(ca)+off), val)
			end
			return val
		end
		return setfield!(ca, sym, val)
	end
	
	
	
	const _alignExprs = (Symbol("@calign"), :(CBinding.$(Symbol("@calign"))))
	const _structExprs = (Symbol("@cstruct"), :(CBinding.$(Symbol("@cstruct"))))
	const _unionExprs = (Symbol("@cunion"), :(CBinding.$(Symbol("@cunion"))))
	
	# macros need to accumulate definition of sub-structs/unions and define them above the expansion of the macro itself
	_expand(x, deps::Vector{Pair{Symbol, Expr}}, escape::Bool = true) = escape ? esc(x) : x
	function _expand(e::Expr, deps::Vector{Pair{Symbol, Expr}}, escape::Bool = true)
		if Base.is_expr(e, :macrocall)
			if length(e.args) > 1 && e.args[1] in (_alignExprs..., _structExprs..., _unionExprs...)
				if e.args[1] in _alignExprs
					return _calign(filter(x -> !(x isa LineNumberNode), e.args[2:end])..., deps)
				elseif e.args[1] in _structExprs
					return _caggregate(:cstruct, filter(x -> !(x isa LineNumberNode), e.args[2:end])..., deps)
				elseif e.args[1] in _unionExprs
					return _caggregate(:cunion, filter(x -> !(x isa LineNumberNode), e.args[2:end])..., deps)
				end
			else
				todo"determine if @__MODULE__ should be __module__ from the macro instead?"
				return _expand(macroexpand(@__MODULE__, e, recursive = false), deps)
			end
		elseif Base.is_expr(e, :ref, 2)
			return _carray(e, deps)
		else
			for i in eachindex(e.args)
				e.args[i] = _expand(e.args[i], deps, escape)
			end
			return e
		end
	end
	
	
	
	macro calign(exprs...) return _calign(exprs..., nothing) end
	
	function _calign(expr::Union{Integer, Expr}, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing})
		isOuter = isnothing(deps)
		deps = isOuter ? Pair{Symbol, Expr}[] : deps
		def = Expr(:align, _expand(expr, deps))
		
		return isOuter ? quote $(map(last, deps)...) ; $(def) end : def
	end
	
	
	
	macro ctypedef(exprs...) return _ctypedef(exprs..., nothing) end
	
	function _ctypedef(name::Symbol, expr::Union{Symbol, Expr}, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing})
		escName = esc(name)
		
		isOuter = isnothing(deps)
		deps = isOuter ? Pair{Symbol, Expr}[] : deps
		expr = _expand(expr, deps)
		push!(deps, name => quote
			const $(escName) = $(expr)
		end)
		
		return isOuter ? quote $(map(last, deps)...) ; $(escName) end : escName
	end
	
	
	
	macro cstruct(exprs...) return _caggregate(:cstruct, exprs..., nothing) end
	macro cunion(exprs...) return _caggregate(:cunion, exprs..., nothing) end
	
	function _caggregate(kind::Symbol, name::Symbol, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing})
		return _caggregate(kind, name, nothing, deps)
	end
	
	function _caggregate(kind::Symbol, body::Expr, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing})
		return _caggregate(kind, nothing, body, deps)
	end
	
	todo"Cint (signed) bitfields use 1 bit for their sign?!"
	function _caggregate(kind::Symbol, name::Union{Symbol, Nothing}, body::Union{Expr, Nothing}, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing})
		isnothing(body) || Base.is_expr(body, :braces) || Base.is_expr(body, :bracescat) || error("Expected @$(kind) to have a `{ ... }` expression for the body of the type, but found `$(body)`")
		
		name = isnothing(name) ? gensym("anonymous") : name
		escName = esc(name)
		
		isOuter = isnothing(deps)
		deps = isOuter ? Pair{Symbol, Expr}[] : deps
		if isnothing(body)
			push!(deps, name => quote
				mutable struct $(escName) <: $(kind === :cunion ? :(Cunion) : :(Cstruct))
					let constructor = false end
				end
			end)
		else
			bytes = kind === :cunion ? :(max()) : :(+())
			fields = []
			if !isnothing(body)
				for arg in body.args
					arg = _expand(arg, deps)
					if Base.is_expr(arg, :align, 1)
						align = arg.args[1]
						if kind === :cunion
							push!(bytes.args, align)
						else
							size = :(($(align)-1)-(($(length(bytes.args) > 1 ? deepcopy(bytes) : 0)+($(align)-1))%$(align)))
							push!(fields, :(nothing => $(size)))
							push!(bytes.args, size)
						end
					else
						if Base.is_expr(arg, :(:), 2) && Base.is_expr(arg.args[1], :(::), 2)
							todo"handle bitfields"
						end
						Base.is_expr(arg, :(::)) && (length(arg.args) != 2 || arg.args[1] === :_) && error("Expected @$(kind) to have a `fieldName::FieldType` expression in the body of the type, but found `$(arg)`")
						
						argName = Base.is_expr(arg, :(::), 1) || !Base.is_expr(arg, :(::)) ? :_ : arg.args[1]
						argName = Base.is_expr(argName, :escape, 1) ? argName.args[1] : argName
						argName isa Symbol || error("Expected a @$(kind) to have a Symbol for a field name, but found `$(argName)`")
						
						argType = Base.is_expr(arg, :(::)) ? arg.args[end] : arg
						push!(fields, :($(QuoteNode(argName)) => $(argType)))
						push!(bytes.args, :(sizeof($(argType))))
					end
				end
			end
			
			push!(deps, name => quote
				mutable struct $(escName) <: $(kind === :cunion ? :(Cunion) : :(Cstruct))
					mem::NTuple{$(length(bytes.args) > 1 ? bytes : 0), UInt8}
					
					$(escName)(::UndefInitializer) = new()
				end
				CBinding._fields(::Type{$(escName)}) = ($(fields...),)
			end)
		end
		
		return isOuter ? quote $(map(last, deps)...) ; $(escName) end : escName
	end
	
	
	
	macro carray(exprs...) _carray(exprs..., nothing) end
	
	function _carray(expr::Expr, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing})
		Base.is_expr(expr, :ref, 2) || error("Expected C array definition to be of the form `ElementType[N]`")
		
		isOuter = isnothing(deps)
		deps = isOuter ? Pair{Symbol, Expr}[] : deps
		expr.args[1] = _expand(expr.args[1], deps)
		expr.args[2] = _expand(expr.args[2], deps)
		def = :(Carray{$(expr.args[1]), $(expr.args[2]), sizeof(Carray{$(expr.args[1]), $(expr.args[2])})})
		
		return isOuter ? quote $(map(last, deps)...) ; $(def) end : def
	end
	
	
	
	struct Clibrary
		handle::Ptr{Cvoid}
		
		Clibrary(libName::Union{AbstractString, Nothing} = nothing) = new(Libdl.dlopen(libName === nothing ? _NullCString() : libName, Libdl.RTLD_LOCAL))
	end
	
	# NOTE:  risky hack to trick Julia dlopen into ccalling the C dlopen with NULL (meaning to dlopen current process rather than a library)
	struct _NullCString <: AbstractString end
	Base.cconvert(::Type{Cstring}, ::_NullCString) = Cstring(C_NULL)
	
	
	
	struct Cglobalconst{T}
		handle::Ptr{T}
		
		Cglobalconst{T}(lib::Clibrary, sym::Symbol) where {T} = new{T}(reinterpret(Ptr{T}, Libdl.dlsym(lib.handle, sym)))
	end
	struct Cglobal{T}
		handle::Ptr{T}
		
		Cglobal{T}(lib::Clibrary, sym::Symbol) where {T} = new{T}(reinterpret(Ptr{T}, Libdl.dlsym(lib.handle, sym)))
	end
	Base.getindex(g::Union{Cglobalconst{T}, Cglobal{T}}) where {T} = unsafe_load(g._t)
	Base.setindex!(g::Cglobal{T}, val::T) where {T} = unsafe_store!(g._t, val)
	
	
	
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
	
	
	mutable struct Variadicable{T}
		mem::Cint
	end
	variadicable(::Type{T}) where {T} = sizeof(T) < sizeof(Variadicable{T}) ? Variadicable{T} : T
	function Base.cconvert(::Type{Variadicable{T}}, x) where {T}
		sizeof(T) < sizeof(Variadicable{T}) || error("Unable to cconvert to a Variadicable{$(T)}")
		
		result = Variadicable{T}(0)
		unsafe_store!(reinterpret(Ptr{T}, pointer_from_objref(result)), Base.cconvert(T, x))
		return result
	end
	
	
	# these define a type to add to the type tuple when ccalling variadic functions
	cconvertible(::Type{T}) where {T} = error("Sorry, `$(T)` is not yet C-callable, define `CBinding.cconvertible(::Type{$(T)}) = CConvertibleType` if needed")
	cconvertible(::Type{T}) where {T<:AbstractString} = Cstring
	cconvertible(::Type{T}) where {T<:AbstractChar} = Cchar
	cconvertible(::Type{T}) where {T<:Union{Cchar, Cshort, Cint, Clong, Clonglong, Cuchar, Cushort, Cuint, Culong, Culonglong}} = T
	cconvertible(::Type{T}) where {T<:Union{Cfloat, Cdouble}} = T
	todo"add Ptr, Ref, Array cconvertible functions"
	
	
	(f::Ptr{Cfunction{RetT, ArgsT}})(args...) where {RetT, ArgsT<:Tuple} = invoke(f, args...)
	@generated function invoke(f::Ptr{Cfunction{RetT, ArgsT}}, args...) where {RetT, ArgsT<:Tuple}
		_tuplize(::Type{Tuple{}}) = ()
		_tuplize(::Type{Tuple{Vararg}}) = ()
		_tuplize(::Type{Tuple{Vararg}}, argT, argsT...) = (variadicable(cconvertible(argT)), _tuplize(Tuple{Vararg}, argsT...)...,)
		_tuplize(::Type{T}) where {T<:Tuple} = error("Not enough arguments used in call to Cfunction{$(RetT), $(ArgsT)} `$(f)($(argsT...))`")
		_tuplize(::Type{T}, argT, argsT...) where {T<:Tuple} = (Base.tuple_type_head(T), _tuplize(Base.tuple_type_tail(T), argsT...)...,)
		
	todo"fix variadic functions to align arguments"
		types = _tuplize(ArgsT, args...)
		return quote
			$(Expr(:meta, :inline))
			ccall(reinterpret(Ptr{Cvoid}, f), RetT, ($(types...),), $(map(i -> :(args[$(i)]), eachindex(args))...),)
		end
	end
end
