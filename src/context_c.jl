

macro c_cmd(exprs...) return clang_cmd(__module__, __source__, :c, exprs...) end
macro c_str(exprs...) return clang_str(__module__, __source__, :c, exprs...) end


const C_HEADER = joinpath(@__DIR__, "$(nameof(@__MODULE__)).h")
header(::Type{Context{:c}}) = C_HEADER
Base.String(::Type{Context{:c}}) = "C"


const C_PRIMS   = ("void", "bool", "char", "short", "int", "long", "float", "double", "signed", "unsigned", "_Bool", "_Complex", "const", "restrict", "volatile")
const C_PRIM    = Regex(raw"^\s*((?:"*join(C_PRIMS, '|')*raw")(?:\s+(?:"*join(C_PRIMS, '|')*raw"))*)\s*$")
const C_USER    = r"^\s*(?:(const|restrict|volatile)\s+)?(?:(struct|union|enum)\s+)?(\w+)(?:\s+(const|restrict|volatile))?\s*$"
const C_POINTER = r"^(.+)\s*\*(?:\s*(const|restrict|volatile))?\s*$"
const C_ARRAY   = r"^(.+)\s*\[(\d+)\]\s*$"
const C_TYPES   = raw"\w+(?:(?:[*\s]+)\w+)*(?:[*\s]+)?"
const C_MODULE  = r"\s*(\w+)\.(.*)$"
const C_TYPEVAR = Regex(raw"^\s*("*C_TYPES*raw")\s*$")
const C_FUNCPTR = Regex(raw"^\s*("*C_TYPES*raw")\s*\(\*\)\(([^)]*)\)(const)?(?:\s+__attribute__\(\(([^)]+)\)\))?\s*$")
function getref(ctx::Type{Context{:c}}, str::AbstractString, mod::Union{Expr, Nothing} = nothing)
	function decorate(t, set)
		t = "volatile" in set ? :(Cvolatile{$(t)}) : t
		t = "restrict" in set ? :(Crestrict{$(t)}) : t
		t = "const"    in set ?    :(Cconst{$(t)}) : t
		return t
	end
	
	function sign(t, set)
		t =   "signed" in set ?   :(signed($(t))) : t
		t = "unsigned" in set ? :(unsigned($(t))) : t
		return t
	end
	
	function array(t, szs = [])
		m = match(C_ARRAY, t)
		if !isnothing(m)
			push!(szs, parse(Int, m.captures[2]))
			return array(m.captures[1], szs)
		end
		
		isempty(szs) && return nothing
		
		inner = getref(ctx, t, mod)
		isnothing(inner) && return nothing
		
		for sz in szs
			inner = decorate(:(Carray{$(inner), $(sz)}), ())
		end
		return inner
	end
	
	
	arr = array(str)
	isnothing(arr) || return arr
	
	m = match(C_POINTER, str)
	if !isnothing(m)
		inner = getref(ctx, m.captures[1], mod)
		isnothing(inner) || return decorate(:(Cptr{$(inner)}), (m.captures[2],))
	end
	
	m = match(C_FUNCPTR, str)
	if !isnothing(m)
		rettype  = getref(ctx, m.captures[1], mod)
		argtypes = isempty(m.captures[2]) ? () : map(arg -> getref(ctx, arg, mod), split(m.captures[2], ','))
		decor    = (m.captures[3],)
		conv     = isnothing(m.captures[4]) ? () : (QuoteNode(Symbol(m.captures[4])),)
		
		isnothing(rettype) || any(isnothing, argtypes) || return decorate(:(Cptr{Cfunction{$(rettype), Tuple{$(argtypes...)}, $(conv...)}}), decor)
	end
	
	m = match(C_PRIM, str)
	if !isnothing(m)
		prims = split(m.captures[1])
		
		if "_Complex" in prims
			if "double" in prims
				if "long" in prims
					return decorate(:(Ccomplex{Cdouble}), prims)
				else
					return decorate(:(Ccomplex{Clongdouble}), prims)
				end
			elseif "float" in prims
				return decorate(:(Ccomplex{Cfloat}), prims)
			end
		elseif "double" in prims
			if "long" in prims
				return decorate(:(Cdouble), prims)
			else
				return decorate(:(Clongdouble), prims)
			end
		elseif "float" in prims
			return decorate(:(Cfloat), prims)
		elseif "void" in prims
			return decorate(:(Cvoid), prims)
		elseif "bool" in prims || "_Bool" in prims
			return decorate(:(Cbool), prims)
		elseif "char" in prims
			return decorate(sign(:(Cchar), prims), prims)
		elseif "short" in prims
			return decorate(sign(:(Cshort), prims), prims)
		elseif "int" in prims
			return decorate(sign(:(Cint), prims), prims)
		elseif "long" in prims
			if count(isequal("long"), prims) > 1
				return decorate(sign(:(Clonglong), prims), prims)
			else
				return decorate(sign(:(Clong), prims), prims)
			end
		elseif "signed" in prims
			return decorate(:(signed(Cint)), prims)
		elseif "unsigned" in prims
			return decorate(:(unsigned(Cint)), prims)
		end
	end
	
	m = match(C_USER, str)
	if !isnothing(m)
		decor = (m.captures[1], m.captures[4])
		inner = getname(ctx, isnothing(m.captures[2]) ? "$(m.captures[3])" : "$(m.captures[2]) $(m.captures[3])")
		isnothing(inner) || return decorate(isnothing(mod) ? esc(inner) : :($(mod).$(inner)), decor)
	end
	
	strip(str) == "..." && return :(Cvariadic)
	
	m = match(C_MODULE, str)
	if !isnothing(m)
		str = m.captures[2]
		m   = Symbol(m.captures[1])
		return getref(ctx, str, isnothing(mod) ? esc(m) : :($(mod).$(m)))
	end
	
	return nothing
