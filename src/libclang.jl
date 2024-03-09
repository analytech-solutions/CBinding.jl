

# deps/libclang-*.jl needs these to be available
libclang_path() = libclang.Clang_jll.libclang_path
libclang_version() = libclang_version(libclang_path())
function libclang_version(path::String)
	dir = joinpath(dirname(dirname(path)), "lib", "clang")
	for entry in readdir(dir)
		m = match(r"^(\d+)(\..+)?$", entry)
		!isnothing(m) && return m.captures[1]
	end
	error("Failed to determine the version of libclang")
end



module libclang
	import Clang_jll
	using ..CBinding
	
	include(joinpath(dirname(@__DIR__), "deps/libclang-$(CBinding.libclang_version(Clang_jll.libclang_path)).jl"))
end

using .libclang



function _string(func, args...)
	cxstr = nothing
	try
		cxstr = func(args...)
		ptr = clang_getCString(cxstr)
		return ptr == C_NULL ? nothing : unsafe_string(ptr)
	finally
		isnothing(cxstr) || clang_disposeString(cxstr)
	end
end

Base.string(cursor::CXType) = _string(clang_getTypeSpelling, cursor)
Base.string(cursor::CXCursor) = _string(clang_getCursorSpelling, cursor)
Base.string(tu::CXTranslationUnit, token::CXToken) = _string(clang_getTokenSpelling, tu, token)


function children(cursor::CXCursor)
	function visitor(c::CXCursor, p::CXCursor, cs::CXClientData)::CXChildVisitResult
		push!(unsafe_pointer_to_objref(cs)::Vector{CXCursor}, c)
		return CXChildVisit_Continue
	end
	
	cursors = CXCursor[]
	Bool(clang_visitChildren(cursor, visitor, pointer_from_objref(cursors))) && error("Failed to visit cursor children")
	return cursors
end


function tokenize(tu::CXTranslationUnit, cursor::CXCursor)
	tokens = Ref{Cptr{CXToken}}(C_NULL)
	count = Ref{Cuint}(0)
	try
		rng = clang_getCursorExtent(cursor)
		cursrange = getlocation(rng)
		
		clang_tokenize(tu, rng, tokens, count)
		
		# tokens are wrong when cursor involves a macro expansion, so filter down to the cursor's lines
		return filter(map(i -> unsafe_load(tokens[], i), 1:count[])) do tok
			rng = clang_getTokenExtent(tu, tok)
			loc = getlocation(rng)
			
			isnothing(loc) && return false
			isnothing(cursrange) && return false
			first(loc).file == first(cursrange).file || return false
			
			return first(loc).line >= first(cursrange).line && last(loc).line <= last(cursrange).line
		end
	finally
		tokens[] == C_NULL || clang_disposeTokens(tu, tokens[], count[])
	end
end


getlocation(cursor::CXCursor) = getlocation(clang_getCursorExtent(cursor))

function getlocation(rng::CXSourceRange)
	Bool(clang_Range_isNull(rng)) && return nothing
	
	start = clang_getRangeStart(rng)
	stop  = clang_getRangeEnd(rng)
	locs = map(getlocation, (start, stop))
	any(isnothing, locs) && return nothing
	
	return locs
end

function getlocation(loc::CXSourceLocation)
	cxfile = Ref{CXFile}(C_NULL)
	line = Ref{Cuint}(0)
	col = Ref{Cuint}(0)
	offset = Ref{Cuint}(0)
	clang_getSpellingLocation(loc, cxfile, line, col, offset)
	
	return cxfile[] == C_NULL ? nothing : CodeLocation(_string(clang_getFileName, cxfile[]), Int(line[]), Int(col[]))
end

