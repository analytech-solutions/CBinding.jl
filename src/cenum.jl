

_fields(::Type{CE}) where {CE<:Cenum} = error("Attempted to get values of an enumeration without any")

isanonymous(ce::Cenum) = isanonymous(typeof(ce))
isanonymous(::Type{CE}) where {T, CE<:Cenum{T}} = match(r"^##anonymous#\d+$", string(CE.name.name)) !== nothing

function Base.show(io::IO, ::Type{CE}) where {T, CE<:Cenum{T}}
	print(io, isanonymous(CE) ? "<anonymous-enum>" : string(CE.name))
end

function Base.show(io::IO, ce::Cenum{T}) where {T}
	ce isa get(io, :typeinfo, Nothing) || show(io, typeof(ce))
	print(io, "(")
	value = convert(T, ce)
	found = false
	for (name, val) in _fields(typeof(ce))
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

Base.promote_rule(::Type{T}, ::Type{<:Cenum{_T}}) where {_T, T<:Integer} = promote_type(_T, T)

Base.convert(::Type{CE}, x::T) where {_T, CE<:Cenum{_T}, T<:Integer} = Core.Intrinsics.bitcast(CE, convert(_T, x))
Base.convert(::Type{T}, x::CE) where {_T, CE<:Cenum{_T}, T<:Integer} = convert(T, Core.Intrinsics.bitcast(_T, x))
Base.convert(::Type{CE1}, x::CE2) where {T1, CE1<:Cenum{T1}, T2, CE2<:Cenum{T2}} = convert(CE1, convert(T2, x))

(::Type{CE1})(x::CE2) where {T1, CE1<:Cenum{T1}, T2, CE2<:Cenum{T2}} = convert(CE1, convert(T2, x))
(::Type{CE})(x::T) where {_T, CE<:Cenum{_T}, T<:Integer} = convert(CE, x)
(::Type{T})(x::CE) where {_T, CE<:Cenum{_T}, T<:Integer} = convert(T, x)

Base.eltype(::Type{CE}) where {T, CE<:Cenum{T}} = T
Base.eltype(ce::Cenum) = eltype(typeof(ce))

Base.typemin(::Type{CE}) where {CE<:Cenum} = minimum(map(last, _fields(CE)))
Base.typemax(::Type{CE}) where {CE<:Cenum} = maximum(map(last, _fields(CE)))



macro cenum(exprs...) return _cenum(__module__, nothing, exprs...) end

function _cenum(mod::Module, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing}, name::Symbol)
	return _cenum(mod, deps, name, nothing)
end

function _cenum(mod::Module, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing}, body::Expr)
	return _cenum(mod, deps, nothing, body)
end

function _cenum(mod::Module, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing}, name::Union{Symbol, Nothing}, body::Union{Expr, Nothing})
	isnothing(body) || Base.is_expr(body, :braces) || Base.is_expr(body, :bracescat) || error("Expected @cenum to have a `{ ... }` expression for the body of the type, but found `$(body)`")
	
	name = isnothing(name) ? gensym("anonymous") : name
	escName = esc(name)
	
	isOuter = isnothing(deps)
	deps = isOuter ? Pair{Symbol, Expr}[] : deps
	if isnothing(body)
		push!(deps, name => quote
			mutable struct $(escName) <: Cenum
				let constructor = false end
			end
		end)
	else
		fields = []
		values = []
		for arg in body.args
			arg = _expand(mod, deps, arg)
			
			lastArg = isempty(values) ? :(0) : :($(last(values)) + 1)
			if arg isa Symbol
				push!(fields, Expr(:const, :($(arg) = $(lastArg))))
				push!(values, arg)
			elseif Base.is_expr(arg, :escape, 1) && arg.args[1] isa Symbol
				push!(fields, Expr(:const, :($(arg) = $(lastArg))))
				push!(values, arg)
			elseif Base.is_expr(arg, :(=), 2) && arg.args[1] isa Symbol
				push!(fields, Expr(:const, :($(arg.args[1]) = $(arg.args[2]))))
				push!(values, arg.args[1])
			elseif Base.is_expr(arg, :(=), 2) && Base.is_expr(arg.args[1], :escape, 1) && arg.args[1].args[1] isa Symbol
				push!(fields, Expr(:const, :($(arg.args[1]) = $(arg.args[2]))))
				push!(values, arg.args[1])
			else
				error("Expected @cenum to have a member symbol (`VALUE`) or member assignment expression (`VALUE = value_expr`) in its body")
			end
		end
		
		values = map(x -> :($(QuoteNode(Base.is_expr(x, :escape, 1) && x.args[1] isa Symbol ? x.args[1] : x)) => $(x)), values)
		push!(deps, name => quote
			$(fields...)
			primitive type $(escName) <: Cenum{_computeEnumType(($(values...),))} sizeof(_computeEnumType(($(values...),)))*8 end
			CBinding._fields(::Type{$(escName)}) = map(((x, y),) -> x => eltype($(escName))(y), ($(values...),))
		end)
	end
	
	return isOuter ? quote $(map(last, deps)...) ; $(escName) end : escName
end



_computeEnumType(::Type{CE}) where {_CE<:Cenum, CE<:Union{_CE, Caccessor{_CE}}} = eltype(_CE)
function _computeEnumType(fields::Tuple)
	(min, max) = extrema(map(last, fields))
	
	for typ in (UInt32, Int32, UInt64, Int64, UInt128, Int128)
		typemin(typ) <= min && max <= typemax(typ) && return typ
	end
	
	error("Unable to determine suitable enumeration storage type for the values provided")
end