end



function gettype(ctx::Type{Context{:c}}, type::CXType; kwargs...)
	if type.kind == CXType_Void
		result = :(Cvoid)
	elseif type.kind == CXType_Bool
		result = :(Cbool)
	elseif type.kind == CXType_Char_S
		result = :(Cchar)
	elseif type.kind == CXType_Char_U
		result = :(Cuchar)
	elseif type.kind == CXType_SChar
		result = :(Cchar)
	elseif type.kind == CXType_UChar
		result = :(Cuchar)
	elseif type.kind == CXType_Short
		result = :(Cshort)
	elseif type.kind == CXType_Int
		result = :(Cint)
	elseif type.kind == CXType_Long
		result = :(Clong)
	elseif type.kind == CXType_LongLong
		result = :(Clonglong)
	elseif type.kind == CXType_UShort
		result = :(Cushort)
	elseif type.kind == CXType_UInt
		result = :(Cuint)
	elseif type.kind == CXType_ULong
		result = :(Culong)
	elseif type.kind == CXType_ULongLong
		result = :(Culonglong)
	elseif type.kind == CXType_Float
		result = :(Cfloat)
	elseif type.kind == CXType_Double
		result = :(Cdouble)
	elseif type.kind == CXType_LongDouble
		result = :(Clongdouble)
	elseif type.kind in (
		CXType_Typedef,
		CXType_Record,
		CXType_Elaborated,
		CXType_Enum,
	)
		decl = clang_getTypeDeclaration(type)
		t = clang_getCursorType(decl)
		result = gettype(ctx, string(t); kwargs...)
	elseif type.kind == CXType_Complex
		cplxtype = clang_getElementType(type)
		cplxtype = gettype(ctx, cplxtype; kwargs...)
		result = :(Ccomplex{$(cplxtype)})
	elseif type.kind == CXType_Pointer
		ptrtype = clang_getPointeeType(type)
		ptrtype = gettype(ctx, ptrtype; kwargs...)
		result = :(Cptr{$(ptrtype)})
	elseif type.kind == CXType_ConstantArray
		num = clang_getNumElements(type)
		arrtype = clang_getElementType(type)
		arrtype = gettype(ctx, arrtype; kwargs...)
		result = :(Carray{$(arrtype), $(num)})
	elseif type.kind == CXType_IncompleteArray
		arrtype = clang_getElementType(type)
		arrtype = gettype(ctx, arrtype; kwargs...)
		result = :(Carray{$(arrtype), 0})
	elseif type.kind in (
		CXType_FunctionProto,
		CXType_FunctionNoProto,
	)
		rettype = clang_getResultType(type)
		rettype = gettype(ctx, rettype; kwargs...)
		
		num = clang_getNumArgTypes(type)
		argtypes = map(1:num) do ind
			argtype = clang_getArgType(type, ind-1)
			return gettype(ctx, argtype; kwargs...)
		end
		argtypes = Bool(clang_isFunctionTypeVariadic(type)) ? [argtypes..., Cvariadic] : argtypes
		
		conv = clang_getFunctionTypeCallingConv(type)
		if conv == CXCallingConv_C
			conv = :(cdecl)
		else
			error("Unhandled calling convention $(conv)")
		end
		
		result = :(Cfunction{$(rettype), Tuple{$(argtypes...)}, $(QuoteNode(conv))})
	else
		error("Unhandle type $(type.kind)")
	end
	
	if Bool(clang_isVolatileQualifiedType(type))
		# TODO: not handled in get/set property etc. yet
		# result = :(Cvolatile{$(result)})
	end
	
	if Bool(clang_isRestrictQualifiedType(type))
		# TODO: not handled in get/set property etc. yet
		# result = :(Crestrict{$(result)})
	end
	
	# NOTE: always want Cconst around everything else to make life easier in get/set
	if Bool(clang_isConstQualifiedType(type))
		result = :(Cconst{$(result)})
	end
	
	return result
