

macro cbindings(exprs...) return _cbindings(__module__, exprs...) end

function _cbindings(mod::Module, block::Expr)
	return _cbindings(mod, "", block)
end

function _cbindings(mod::Module, lib::Union{Expr, Symbol}, block::Expr)
	lib::String = @eval mod $(lib)
	return _cbindings(mod, lib, block)
end

function _cbindings(mod::Module, lib::String, block::Expr)
	function _addlibs(e)
		if Base.is_expr(e, :macrocall) && length(e.args) >= 1 && e.args[1] in _externExprs
			push!(e.args, lib)
		elseif e isa Expr
			for expr in e.args
				_addlibs(expr)
			end
		end
	end
	_addlibs(block)
	
	return esc(Base.is_expr(block, :block) ? quote $(map(x -> x isa LineNumberNode ? x : :($(@__MODULE__).@eval $(x)), block.args)...) end : block)
end


macro cextern(exprs...) return _cextern(__module__, exprs...) end

function _cextern(mod::Module, expr::Expr, lib::String = "")
	Base.is_expr(expr, :(::), 2) || error("Expected @cextern to have a `fieldName::FieldType` expression, but found `$(expr)`")
	(externs, externType) = expr.args
	
	deps = Pair{Symbol, Expr}[]
	externType = _expand(mod, deps, externType)
	externs = map(Base.is_expr(externs, :tuple) ? externs.args : (externs,)) do e
		_augment(e, externType)
		
		(e, etype) = Base.is_expr(e, :(::), 2) ? e.args : (e, externType)
		return (Base.is_expr(e, :call) && length(e.args) >= 1 && e.args[1] !== :(:) ? _cextern_function : _cextern_variable)(mod, deps, e, externType, lib)
	end
	
	return quote
		$(map(last, deps)...)
		$(externs...)
		nothing
	end
end


function _cextern_function(mod::Module, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing}, func::Expr, retType::Union{Symbol, Expr}, lib::String)
	(Base.is_expr(func, :call) && length(func.args) >= 1) || error("Expected @cextern to have a function `func(...)` in the function signature, but got `$(func)`")
	name = func.args[1]
	name isa Symbol || error("Expected @cextern function to have a valid function name")
	
	argNames = []
	argTypes = map(func.args[2:end]) do arg
		Base.is_expr(arg, :(::), 2) || Base.is_expr(arg, :(...), 1) || error("Expected @cextern to have function arguments specified as `argName::ArgType` or `argName...`, but got `$(arg)`")
		if Base.is_expr(arg, :(::), 2)
			(argName, argType) = arg.args
		else
			(argName, argType) = (arg, :Vararg)
		end
		push!(argNames, argName)
		return _expand(mod, deps, argType)
	end
	
	sig = (
		retType,
		:($(@__MODULE__).Tuple{$(argTypes...)}),
		# TODO: support calling conventions
		# (isnothing(conv) ? () : (:($(@__MODULE__).Cconvention{$(QuoteNode(conv))}),))...,
	)
	
	
	return quote
		$(@__MODULE__).@eval $(name)($(argNames...)) = $(Expr(:$, :(
			$(@__MODULE__).DeferredPtr{
				$(@__MODULE__).Cfunction{$(sig...)},
				$(@__MODULE__).Val{$(QuoteNode(name))},
				$(@__MODULE__).Val{$(QuoteNode(Symbol(lib)))}
			}()
		)))($(argNames...))
	end
end


function _cextern_variable(mod::Module, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing}, var::Symbol, varType::Union{Symbol, Expr}, lib::String)
	return quote
		$(@__MODULE__).@eval $(var)() = $(Expr(:$, :(
			$(@__MODULE__).DeferredCglobal{
				$(varType),
				$(@__MODULE__).Val{$(QuoteNode(var))},
				$(@__MODULE__).Val{$(QuoteNode(Symbol(lib)))}
			}()
		)))()
	end
end

