

abstract type Cenum_anonymous <: Cenum end
isanonymous(::Type{<:Cenum_anonymous}) = true
Base.show(io::IO, ::Type{CS}) where {CS<:Cenum_anonymous} = print(io, "<anonymous-enum>")


function Base.show(io::IO, ce::CE) where {CE<:Cenum}
	ce isa get(io, :typeinfo, Nothing) || show(io, typeof(ce))
	print(io, "(")
	value = convert(eltype(CE), ce)
	found = false
	for (name, val) in Cenumlayout(CE).values
		if value == val
			print(io, "<", name, ">", "(")
			show(io, value)
			print(io, ")")
			found = true
			break
		end
	end
	found || show(io, value)
	print(io, ")")
end

Base.promote_rule(::Type{T}, ::Type{CE}) where {T<:Integer, CE<:Cenum} = promote_type(T, eltype(CE))

Base.convert(::Type{CE}, x::T) where {CE<:Cenum, T<:Integer} = reinterpret(CE, convert(eltype(CE), x))
Base.convert(::Type{T}, x::CE) where {CE<:Cenum, T<:Integer} = convert(T, reinterpret(eltype(CE), x))
Base.convert(::Type{CE1}, x::CE2) where {CE1<:Cenum, CE2<:Cenum} = convert(CE1, convert(eltype(CE2), x))

(::Type{CE1})(x::CE2) where {CE1<:Cenum, CE2<:Cenum} = convert(CE1, convert(eltype(CE2), x))
(::Type{CE})(x::T) where {CE<:Cenum, T<:Integer} = convert(CE, x)
(::Type{T})(x::CE) where {CE<:Cenum, T<:Integer} = convert(T, x)

Base.eltype(ce::Cenum) = eltype(typeof(ce))
Base.eltype(::Type{CE}) where {CE<:Cenum} = Cenumlayout(CE).type

Base.typemin(::Type{CE}) where {CE<:Cenum} = Cenumlayout(CE).min
Base.typemax(::Type{CE}) where {CE<:Cenum} = Cenumlayout(CE).max



macro cenum(exprs...) return _cenum(__module__, nothing, exprs...) end

function _cenum(mod::Module, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing}, name::Symbol)
	return _cenum(mod, deps, name, nothing, nothing)
end

function _cenum(mod::Module, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing}, body::Expr)
	return _cenum(mod, deps, nothing, body, nothing)
end

function _cenum(mod::Module, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing}, body::Expr, strategy::Symbol)
	return _cenum(mod, deps, nothing, body, strategy)
end

function _cenum(mod::Module, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing}, name::Symbol, body::Expr)
	return _cenum(mod, deps, name, body, nothing)
end

function _cenum(mod::Module, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing}, name::Union{Symbol, Nothing}, body::Union{Expr, Nothing}, strategy::Union{Symbol, Nothing})
	isnothing(body) || Base.is_expr(body, :braces) || Base.is_expr(body, :bracescat) || error("Expected @cenum to have a `{ ... }` expression for the body of the type, but found `$(body)`")
	
	strategy = isnothing(strategy) ? :(CBinding.ALIGN_NATIVE) : :(Calignment{$(QuoteNode(Symbol(String(strategy)[3:end-2])))})
	isanon = isnothing(name)
	super = isanon ? :(Cenum_anonymous) : :(Cenum)
	name = isanon ? gensym("anonymous-cenum") : name
	escName = esc(name)
	concreteName = esc(Symbol(name, "\u200B"))  # this is so incredibly evil: appending a 0-width space to the type name
	
	isOuter = isnothing(deps)
	deps = isOuter ? Pair{Symbol, Expr}[] : deps
	if isnothing(body)
		push!(deps, name => quote
			abstract type $(escName) <: Cenum end
		end)
	else
		fields = []
		values = []
		for arg in body.args
			arg = _expand(mod, deps, arg)
			
			lastArg = isempty(values) ? :(0) : :($(last(last(values).args)) + 1)
			if arg isa Symbol
				push!(fields, :(const $(arg) = ($(lastArg))::Integer))
				push!(values, :(Pair{$(QuoteNode(arg)), $(arg)}))
			elseif Base.is_expr(arg, :escape, 1) && arg.args[1] isa Symbol
				push!(fields, :(const $(arg) = ($(lastArg))::Integer))
				push!(values, :(Pair{$(QuoteNode(arg.args[1])), $(arg)}))
			elseif Base.is_expr(arg, :(=), 2) && arg.args[1] isa Symbol
				push!(fields, :(const $(arg.args[1]) = ($(arg.args[2]))::Integer))
				push!(values, :(Pair{$(QuoteNode(arg.args[1])), $(arg.args[1])}))
			elseif Base.is_expr(arg, :(=), 2) && Base.is_expr(arg.args[1], :escape, 1) && arg.args[1].args[1] isa Symbol
				push!(fields, :(const $(arg.args[1]) = ($(arg.args[2]))::Integer))
				push!(values, :(Pair{$(QuoteNode(arg.args[1].args[1])), $(arg.args[1])}))
			else
				error("Expected @cenum to have a member symbol (`VALUE`) or member assignment expression (`VALUE = value_expr`) in its body")
			end
		end
		
		isempty(values) && error("Expected @cenum to have at least 1 value")
		
		push!(deps, name => quote
			$(fields...)
			abstract type $(escName) <: Cenum end
			primitive type $(concreteName) <: $(escName) sizeof(Cenumlayout(Ctypespec(Cenum, $(strategy), Tuple{$(values...)})).type)*8 end
			#=
				EnumSpec = Tuple{
					Pair{:name, value}  # each enum constant's name and value
				}
			=#
			CBinding._concrete(::Type{$(escName)}) = $(concreteName)
			CBinding._concrete(::Type{$(concreteName)}) = $(concreteName)
			CBinding._strategy(::Type{$(concreteName)}) = $(strategy)
			CBinding._specification(::Type{$(concreteName)})  = Tuple{$(values...)}
			Base.sizeof(::Type{$(escName)}) = sizeof(CBinding._concrete($(concreteName)))
		end)
	end
	
	return isOuter ? quote $(map(last, deps)...) ; $(escName) end : escName
end