end



function getexprs(ctx::Context{:c}, cursor::CXCursor)
	exprs = []
	
	getblock(ctx).flags.skip && return exprs
	getblock(ctx).flags.defer && return exprs
	
	if cursor.kind == CXCursor_TranslationUnit
		append!(exprs, getexprs_tu(ctx, cursor))
	elseif cursor.kind == CXCursor_TypedefDecl
		push!(exprs, getexprs_typedef(ctx, cursor))
	elseif cursor.kind in (
		CXCursor_StructDecl,
		CXCursor_UnionDecl,
		CXCursor_EnumDecl,
	)
		for child in children(cursor)
			if child.kind in (
				CXCursor_StructDecl,
				CXCursor_UnionDecl,
				CXCursor_EnumDecl,
				CXCursor_TypedefDecl,
			)
				append!(exprs, getexprs(ctx, child))
			end
		end
		
		append!(exprs, getexprs_opaque(ctx, cursor))
	elseif cursor.kind in (
		CXCursor_VarDecl,
		CXCursor_FunctionDecl,
	)
		for child in children(cursor)
			if child.kind in (
				CXCursor_StructDecl,
				CXCursor_UnionDecl,
				CXCursor_EnumDecl,
				CXCursor_TypedefDecl,
				CXCursor_ParmDecl,
			)
				append!(exprs, getexprs(ctx, child))
			end
		end
		
		append!(exprs, getexprs_binding(ctx, cursor))
	elseif cursor.kind == CXCursor_ParmDecl
		for child in children(cursor)
			if child.kind in (
				CXCursor_StructDecl,
				CXCursor_UnionDecl,
				CXCursor_EnumDecl,
				CXCursor_TypedefDecl,
			)
				append!(exprs, getexprs(ctx, child))
			end
		end
	elseif cursor.kind == CXCursor_InclusionDirective
		append!(exprs, getexprs_include(ctx, cursor))
	elseif !(cursor.kind in (
		CXCursor_FieldDecl,
		CXCursor_EnumConstantDecl,
		CXCursor_ParmDecl,
		CXCursor_MacroDefinition,  # TODO: support this
		CXCursor_MacroInstantiation,  # TODO: support this
	))
		@warn "Not implemented $(cursor.kind):  $(string(cursor))"
	end
	
	return exprs
