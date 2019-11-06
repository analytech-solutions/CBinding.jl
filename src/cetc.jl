

# NOTE:  these are several hacks to make the forward declarations work
# this side steps dispatching when making ccalls with Ptr{Abstract} using a Ref{Concrete<:Abstract}
struct _Ref{To, From, R<:Base.RefValue{From}}
	r::R
end
Base.cconvert(::Type{Ptr{CO}}, r::R) where {CO<:Copaques, R<:Base.RefValue{CO}} = r
Base.cconvert(::Type{Ptr{CO}}, r::R) where {CO<:Copaques, T<:CO, R<:Base.RefValue{T}} = _Ref{CO, T, R}(r)
Base.unsafe_convert(::Type{Ptr{CO}}, r::_Ref{CO, T, R}) where {CO<:Copaques, T<:CO, R<:Base.RefValue{T}} = reinterpret(Ptr{CO}, Base.unsafe_convert(Ptr{T}, r.r))
Base.unsafe_load(p::Ptr{CO}, i::Integer = 1) where {CO<:Copaques} = Base.pointerref(reinterpret(Ptr{_concrete(CO)}, p), Int(i), 1)
Base.unsafe_store!(p::Ptr{CO}, x, i::Integer = 1) where {CO<:Copaques} = Base.pointerset(reinterpret(Ptr{_concrete(CO)}, p), convert(_concrete(CO), x), Int(i), 1)



const _alignExprs = (Symbol("@calign"), :(CBinding.$(Symbol("@calign"))))
const _enumExprs = (Symbol("@cenum"), :(CBinding.$(Symbol("@cenum"))))
const _arrayExprs = (Symbol("@carray"), :(CBinding.$(Symbol("@carray"))))
const _structExprs = (Symbol("@cstruct"), :(CBinding.$(Symbol("@cstruct"))))
const _unionExprs = (Symbol("@cunion"), :(CBinding.$(Symbol("@cunion"))))
const _externExprs = (Symbol("@cextern"), :(CBinding.$(Symbol("@cextern"))))

# macros need to accumulate definition of sub-structs/unions and define them above the expansion of the macro itself
_expand(mod::Module, deps::Vector{Pair{Symbol, Expr}}, x, escape::Bool = true) = escape ? esc(x) : x
function _expand(mod::Module, deps::Vector{Pair{Symbol, Expr}}, e::Expr, escape::Bool = true)
	if Base.is_expr(e, :macrocall)
		if length(e.args) > 1 && e.args[1] in (_alignExprs..., _enumExprs..., _arrayExprs..., _structExprs..., _unionExprs...)
			if e.args[1] in _alignExprs
				return _calign(mod, deps, filter(x -> !(x isa LineNumberNode), e.args[2:end])...)
			elseif e.args[1] in _enumExprs
				return _cenum(mod, deps, filter(x -> !(x isa LineNumberNode), e.args[2:end])...)
			elseif e.args[1] in _arrayExprs
				return _carray(mod, deps, filter(x -> !(x isa LineNumberNode), e.args[2:end])...)
			elseif e.args[1] in _structExprs
				return _caggregate(mod, deps, :cstruct, filter(x -> !(x isa LineNumberNode), e.args[2:end])...)
			elseif e.args[1] in _unionExprs
				return _caggregate(mod, deps, :cunion, filter(x -> !(x isa LineNumberNode), e.args[2:end])...)
			end
		else
			return _expand(mod, deps, macroexpand(mod, e, recursive = false))
		end
	elseif Base.is_expr(e, :ref, 2)
		return _carray(mod, deps, e)
	else
		for i in eachindex(e.args)
			e.args[i] = _expand(mod, deps, e.args[i], escape)
		end
		return e
	end
end



macro calign(exprs...) return _calign(__module__, nothing, exprs...) end

function _calign(mod::Module, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing}, expr::Union{Integer, Expr})
	isOuter = isnothing(deps)
	deps = isOuter ? Pair{Symbol, Expr}[] : deps
	def = Expr(:align, _expand(mod, deps, expr))
	
	return isOuter ? quote $(map(last, deps)...) ; $(def) end : def
end



macro ctypedef(exprs...) return _ctypedef(__module__, nothing, exprs...) end

function _ctypedef(mod::Module, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing}, name::Symbol, expr::Union{Symbol, Expr})
	escName = esc(name)
	
	isOuter = isnothing(deps)
	deps = isOuter ? Pair{Symbol, Expr}[] : deps
	expr = _expand(mod, deps, expr)
	push!(deps, name => quote
		const $(escName) = $(expr)
	end)
	
	return isOuter ? quote $(map(last, deps)...) ; $(escName) end : escName
end



