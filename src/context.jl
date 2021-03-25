

const CONTEXT_CACHE = Dict{Module, Context}()
const FLAGS = CXTranslationUnit_DetailedPreprocessingRecord | CXTranslationUnit_SkipFunctionBodies | CXTranslationUnit_PrecompiledPreamble #| CXTranslationUnit_SingleFileParse
const HEADER = joinpath(@__DIR__, "$(nameof(@__MODULE__)).h")


Base.String(ctx::Context) = String(typeof(ctx))
header(ctx::Context) = header(typeof(ctx))
header(::Type{C}) where {C<:Context}  = HEADER
language(ctx::Context) = language(typeof(ctx))
language(::Type{Context{lang}}) where {lang} = lang


getcontext(mod::Module) = get(CONTEXT_CACHE, mod, nothing)
Base.close(ctx::Context) = delete!(CONTEXT_CACHE, ctx.mod)


getjl(ctx::Context, args...; kwargs...) = getjl(typeof(ctx), args...; annotate = getblock(ctx).flags.annot, kwargs...)
getjl(::Type{C}, str::String; kwargs...) where {C<:Context} = getjl(C, Symbol(str); kwargs...)
getjl(::Type{C}, sym::Symbol; annotate::Bool = false) where {C<:Context} = esc(Symbol(replace(String(sym), r"^(struct|union|enum)\s+" => (annotate ? s"\1_" : ""))))

getname(ctx::Context, args...; kwargs...) = getname(typeof(ctx), args...; kwargs...)
getname(::Type{C}, str::String; kwargs...) where {C<:Context} = getname(C, Symbol(str); kwargs...)
function getname(::Type{C}, sym::Symbol; isbitstype::Bool = false) where {C<:Context}
	sym = Symbol("$(language(C))\"$(sym)\"")
	return isbitstype ? Symbol("($(sym))") : sym
end

gettype(ctx::Context, args...; kwargs...) = gettype(typeof(ctx), args...; kwargs...)
gettype(::Type{C}, str::String; kwargs...) where {C<:Context} = gettype(C, Symbol(str); kwargs...)
gettype(::Type{C}, sym::Symbol; kwargs...) where {C<:Context} = esc(getname(C, sym; kwargs...))



# TODO: prevent new compiler contexts within a module from overwriting libraries of prior contexts
function getlib(ctx::Context)
	dir = get_scratch!(@__MODULE__, string(Scratch.find_uuid(ctx.mod)), ctx.mod)
	file = "libcbinding-$(length(ctx.blocks)).$(dlext)"
	return QuoteNode(Symbol(joinpath(dir, file)))
end

function getlib(ctx::Context, sym)
	for (handle, lib) in ctx.libs
		dlsym(handle, sym, throw_error = false) == C_NULL || return lib isa Symbol ? QuoteNode(lib) : lib
	end
	@warn "Failed to find `$(sym)` in any library: $(join(map(String, filter(x -> x isa Symbol, map(last, collect(ctx.libs)))), ", "))"
	return Nothing
end



function getcode(ctx::Context, cursor::CXCursor)
	policy = clang_getCursorPrintingPolicy(cursor)
	code = _string(clang_getCursorPrettyPrinted, cursor, policy)
	isempty(code) || return code
	
	# if easy way didn't produce anything, we need to do it the messy way
	ismacro = cursor.kind == CXCursor_MacroDefinition
	tokens = tokenize(ctx.tu[], cursor)
	tokens = ismacro ? tokens[2:end] : tokens
	tokens = join(map(token -> clang_getTokenKind(token) == CXToken_Comment ? "" : string(ctx.tu[], token), tokens), ' ')
	tokens = replace(tokens, "{" => "{\n")
	tokens = replace(tokens, " ;" => ";\n")
	tokens = replace(tokens, " }" => "\n}")
	tokens = replace(tokens, " ," => ",")
	tokens = replace(tokens, ": " => ":")
	tokens = replace(tokens, " :" => ":")
	tokens = replace(tokens, "( " => "(")
	tokens = replace(tokens, " )" => ")")
	tokens = replace(tokens, "[ " => "[")
	tokens = replace(tokens, " [" => "[")
	tokens = replace(tokens, " ]" => "]")
	tokens = replace(tokens, " (" => "(")
	tokens = replace(tokens, r"(\w)(\(\*)\s+" => s"\1 \2")
	tokens = replace(tokens, "  " => " ")
	tokens = replace(tokens, r"\n\s+" => "\n")
	
	indents = 0
	code = ""
	isParens = false
	wasComma = false
	wasEOL = false
	for c in tokens
		if c == '}'
			indents -= 1
		elseif c == '{'
			indents += 1
		elseif c == '('
			isParens = true
		elseif c == ')'
			isParens = false
		end
		
		if wasEOL
			code *= repeat("  ", indents)
		end
		if !(!isParens && wasComma)
			code *= c
		end
		
		wasEOL = c == '\n'
		wasComma = c == ','
		if !isParens && wasComma
			code *= '\n'
			wasEOL = true
		end
	end
	code = strip(code)
	
	if ismacro
		code = "#define $(string(cursor)) $(code)"
	end
	
	return code