end



function getexprs_typedef(ctx::Context{:c}, cursor::CXCursor)
	getblock(ctx).flags.notype && return quote end
	
	name  = gettype(ctx, string(cursor))
	jlsym = getjl(ctx, string(cursor))
	docs  = getdocs(ctx, cursor)
	
	type = clang_getTypedefDeclUnderlyingType(cursor)
	if type.kind == CXType_Elaborated
		# get from elaborated to actual record definition
		decl = clang_getTypeDeclaration(type)
		type = clang_getCursorType(decl)
		docs = jlsym == getjl(ctx, string(decl)) ? nothing : docs  # avoid "replacing docs" warnings when julia-ized names are the same if struct/union/enum was stripped
	end
	tname = gettype(ctx, type)
	
	# nested anonymous opaque type had this typedef's name propagated to it so no expr needed
	return tname == name ? quote end : getexprs(ctx, ((name, jlsym, docs),), quote
		const $(name) = $(tname)
	end)
end



function getexprs_opaque(ctx::Context{:c}, cursor::CXCursor)
	exprs = []
	
	getblock(ctx).flags.notype && return exprs
	
	type = clang_getCursorType(cursor)
	decl = clang_getTypeDeclaration(type)
	
	size = clang_Type_getSizeOf(type)
	isdecl = Bool(clang_isCursorDefinition(cursor))
	isanon = Bool(clang_Cursor_isAnonymous(cursor))
	
	kind =
		cursor.kind == CXCursor_EnumDecl ? Cenum :
		cursor.kind == CXCursor_StructDecl ? Cstruct : Cunion
	(name, absname) = isanon ?
		(gettype(ctx, type), kind) :
		(gettype(ctx, type, isbitstype = true), gettype(ctx, type))
	(jlsym, jlabssym) = isanon ?
		(getjl(ctx, string(type)), nothing) :
		(nothing, getjl(ctx, string(type)))
	
	def = clang_getCursorDefinition(cursor)
	loc = getlocation(def)
	if !isanon && (isnothing(loc) || (first(loc).file == header(ctx) || haskey(ctx.hdrs, first(loc).file)))
		push!(exprs, getexprs(ctx, ((absname, jlabssym, nothing),), quote
			abstract type $(absname) <: $(kind) end
		end))
	end
	
	if isdecl
		docs = getdocs(ctx, cursor)
		common = quote
			CBinding.bitstype(::Type{$(name)}) = $(name)
			$(!isanon ? :(CBinding.bitstype(::Type{$(absname)}) = $(name)) : :())
		end
		
		if cursor.kind == CXCursor_EnumDecl
			push!(exprs, getexprs_enum(ctx, cursor, name, absname, jlsym, jlabssym, docs, common))
		else
			push!(exprs, getexprs_aggregate(ctx, cursor, name, absname, jlsym, jlabssym, docs, common))
		end
	end
	
	return exprs
end


