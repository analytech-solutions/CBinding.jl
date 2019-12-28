

function _dlsym(sym::Symbol, libs::Clibrary...)
	for (ind, lib) in enumerate(libs)
		isLast = ind == length(libs)
		handle = Libdl.dlsym(lib.handle, sym, throw_error = isLast)
		isnothing(handle) || return handle
	end
	error("Libdl.dlsym returned a C_NULL handle and did not throw an error")
end



macro cbindings(exprs...) return _cbindings(__module__, exprs...) end

function _cbindings(mod::Module, exprs...)
	length(exprs) >= 1 || error("Expected @cbindings to have (optional) library expressions followed by a block of @cextern statements")
	
	syms = []
	libs = map(enumerate(exprs[1:end-1])) do (ind, expr)
		sym = gensym("lib")
		push!(syms, Expr(:$, sym))
		return quote
			$(sym) = $(esc(expr))
		end
	end
	
	function addlibs(e)
		if Base.is_expr(e, :macrocall) && length(e.args) >= 1 && e.args[1] in _externExprs
			append!(e.args, syms)
		elseif e isa Expr
			for expr in e.args
				addlibs(expr)
			end
		end
	end
	block = Base.is_expr(exprs[end], :block) ? exprs[end] : Expr(:block, exprs[end])
	addlibs(block)
	
	return quote
		let
			$(libs...)
			@eval $(block)
			nothing
		end
	end
end



macro cextern(exprs...) return _cextern(__module__, exprs...) end

function _cextern(mod::Module, expr::Expr, libs::Union{Symbol, Expr, Clibrary}...)
	return _cextern(mod, nothing, expr, libs)
end

function _cextern(mod::Module, conv::Union{Symbol, Nothing}, expr::Expr, libs::Union{NTuple{N, Clibrary}, NTuple{N, Union{Symbol, Expr}}} where {N})
	isempty(libs) && error("Usage of @cextern requires at least 1 library to be provided")
	
	# allow for exposing alternative binding names in Julia with `const exposed = ...`
	destName = nothing
	if Base.is_expr(expr, :const, 1) && Base.is_expr(expr.args[1], :(=), 2) && expr.args[1].args[1] isa Symbol
		destName = expr.args[1].args[1]
		expr = expr.args[1].args[2]
	end
	
	Base.is_expr(expr, :(::), 2) || error("Expected @cextern to have a function signature, `func(arg1::Arg1Type, ..., argN::ArgNType)::ReturnType`, or a global variable, `variable::VarType`, expression, but found `$(sig)`")
	(externName, externType) = expr.args
	return (externName isa Symbol ? _cextern_variable : _cextern_function)(mod, conv, destName, externName, externType, eltype(libs) <: Clibrary ? libs : map(esc, libs))
end

function _cextern_function(mod::Module, conv::Union{Symbol, Nothing}, destName::Union{Symbol, Nothing}, func::Expr, retType::Union{Symbol, Expr}, libs::Union{NTuple{N, Clibrary}, NTuple{N, Expr}} where {N})
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
		:(Tuple{$(argTypes...)}),
		(isnothing(conv) ? () : (:(Cconvention{$(QuoteNode(conv))}),))...,
	)
	
	destName = isnothing(destName) ? name : destName
	
	# NOTE: about quote block:
	#   1. inner @eval the function type in module scope in case it defines new types
	#   2. outer @eval bind the function pointer and "bake" it into the function
	return quote
		@eval $(destName)($(argNames...)) = $(Expr(:$, :(
			(@eval $(@__MODULE__).Cfunction{$(sig...)})($(QuoteNode(name)), $(libs...))
		)))($(argNames...))
	end
end

function _cextern_variable(mod::Module, unused::Nothing, destName::Union{Symbol, Nothing}, varName::Symbol, varType::Union{Symbol, Expr}, libs::Union{NTuple{N, Clibrary}, NTuple{N, Expr}} where {N})
	destName = isnothing(destName) ? varName : destName
	
	# NOTE: @eval the variable type in module scope in case it defines new types and so it can be const
	return quote
		@eval const $(destName) = $(Expr(:$, :(
			(@eval $(@__MODULE__).Cglobal{$(varType)})($(QuoteNode(varName)), $(libs...))
		)))
	end
end