end



getexprs(ctx::Context) = getexprs(ctx, clang_getTranslationUnitCursor(ctx.tu[]))

function getexprs(ctx::Context, syms, blocks...)
	expr = filter(!isnothing, collect(blocks))
	
	blk = getblock(ctx)
	if blk.flags.jlsyms
		for (sym, jlsym, docs) in syms
			isnothing(jlsym) || push!(expr, :(const $(jlsym) = $(sym)))
		end
	end
	
	if !blk.flags.priv
		push!(expr, :(export $(map(((sym, jlsym, docs),) -> sym, syms)...)))
		blk.flags.jlsyms && push!(expr, :(export $(filter(!isnothing, map(((sym, jlsym, docs),) -> jlsym, syms))...)))
	end
	
	if !blk.flags.nodocs
		for (sym, jlsym, docs) in syms
			isnothing(docs) && continue
			push!(expr, :(@doc $(docs) $(startswith(String(sym.args[1]), '@') ? QuoteNode(sym.args[1]) : sym.args[1])))
			isnothing(jlsym) && continue
			blk.flags.jlsyms && push!(expr, :(@doc $(docs) $(startswith(String(jlsym.args[1]), '@') ? QuoteNode(jlsym.args[1]) : jlsym.args[1])))
		end
	end
	
	push!(expr, first(first(syms)))
	return expr
end



function getexprs_tu(ctx::Context, cursor::CXCursor)
	exprs = []
	
	for child in children(cursor)
		if !getblock(ctx).flags.libc
			range = getlocation(child)
			isnothing(range) && continue  # ignore built-ins and such
			
			first(range).file == header(ctx) || haskey(ctx.hdrs, first(range).file) || continue
			first(range).file != header(ctx) || first(range).line > ctx.line || continue
		end
		
		append!(exprs, filter(!isnothing, getexprs(ctx, child)))
	end
	
	return exprs
end



function getexprs_include(ctx::Context, cursor::CXCursor)
	exprs = []
	
	file = clang_getIncludedFile(cursor)
	file = _string(clang_getFileName, file)
	
	if !isnothing(file) && !haskey(ctx.hdrs, file)
		crng = getlocation(cursor)
		basedir = get(ctx.hdrs, first(crng).file, "")
		isimplicit = !isempty(basedir) && startswith(file, basedir)
		isexplicit = first(crng).file == header(ctx)
		
		if isexplicit || isimplicit || getblock(ctx).flags.libc
			push!(ctx.hdrs, file => isexplicit && getblock(ctx).flags.implic ? "$(dirname(file))/" : basedir)
			push!(exprs, :(include_dependency($(file))))
		end
	end
	
	return exprs
end



getblock(ctx::Context) = isempty(ctx.blocks) ? nothing : last(ctx.blocks)
getblock(ctx::Context, ind::Integer) = ind in eachindex(ctx.blocks) ? ctx.blocks[ind] : nothing
function getblock(ctx::Context, loc::CodeLocation)
	loc.file == header(ctx) || return nothing
	
	ind = searchsortedfirst(ctx.blocks, loc.line, lt = (a::CodeBlock, b::Integer) -> a.lines.stop < b)
	return getblock(ctx, ind)
end



function getlines(ctx::Context, blk::CodeBlock)
	lines = []
	
	io = IOBuffer(ctx.src.data[1:ctx.src.size])
	for (ind, line) in enumerate(eachline(io))
		ind in blk.lines && push!(lines, line)
	end
	
	return lines
end



function Base.pop!(ctx::Context)
	blk = getblock(ctx)
	if !isnothing(blk)
		pop!(ctx.blocks)
		io = IOBuffer(take!(ctx.src))
		ctx.src = IOBuffer()
		for (ind, line) in enumerate(eachline(io))
			ind in blk.lines || println(ctx.src, line)
		end
	end
	
	return ctx
end



# WARNING:  risky hack to trick Julia dlopen into ccalling the C dlopen with NULL (meaning to dlopen current process rather than a library)
struct _NullCString <: AbstractString end
Base.cconvert(::Type{Cstring}, ::_NullCString) = Cstring(C_NULL)