function getexprs_enum(ctx::Context{:c}, cursor::CXCursor, name, absname, jlsym, jlabssym, docs, common)
	type = clang_getCursorType(cursor)
	size = clang_Type_getSizeOf(type)
	inttype = clang_getEnumDeclIntegerType(cursor)
	itype = gettype(ctx, inttype)
	
	values = map(filter(child -> child.kind == CXCursor_EnumConstantDecl, children(cursor))) do val
		j = Symbol(string(val))
		v = inttype.kind in (
			CXType_UChar,
			CXType_Char_U,
			CXType_UShort,
			CXType_UInt,
			CXType_ULong,
			CXType_ULongLong,
		) ? clang_getEnumConstantDeclUnsignedValue(val) : clang_getEnumConstantDeclValue(val)
		d = getdocs(ctx, val)
		
		return (j, v, d)
	end
	
	return getexprs(ctx, (
		(!isnothing(jlabssym) ? ((absname, jlabssym, docs),) : ())...,
		(name, jlsym, docs),
		map(((j, v, d),) -> (esc(getname(ctx, j)), esc(j), d), values)...,
	), quote
		primitive type $(name) <: $(absname) $(size*8) end
		(::$(Type){$(name)})($(esc(:val))::Integer = zero($(itype))) = Core.Intrinsics.bitcast($(name), convert($(itype), $(esc(:val))))
		
		# values = Tuple{
		# 	Tuple{:name, value},  # name and literal value
		# }
		CBinding.values(::Type{$(name)}) = Tuple{$(map(((j, v, d),) -> :(Tuple{$(QuoteNode(getname(ctx, j))), $(v)}), values)...)}
		Base.Enums.basetype(::Type{$(name)}) = $(itype)
	end, common, map(((j, v, d),) -> quote
		const $(esc(getname(ctx, j))) = $(name)($(v))
	end, values)...)
end


function getexprs_aggregate(ctx::Context{:c}, cursor::CXCursor, name, absname, jlsym, jlabssym, docs, common)
	type = clang_getCursorType(cursor)
	size = clang_Type_getSizeOf(type)
	
	# children are ordered with type defined before the field using it, so we iterate in reverse to add the field first and then not add the type's fields in that case
	fields = []
	lastField = nothing
	function getfields(kids)
		for c in reverse(eachindex(kids))
			child = kids[c]
			if child.kind == CXCursor_FieldDecl
				t = clang_getCursorType(child)
				d = clang_getTypeDeclaration(t)
				
				if t.kind in (
					CXType_Void, CXType_Bool,
					CXType_Char_S, CXType_Char_U,
					CXType_SChar, CXType_UChar,
					CXType_Short, CXType_UShort,
					CXType_Int, CXType_UInt,
					CXType_Long, CXType_ULong,
					CXType_LongLong, CXType_ULongLong,
					CXType_Float, CXType_Double, CXType_LongDouble,
					CXType_Complex,
				)
					lastField = nothing
				elseif t.kind in (
					CXType_Typedef,
					CXType_Elaborated,
				)
					lastField = clang_getTypeDeclaration(clang_getCursorType(clang_getTypeDeclaration(t)))
				elseif t.kind in (
					CXType_ConstantArray,
					CXType_IncompleteArray,
				)
					lastField = clang_getTypeDeclaration(clang_getElementType(t))
				elseif t.kind == CXType_Pointer
					lastField = clang_getTypeDeclaration(clang_getPointeeType(t))
				else
					error("Unhandled field nested type $(t.kind)")
				end
				
				n = string(child)
				isempty(n) && continue
				
				b = -1
				o = clang_Type_getOffsetOf(type, n)
				if Bool(clang_Cursor_isBitField(child))
					b = clang_getFieldDeclBitWidth(child)
					b > 0 || continue
				end
				
				t = gettype(ctx, t)
				push!(fields, :(Tuple{$(QuoteNode(Symbol(n))), Tuple{$(t), bitstype($(t)), integraltype($(t)), $(o÷8), $(o & 0b111), $(b)}}))
			elseif child.kind in (
				CXCursor_StructDecl,
				CXCursor_UnionDecl,
			)
				if Bool(clang_Cursor_isAnonymous(child))
					if isnothing(lastField) || !Bool(clang_equalCursors(lastField, child))
						getfields(children(child))
					end
				end
			end
		end
	end
	getfields(children(cursor))
	reverse!(fields)
	
	return getexprs(ctx, (
		(!isnothing(jlabssym) ? ((absname, jlabssym, docs),) : ())...,
		(name, jlsym, docs),
	), quote
		struct $(name) <: $(absname)
			mem::NTuple{$(size), UInt8}
			
			$(name)(::UndefInitializer, $(esc(:mem))::NTuple{$(size), UInt8}) = new($(esc(:mem)))
		end
		
		# fields = Tuple{
		# 	# a field's name, type, type with const/volatile/restrict removed, integral equivalent, bytes+bits offset, and bitfield size (-1 for non-bitfield)
		# 	Tuple{:name, Tuple{FieldType, UnqualifiedFieldType, IntegerType, bytes, bits, size}},
		# }
		CBinding.fields(::Type{$(name)}) = Tuple{$(fields...)}
	end, common)
