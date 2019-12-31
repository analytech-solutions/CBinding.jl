

abstract type Cenum_anonymous <: Cenum end
isanonymous(::Type{<:Cenum_anonymous}) = true


function Base.show(io::IO, ce::CE) where {CE<:Cenum}
	if !(ce isa get(io, :typeinfo, Nothing))
		show(io, typeof(ce))
		print(io, "(")
	end
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
	if !(ce isa get(io, :typeinfo, Nothing))
		print(io, ")")
	end
end

Base.string(ce::CE) where {CE<:Cenum} = Base.print_to_string(ce)

Base.promote_rule(::Type{T}, ::Type{CE}) where {T<:Integer, CE<:Cenum} = promote_type(T, eltype(CE))

Base.convert(::Type{CE}, x::T) where {CE<:Cenum, T<:Integer} = reinterpret(concrete(CE), convert(eltype(CE), x))
Base.convert(::Type{T}, x::CE) where {CE<:Cenum, T<:Integer} = convert(T, reinterpret(eltype(CE), x))
Base.convert(::Type{CE1}, x::CE2) where {CE1<:Cenum, CE2<:Cenum} = convert(CE1, convert(eltype(CE2), x))

(::Type{CE1})(x::CE2) where {CE1<:Cenum, CE2<:Cenum} = convert(CE1, convert(eltype(CE2), x))
(::Type{CE})(x::T = zero(eltype(CE))) where {CE<:Cenum, T<:Integer} = convert(CE, x)
(::Type{T})(x::CE) where {CE<:Cenum, T<:Integer} = convert(T, x)

Base.eltype(ce::Cenum) = eltype(typeof(ce))
Base.eltype(::Type{CE}) where {CE<:Cenum} = Cenumlayout(CE).type

Base.typemin(::Type{CE}) where {CE<:Cenum} = Cenumlayout(CE).min
Base.typemax(::Type{CE}) where {CE<:Cenum} = Cenumlayout(CE).max

Base.:-(ce::Cenum) = -convert(eltype(ce), ce)
Base.trailing_ones(ce::Cenum) = trailing_ones(convert(eltype(ce), ce))
Base.trailing_zeros(ce::Cenum) = trailing_zeros(convert(eltype(ce), ce))


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

function _cenum(mod::Module, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing}, name::Union{Symbol, Expr, Nothing}, body::Expr)
	return _cenum(mod, deps, name, body, nothing)
end

function _cenum(mod::Module, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing}, name::Union{Symbol, Expr, Nothing}, body::Union{Expr, Nothing}, strategy::Union{Symbol, Nothing})
	isnothing(body) || Base.is_expr(body, :braces) || Base.is_expr(body, :bracescat) || error("Expected @cenum to have a `{ ... }` expression for the body of the type, but found `$(body)`")
	isnothing(name) || name isa Symbol || (Base.is_expr(name, :tuple, 1) && name.args[1] isa Symbol) || error("Expected @enum to have a valid name")
	
	strategy = isnothing(strategy) ? :(ALIGN_NATIVE) : :(Calignment{$(QuoteNode(Symbol(String(strategy)[3:end-2])))})
	isanon = isnothing(name) || name isa Expr
	super = isanon ? :(Cenum_anonymous) : :(Cenum)
	name = isnothing(name) ? gensym("anonymous-cenum") : name isa Expr ? Symbol("($(name.args[1]))") : name
	escName = esc(name)
	concreteName = esc(gensym(name))
	
	isOuter = isnothing(deps)
	deps = isOuter ? Pair{Symbol, Expr}[] : deps
	if isnothing(body)
		push!(deps, name => quote
			abstract type $(escName) <: $(super) end
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
			abstract type $(escName) <: $(super) end
			primitive type $(concreteName) <: $(escName) sizeof(Cenumlayout(Ctypespec($(super), $(strategy), Tuple{$(values...)})).type)*8 end
			#=
				EnumSpec = Tuple{
					Pair{:name, value}  # each enum constant's name and value
				}
			=#
			CBinding.concrete(::Type{$(escName)}) = $(concreteName)
			CBinding.concrete(::Type{$(concreteName)}) = $(concreteName)
			CBinding.strategy(::Type{$(concreteName)}) = $(strategy)
			CBinding.specification(::Type{$(concreteName)})  = Tuple{$(values...)}
			Base.sizeof(::Type{$(escName)}) = sizeof(CBinding.concrete($(concreteName)))
		end)
	end
	
	return isOuter ? quote $(map(last, deps)...) ; $(escName) end : escName
end

