

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
		sym = Symbol("lib_", ind)
		push!(syms, Expr(:$, sym))
		return :($(sym) = $(esc(expr)))
	end
	
	block = Base.is_expr(exprs[end], :block) ? exprs[end] : Expr(:block, exprs[end])
	for expr in block.args
		if Base.is_expr(expr, :macrocall) && length(expr.args) > 1 && expr.args[1] in _externExprs
			append!(expr.args, syms)
		end
	end
	
	return quote
		$(libs...)
		$(block)
		nothing
	end
end



macro cextern(exprs...) return _cextern(__module__, nothing, exprs...) end

function _cextern(mod::Module, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing}, sig::Expr, libs::Union{Symbol, Expr}...)
	return _cextern(mod, deps, nothing, sig, libs...)
end

function _cextern(mod::Module, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing}, conv::Union{Symbol, Nothing}, sig::Expr, libs::Union{Symbol, Expr}...)
	Base.is_expr(sig, :(::), 2) || error("Expected @cextern to have a function signature, `func(arg1::Arg1Type, ..., argN::ArgNType)::ReturnType`, or a global variable, `variable::VarType`, expression, but found `$(sig)`")
	(externName, externType) = sig.args
	return (externName isa Symbol ? _cextern_variable : _cextern_function)(mod, deps, conv, externName, externType, libs...)
end

function _cextern_function(mod::Module, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing}, conv::Union{Symbol, Nothing}, func::Expr, retType::Union{Symbol, Expr}, libs::Union{Symbol, Expr}...)
	isnothing(deps) || error("Usage of @cextern cannot be nested")
	deps = Pair{Symbol, Expr}[]
	
	isnothing(conv) || (startswith(String(conv), "__") && endswith(String(conv), "__") && length(String(conv)) > 4) || error("Expected @cextern to have a calling convention specified as `__CONVENTION__`, such as `__cdecl__` or `__stdcall__`, but got `$(conv)`")
	
	(Base.is_expr(func, :call) && length(func.args) > 1) || error("Expected @cextern to have a function `func(...)` in the function signature, but got `$(func)`")
	func.args[1] isa Symbol || error("Expected @cextern to have a Symbol for a function name, but got `$(func)`")
	name = func.args[1]
	
	argNames = []
	args = map(func.args[2:end]) do arg
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
		:(Tuple{$(args...)}),
		(isnothing(conv) ? () : (:(CBinding.Cconvention{$(QuoteNode(Symbol(String(conv)[3:end-2])))}),))...,
	)
	func = :(CBinding.Cfunction{$(sig...)}($(QuoteNode(name)), $(libs...)))
	
	return quote
		@eval begin
			$(map(last, deps)...)
			$(name)($(argNames...)) = $(Expr(:$, func))($(argNames...))
		end
	end
end

function _cextern_variable(mod::Module, deps::Union{Vector{Pair{Symbol, Expr}}, Nothing}, unused::Nothing, varName::Symbol, varType::Union{Symbol, Expr}, libs::Union{Symbol, Expr}...)
	isnothing(deps) || error("Usage of @cextern cannot be nested")
	deps = Pair{Symbol, Expr}[]
	
	var = :(CBinding.Cglobal{$(varType)}($(QuoteNode(varName)), $(libs...)))
	
	return quote
		@eval begin
			$(map(last, deps)...)
			const $(varName) = $(var)
		end
	end
end