end



function getexprs_binding(ctx::Context{:c}, cursor::CXCursor)
	exprs = []
	
	getblock(ctx).flags.nofunc && cursor.kind == CXCursor_FunctionDecl && return exprs
	getblock(ctx).flags.novar && cursor.kind == CXCursor_VarDecl && return exprs
	
	exposed = clang_Cursor_getStorageClass(cursor)
	visible = clang_getCursorVisibility(cursor)
	linkage = clang_getCursorLinkage(cursor)
	isinlined = cursor.kind == CXCursor_FunctionDecl && Bool(clang_Cursor_isFunctionInlined(cursor))
	if visible in (
		CXVisibility_Default,
		CXVisibility_Protected,
	) && (
		isinlined || (
			exposed in (
				CX_SC_None,
				CX_SC_Extern,
			) && linkage in (
				CXLinkage_External,
			)
		)
	)
		name = string(cursor)
		lib = getlib(ctx, name)
		jlsym = getjl(ctx, name)
		sym = gettype(ctx, name)
		docs = getdocs(ctx, cursor)
		
		type = clang_getCursorType(cursor)
		if cursor.kind == CXCursor_VarDecl
			cb = :(Cbinding{$(gettype(ctx, type)), $(QuoteNode(Symbol(lib))), $(QuoteNode(Symbol(name)))})
			push!(exprs, getexprs(ctx, ((sym, jlsym, docs),), quote
				const $(sym) = $(cb)()
			end))
		else
			if isinlined
				if !getblock(ctx).flags.wrap
					getblock(ctx).flags.quiet || @warn "Skipping inline function `$(name)`"
					return exprs
				end
				
				unname = "cbinding__$(name)"
				code = getcode(ctx, cursor)
				code = replace(code, r"(^|\s)inline\s" => s"\1")
				code = replace(code, r"(^|\s)static\s" => s"\1")
				code = replace(code, r"(^|\s)extern\s" => s"\1")
				code = replace(code, " $(name)(" => " $(unname)(")
				code = "$(lstrip(code)) __attribute__((alias($(repr(name)))));"
				push!(getblock(ctx).inlines, code)
				
				name = unname
				lib  = getlib(ctx)
				push!(exprs, quote
					include_dependency($(String(lib.value)))
				end)
			end
			
			rettype = clang_getResultType(type)
			
			num = clang_Cursor_getNumArguments(cursor)
			args = map(1:num) do ind
				arg = clang_Cursor_getArgument(cursor, ind-1)
				
				argname = string(arg)
				argname = isempty(argname) ? getjl(ctx, "arg$(ind)") : gettype(ctx, argname)
				argtype = clang_getCursorType(arg)
				
				return argname => gettype(ctx, argtype)
			end
			args = Bool(clang_Cursor_isVariadic(cursor)) ? [args..., :($(getjl(ctx, :vararg))...) => :(Cvariadic)] : args
			
			conv = clang_getFunctionTypeCallingConv(type)
			if conv == CXCallingConv_C
				conv = :(cdecl)
			else
				error("Unhandled calling convention $(conv)")
			end
			
			func = getjl(ctx, :func)
			cb = :(Cbinding{Cfunction{$(gettype(ctx, rettype)), Tuple{$(map(last, args)...)}, $(QuoteNode(conv))}, $(lib), $(QuoteNode(Symbol(name)))})
			push!(exprs, getexprs(ctx, ((sym, jlsym, docs),), quote
				const $(sym) = $(cb)()
				($(func)::typeof($(sym)))($(map(first, args)...),) = funccall($(func), $(map(first, args)...),)
			end))
		end
	end
	
	return exprs
end