function configure!(ctx::Context)
	# find packaged include
	includedir = joinpath(dirname(dirname(libclang_path())), "lib", "clang")
	for entry in readdir(includedir)
		m = match(r"^(\d+\.\d+\.\d+)$", entry)
		if !isnothing(m)
			includedir = joinpath(includedir, m.captures[1], "include")
			break
		end
	end
	
	pushfirst!(ctx.args,
		"-isystem", includedir,  # these -isystem args are needed since Clang_jll packaging seems to have clang's InstallDir not set/found correctly
		"-isystem", joinpath(dirname(dirname(libclang_path())), "include"),
		# NOTE: in wrap!, ctx.args[5:7] is used separately from ctx.args[8:end] in the compile command
		"-x", lowercase(String(ctx)),
		"-Wno-empty-translation-unit",
	)
	
	libs = []
	libpaths = []
	for ind in eachindex(ctx.args)
		if ctx.args[ind] == "-L"
			if ind < length(ctx.args)
				push!(libpaths, ctx.args[ind+1])
				ctx.args[ind] = ""
				ctx.args[ind+1] = ""
			end
		elseif ctx.args[ind] == "-l"
			if ind < length(ctx.args)
				push!(libs, ctx.args[ind+1])
				ctx.args[ind] = ""
				ctx.args[ind+1] = ""
		end
		elseif startswith(ctx.args[ind], "-L")
			push!(libpaths, ctx.args[ind][3:end])
			ctx.args[ind] = ""
		elseif startswith(ctx.args[ind], "-l")
			push!(libs, ctx.args[ind][3:end])
			ctx.args[ind] = ""
		end
	end
	
	for lib in libs
		l = find_library(lib, libpaths)
		l = isempty(l) ? find_library("lib"*lib, libpaths) : l
		isempty(l) && error("Failed to find library $(lib) in $(join(libpaths, ", "))")
		
		lib = dlopen(l)
		lib == C_NULL && error("Failed to dlopen library $(l)")
		push!(ctx.libs, lib => Symbol(l))
	end
	lib = dlopen(_NullCString())
	lib == C_NULL && error("Failed to dlopen Julia process")
	push!(ctx.libs, lib => Nothing)
	
	ctx.ind = clang_createIndex(false, true)
	ctx.ind == C_NULL && error("Failed to create index")
end



function Base.push!(ctx::Context, loc::LineNumberNode, flags::NamedTuple, str::String)
	str = endswith(str, '\n') ? str : str*'\n'  # ensure new line here so countlines is consistent
	print(ctx.src, str)
	
	blk = getblock(ctx)
	start = isnothing(blk) ? 1 : blk.lines.stop+1
	stop  = start + countlines(IOBuffer(str))-1
	push!(ctx.blocks, CodeBlock(
		loc,
		start:stop,
		flags,
		String[],
	))
end



function parse!(ctx::Context)
	empty!(ctx.hdrs)
	empty!(ctx.macros)
	
	unsaved = [CXUnsavedFile(
		Filename = pointer(header(ctx)),
		Contents = pointer(ctx.src.data),
		Length   = ctx.src.size,
	)]
	
	if ctx.tu[] == C_NULL
		ptrs = map(pointer, ctx.args)
		err = clang_parseTranslationUnit2(ctx.ind, header(ctx), ptrs, length(ptrs), unsaved, length(unsaved), FLAGS, ctx.tu)
	else
		err = clang_reparseTranslationUnit(ctx.tu[], length(unsaved), unsaved, FLAGS)
	end
	err == CXError_Success || error("Failed to parse translation unit $(err)")
	
	
	isfatal = false
	for ind in 1:clang_getNumDiagnostics(ctx.tu[])
		diag = nothing
		try
			diag = clang_getDiagnostic(ctx.tu[], ind-1)
			
			loc = clang_getDiagnosticLocation(diag)
			loc = getlocation(loc)
			isnothing(loc) && continue
			(loc.file == header(ctx) && loc.line > ctx.line) || continue
			
			blk = getblock(ctx, loc)
			isquiet = !isnothing(blk) && blk.flags.quiet
			if !isquiet
				msg = string(diag)
				msg = replace(msg, (header(ctx)*r"(?:\:\d+)*") => (!isnothing(blk) ? "$(blk.loc.file):$(blk.loc.line)" : @__FILE__))
				
				if !isnothing(blk)
					lines = getlines(ctx, blk)
					line = (loc.line - blk.lines.start)+1
					
					pre = length(lines[line]) - length(lstrip(lines[line]))
					here = lines[line][1:pre]*repeat(" ", loc.column-pre-1)*"^~~~~~ here"
					insert!(lines, line+1, here)
					
					msg *= "\n"*join(lines[max(1, line-2):min(length(lines), line+3)], '\n')
				end
			end
			
			sev = clang_getDiagnosticSeverity(diag)
			if sev in (CXDiagnostic_Error, CXDiagnostic_Fatal)
				isfatal = true
				isquiet || @error msg  (_module = !isnothing(blk) ? ctx.mod : @__MODULE__)  (_file = !isnothing(blk) ? String(blk.loc.file) : @__FILE__)  (_line = !isnothing(blk) ? blk.loc.line : @__LINE__)
			elseif sev == CXDiagnostic_Warning
				isquiet || @warn  msg  (_module = !isnothing(blk) ? ctx.mod : @__MODULE__)  (_file = !isnothing(blk) ? String(blk.loc.file) : @__FILE__)  (_line = !isnothing(blk) ? blk.loc.line : @__LINE__)
			else
				isquiet || @debug msg  (_module = !isnothing(blk) ? ctx.mod : @__MODULE__)  (_file = !isnothing(blk) ? String(blk.loc.file) : @__FILE__)  (_line = !isnothing(blk) ? blk.loc.line : @__LINE__)
			end
		finally
			clang_disposeDiagnostic(diag)
		end
	end
	
	isfatal && error("Errors parsing $(String(ctx)) code")
