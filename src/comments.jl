

function getdocs(ctx::Context, cursor::CXCursor)
	getblock(ctx).flags.nodocs && return nothing
	
	comment = clang_Cursor_getParsedComment(cursor)
	kind = clang_Comment_getKind(comment)
	if kind == CXComment_FullComment
		return Markdown.MD(ctx, cursor, comment)
	elseif kind == CXComment_Null
		return Markdown.MD(ctx, cursor)
	else
		@warn "Expected a full comment, but got $(kind)"
		return nothing
	end
end



function Markdown.MD(ctx::Context, cursor::CXCursor)
	code = getcode(ctx, cursor)
	code = Markdown.Code(String(language(ctx)), code)
	
	loc = getlocation(cursor)
	if isnothing(loc)
		loc = "Defined by the parser/compiler"
	else
		loc = first(loc)
		loc = loc.file == header(ctx) ? getblock(ctx, loc).loc : loc
		loc = Markdown.Link("Defined at $(basename(String(loc.file))):$(loc.line)", "file://$(loc.file)")
	end
	
	return Markdown.MD(code, Markdown.Paragraph(loc))
end



function Markdown.MD(ctx::Context, cursor::CXCursor, comment::CXComment)
	hasDetails = false
	hasParams  = false
	hasReturns = false
	
	contents = []
	for ind in 1:clang_Comment_getNumChildren(comment)
		child = clang_Comment_getChild(comment, ind-1)
		kind = clang_Comment_getKind(child)
		
		if !hasDetails && !isempty(contents)
			hasDetails = true
			push!(contents, Markdown.Header("Details", 2))
		end
		
		if kind == CXComment_Paragraph
			Bool(clang_Comment_isWhitespace(child)) || push!(contents, Markdown.Paragraph(ctx, child))
		elseif kind == CXComment_BlockCommand
			para = clang_BlockCommandComment_getParagraph(child)
			para = Markdown.Paragraph(ctx, para)
			
			num = clang_BlockCommandComment_getNumArgs(child)
			cmd = _string(clang_BlockCommandComment_getCommandName, child)
			if cmd == "brief" || cmd == "par" || cmd == "paragraph"
				push!(contents, para)
			elseif cmd == "bug" || cmd == "note" || cmd == "warning" || cmd == "deprecated" || cmd == "attention"
				category =
					cmd == "bug" ? "danger" :
					cmd == "note" ? "info" :
					cmd == "warning" ? "warning" :
					cmd == "deprecated" ? "warning" :
					cmd == "attention" ? "danger" : "info"
				para = Markdown.Admonition("danger", titlecase(cmd), [para])
				push!(contents, para)
			elseif cmd == "sa" || cmd == "see"
				para = isempty(para.content) ? para : Markdown.Paragraph("See also: [`$(strip(first(para.content)))`](@ref)")
				push!(contents, para)
			elseif cmd == "returns" || cmd == "return"
				if !hasReturns
					hasReturns = true
					
					hdr = Markdown.Header("Returns", 2)
					if !isempty(contents) && contents[end] isa Markdown.Header
						contents[end] = hdr
					else
						push!(contents, hdr)
					end
				end
				
				push!(contents, para)
			elseif cmd == "li"
				if !isempty(contents) && contents[end] isa Markdown.List
					push!(contents[end].items, para)
				else
					push!(contents, Markdown.List(para))
				end
			else
				getblock(ctx).flags.notify && @warn "Unhandled comment block-command: $(cmd)"
			end
		elseif kind == CXComment_ParamCommand
			if !hasParams
				hasParams = true
				
				hdr = Markdown.Header("Parameters", 2)
				if !isempty(contents) && contents[end] isa Markdown.Header
					contents[end] = hdr
				else
					push!(contents, hdr)
				end
			end
			
			addParameter(ctx, contents, child)
		elseif kind == CXComment_VerbatimBlockCommand
			push!(contents, Markdown.Code(ctx, child))
		elseif kind == CXComment_VerbatimLine
			text = _string(clang_VerbatimLineComment_getText, child)
			push!(contents, Markdown.Paragraph(text))
		else
			getblock(ctx).flags.notify && @warn "Unhandled comment document child: $(kind)"
		end
	end
	
	if length(contents) > 1 && contents[end] isa Markdown.Header
		contents = contents[1:end-1]
	end
	
	return Markdown.MD([Markdown.MD(ctx, cursor).content..., contents...])
end


function Markdown.Paragraph(ctx::Context, cxcomment::CXComment)
	contents = []
	
	for ind in 1:clang_Comment_getNumChildren(cxcomment)
		child = clang_Comment_getChild(cxcomment, ind-1)
		kind = clang_Comment_getKind(child)
		
		if kind == CXComment_Text
			text = _string(clang_TextComment_getText, child)
			push!(contents, text)
		elseif kind == CXComment_InlineCommand
			addInline(ctx, contents, child)
		elseif kind == CXComment_HTMLStartTag || kind == CXComment_HTMLEndTag
			# TODO: handle HTML stuff...
		else
			getblock(ctx).flags.notify && @warn "Unhandled comment paragraph child: $(kind)"
		end
	end
	
	return Markdown.Paragraph(contents)
end


function Markdown.Code(ctx::Context, cxcomment::CXComment)
	lines = []
	
	for ind in 1:clang_Comment_getNumChildren(cxcomment)
		child = clang_Comment_getChild(cxcomment, ind-1)
		kind = clang_Comment_getKind(child)
		
		if kind == CXComment_VerbatimBlockLine
			line = _string(clang_VerbatimBlockLineComment_getText, child)
			
			# a line with newlines is probably incorrectly parsed, so only keep before a newline
			push!(lines, first(split(line, '\n', limit=2)))
		else
			getblock(ctx).flags.notify && @warn "Unhandled comment code-block child: $(kind)"
		end
	end
	
	return Markdown.Code(join(lines, '\n'))
end


function addInline(ctx::Context, contents, cxcomment)
	num = clang_InlineCommandComment_getNumArgs(cxcomment)
	cmd = _string(clang_InlineCommandComment_getCommandName, cxcomment)
	
	text = _string(clang_InlineCommandComment_getArgText, cxcomment, 0)
	kind = clang_InlineCommandComment_getRenderKind(cxcomment)
	if kind == CXCommentInlineCommandRenderKind_Bold
		push!(contents, Markdown.Bold(text))
	elseif kind == CXCommentInlineCommandRenderKind_Emphasized
		push!(contents, Markdown.Italic(text))
	elseif kind == CXCommentInlineCommandRenderKind_Monospaced
		push!(contents, Markdown.Code(text))  # TODO: maybe need Code(language, text)
	else
		push!(contents, text)
	end
end


function addParameter(ctx::Context, contents, cxcomment)
	num = clang_Comment_getNumChildren(cxcomment)
	num == 1 || error("Incorrect number of parameter-command comment children")
	
	para = clang_Comment_getChild(cxcomment, 0)
	clang_Comment_getKind(para) == CXComment_Paragraph || error("Expected a parameter-command comment paragraph")
	
	param = _string(clang_ParamCommandComment_getParamName, cxcomment)
	param = Markdown.Paragraph([Markdown.Code(param), ":", Markdown.Paragraph(ctx, para).content...,])
	
	if !isempty(contents) && contents[end] isa Markdown.List
		push!(contents[end].items, param)
	else
		push!(contents, Markdown.List(param))
	end
end


