

function _dlsym(sym::Symbol, libs::Clibrary...)
	for (ind, lib) in enumerate(libs)
		isLast = ind == length(libs)
		handle = Libdl.dlsym(lib.handle, sym, throw_error = isLast)
		isnothing(handle) || return handle
	end
	error("Libdl.dlsym returned a C_NULL handle and did not throw an error")
end


macro cbindings(exprs...) return _cbindings(__module__, exprs...) end

function _cbindings(mod::Module, block::Expr)
	return _cbindings(mod, "", block)
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
	
	return esc(block)
end


macro cextern(exprs...) return _cextern(__module__, exprs...) end

function _cextern(mod::Module, expr::Expr, lib::String)
	return _cextern(mod, nothing, expr, lib)
end

function _cextern(mod::Module, conv::Union{Symbol, Nothing}, expr::Expr, lib::String)
	# allow for exposing alternative binding names in Julia with `const exposed = ...`
	destName = nothing
	if Base.is_expr(expr, :const, 1) && Base.is_expr(expr.args[1], :(=), 2) && expr.args[1].args[1] isa Symbol
		destName = expr.args[1].args[1]
		expr = expr.args[1].args[2]
	end
	
	Base.is_expr(expr, :(::), 2) || error("Expected @cextern to have a function signature, `func(arg1::Arg1Type, ..., argN::ArgNType)::ReturnType`, or a global variable, `variable::VarType`, expression, but found `$(sig)`")
	(externName, externType) = expr.args
	return (externName isa Symbol ? _cextern_variable : _cextern_function)(mod, conv, destName, externName, externType, lib)
end

function _cextern_function(mod::Module, conv::Union{Symbol, Nothing}, destName::Union{Symbol, Nothing}, func::Expr, retType::Union{Symbol, Expr}, lib::String)
	isnothing(conv) || (startswith(String(conv), "__") && endswith(String(conv), "__") && length(String(conv)) > 4) || error("Expected @cextern to have a calling convention specified as `__CONVENTION__`, such as `__cdecl__` or `__stdcall__`, but got `$(conv)`")
	conv = isnothing(conv) ? conv : Symbol(String(conv)[3:end-2])
	
	(Base.is_expr(func, :call) && length(func.args) >= 1) || error("Expected @cextern to have a function `func(...)` in the function signature, but got `$(func)`")
	func.args[1] isa Symbol || error("Expected @cextern to have a Symbol for a function name, but got `$(func)`")
	name = func.args[1]
	
	argNames = []
	argTypes = map(func.args[2:end]) do arg
		Base.is_expr(arg, :(::), 2) || Base.is_expr(arg, :(...), 1) || error("Expected @cextern to have function arguments specified as `argName::ArgType` or `argName...`, but got `$(arg)`")
		if Base.is_expr(arg, :(::), 2)
			(argName, argType) = arg.args
		else
			(argName, argType) = (arg, :Vararg)
		end
		push!(argNames, argName)
		return argType
	end
	
	sig = (
		retType,
		:($(@__MODULE__).Tuple{$(argTypes...)}),
		(isnothing(conv) ? () : (:($(@__MODULE__).Cconvention{$(QuoteNode(conv))}),))...,
	)
	
	destName = isnothing(destName) ? name : destName
	return esc(quote
		$(@__MODULE__).@eval $(destName)($(argNames...)) = $(Expr(:$, :(
			$(@__MODULE__).DeferredPtr{
				$(@__MODULE__).Cfunction{$(sig...)},
				$(@__MODULE__).Val{$(QuoteNode(name))},
				$(@__MODULE__).Val{$(QuoteNode(Symbol(lib)))}
			}()
		)))($(argNames...))
	end)
end

function _cextern_variable(mod::Module, unused::Nothing, destName::Union{Symbol, Nothing}, varName::Symbol, varType::Union{Symbol, Expr}, lib::String)
	destName = isnothing(destName) ? varName : destName
	return esc(quote
		$(@__MODULE__).@warn "Cannot bind to global variable `$($(name))`, not yet implemented"
	end)
end