end



function wrap!(ctx::Context)
	getblock(ctx).flags.wrap || return
	isempty(getblock(ctx).inlines) && return
	
	mktemp() do path, file
		blk = 1
		io = IOBuffer(ctx.src.data[1:ctx.src.size])
		for (ind, line) in enumerate(eachline(io))
			println(file, line)
			if ind == ctx.blocks[blk].lines.stop
				foreach(inline ->  println(file, inline), ctx.blocks[blk].inlines)
				blk += 1
			end
		end
		close(file)
		
		libclang.Clang_jll.clang() do bin
			run(`$(bin) $(ctx.args[5:7]) -w -O2 -fPIC -shared -o $(getlib(ctx).value) $(path) $(ctx.args[8:end])`)  # TODO: add -rpath for all ctx.libs?
		end
	end
end



function advance!(ctx::Context)
	getblock(ctx).flags.defer && return
	
	stop = ctx.line
	root = clang_getTranslationUnitCursor(ctx.tu[])
	for cursor in children(root)
		range = getlocation(cursor)
		isnothing(range) && continue
		
		first(range).file == header(ctx) || continue
		if first(range).line > ctx.line && last(range).line > stop
			stop = last(range).line
		end
	end
	ctx.line = stop
end



function clang_cmd(mod::Module, loc::LineNumberNode, lang::Symbol, str::String)
	cmd = :(``)
	cmd.args[2] = loc
	cmd.args[3] = str
	
	return quote
		CONTEXT_CACHE[$(mod)] = Context{$(QuoteNode(lang))}($(mod), $(esc(cmd)).exec...)
		nothing
	end
end



function clang_str(mod::Module, loc::LineNumberNode, lang::Symbol, str::String, opts::String = "")
	# TODO: allow interpolation in str?
	
	flags = (;
		libc    = 'c' in opts,
		defer   = 'd' in opts,
		nofunc  = 'f' in opts,
		implic  = 'i' in opts,
		jlsyms  = 'J' in opts || 'j' in opts,
		annot   = 'J' in opts,
		nomacro = 'm' in opts,
		notify  = 'n' in opts,
		priv    = 'p' in opts,
		quiet   = 'q' in opts,
		ref     = 'r' in opts,
		skip    = 's' in opts,
		notype  = 't' in opts,
		nodocs  = 'u' in opts,
		novar   = 'v' in opts,
		wrap    = 'w' in opts,
	)
	
	ref = getref(Context{lang}, str)
	isnothing(ref) || return ref
	flags.ref && error("Failed to parse $(String(Context{lang})) expression $(language(Context{lang}))$(repr(str))")
	
	haskey(CONTEXT_CACHE, mod) || error("Compiler context ($(language(Context{lang}))`...`) not created before declaring $(String(Context{lang})) bindings ($(language(Context{lang}))\"...\") in $(mod)")
	ctx = CONTEXT_CACHE[mod]
	
	exprs = []
	try
		push!(ctx, loc, flags, str)
		parse!(ctx)
		exprs = getexprs(ctx)
		wrap!(ctx)
		advance!(ctx)
	catch
		pop!(ctx)
		rethrow()
	end
	
	return quote
		$(exprs...)
	end
end


