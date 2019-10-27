

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

function _cextern(mod::Module, sig::Expr, libs::Union{Symbol, Expr, Clibrary}...)
	return _cextern(mod, nothing, sig, libs...)
end

function _cextern(mod::Module, conv::Union{Symbol, Nothing}, sig::Expr, libs::Union{Symbol, Expr, Clibrary}...)
	isempty(libs) && error("Usage of @cextern requires at least 1 library to be provided")
	Base.is_expr(sig, :(::), 2) || error("Expected @cextern to have a function signature, `func(arg1::Arg1Type, ..., argN::ArgNType)::ReturnType`, or a global variable, `variable::VarType`, expression, but found `$(sig)`")
	(externName, externType) = sig.args
	return (externName isa Symbol ? _cextern_variable : _cextern_function)(mod, conv, externName, externType, libs...)
end

function _cextern_function(mod::Module, conv::Union{Symbol, Nothing}, func::Expr, retType::Union{Symbol, Expr}, libs::Union{Symbol, Expr, Clibrary}...)
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
	
	libs = map(l -> l isa Clibrary ? l : esc(l), libs)
	sig = (
		retType,
		:(Tuple{$(argTypes...)}),
		(isnothing(conv) ? () : (:(CBinding.Cconvention{$(QuoteNode(conv))}),))...,
	)
	
	# NOTE: about quote block:
	#   1. inner @eval the function type in module scope in case it defines new types
	#   2. outer @eval bind the function pointer and "bake" it into the function
	return quote
		@eval $(name)($(argNames...)) = $(Expr(:$, :(
			(@eval CBinding.Cfunction{$(sig...)})($(QuoteNode(name)), $(libs...))
		)))($(argNames...))
	end
end

function _cextern_variable(mod::Module, unused::Nothing, varName::Symbol, varType::Union{Symbol, Expr}, libs::Union{Symbol, Expr, Clibrary}...)
	libs = map(l -> l isa Clibrary ? l : Expr(:$, esc(l)), libs)
	
	# NOTE: @eval the variable type in module scope in case it defines new types and so it can be const
	return quote
		@eval const $(varName) = CBinding.Cglobal{$(varType)}($(QuoteNode(varName)), $(libs...))
	end
end

