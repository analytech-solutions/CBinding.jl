

function getdocs(ctx::Context, cursor::CXCursor, nested = [])
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
	tokens = tokenize(ctx.tu[], cursor)
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
	result = ""
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
			result *= repeat("  ", indents)
		end
		if !(!isParens && wasComma)
			result *= c
		end
		
		wasEOL = c == '\n'
		wasComma = c == ','
		if !isParens && wasComma
			result *= '\n'
			wasEOL = true
		end
	end
	
	return Markdown.MD(Markdown.Code(String(language(ctx)), strip(result)))
end



function Markdown.MD(ctx::Context, cursor::CXCursor, comment::CXComment)
	hasDetails = false
	hasParams  = false
	hasReturns = false
	
	contents = Markdown.MD(ctx, cursor).content
	for ind in 1:clang_Comment_getNumChildren(comment)
		child = clang_Comment_getChild(comment, ind-1)
		kind = clang_Comment_getKind(child)
		
		if !hasDetails && !isempty(contents)
			hasDetails = true
			push!(contents, Markdown.Header("Details", 2))
		end
		
		if kind == CXComment_Paragraph
			Bool(clang_Comment_isWhitespace(child)) || push!(contents, Markdown.Paragraph(child))
		elseif kind == CXComment_BlockCommand
			para = clang_BlockCommandComment_getParagraph(child)
			para = Markdown.Paragraph(para)
			
			num = clang_BlockCommandComment_getNumArgs(child)
			cmd = _string(clang_BlockCommandComment_getCommandName, child)
			if cmd == "brief" || cmd == "par" || cmd == "paragraph"
				push!(contents, para)
			elseif cmd == "note" || cmd == "warning" || cmd == "deprecated"
				para = Markdown.Paragraph(["$(uppercase(cmd)):", para.content...])
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
				@warn "Unhandled comment block-command comment: $(cmd)"
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
			
			addParameter(contents, child)
		elseif kind == CXComment_VerbatimBlockCommand
			push!(contents, Markdown.Code(child))
		elseif kind == CXComment_VerbatimLine
			text = _string(clang_VerbatimLineComment_getText, child)
			push!(contents, Markdown.Paragraph(text))
		else
			@warn "Unhandled comment document child: $(kind)"
		end
	end
	
	if length(contents) > 1 && contents[end] isa Markdown.Header
		contents = contents[1:end-1]
	end
	
	return Markdown.MD(contents)
end


function Markdown.Paragraph(cxcomment::CXComment)
	contents = []
	
	for ind in 1:clang_Comment_getNumChildren(cxcomment)
		child = clang_Comment_getChild(cxcomment, ind-1)
		kind = clang_Comment_getKind(child)
		
		if kind == CXComment_Text
			text = _string(clang_TextComment_getText, child)
			push!(contents, text)
		elseif kind == CXComment_InlineCommand
			addInline(contents, child)
		elseif kind == CXComment_HTMLStartTag || kind == CXComment_HTMLEndTag
			# TODO: handle HTML stuff...
		else
			@warn "Unhandled comment paragraph child: $(kind)"
		end
	end
	
	return Markdown.Paragraph(contents)
end


function Markdown.Code(cxcomment::CXComment)
	lines = []
	
	for ind in 1:clang_Comment_getNumChildren(cxcomment)
		child = clang_Comment_getChild(cxcomment, ind-1)
		kind = clang_Comment_getKind(child)
		
		if kind == CXComment_VerbatimBlockLine
			line = _string(clang_VerbatimBlockLineComment_getText, child)
			
			# a line with newlines is probably incorrectly parsed, so only keep before a newline
			push!(lines, first(split(line, '\n', limit=2)))
		else
			@warn "Unhandled comment code-block child: $(kind)"
		end
	end
	
	return Markdown.Code(join(lines, '\n'))
end


function addInline(contents, cxcomment)
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


function addParameter(contents, cxcomment)
	num = clang_Comment_getNumChildren(cxcomment)
	num == 1 || error("Incorrect number of parameter-command comment children")
	
	para = clang_Comment_getChild(cxcomment, 0)
	clang_Comment_getKind(para) == CXComment_Paragraph || error("Expected a parameter-command comment paragraph")
	
	param = _string(clang_ParamCommandComment_getParamName, cxcomment)
	param = Markdown.Paragraph([Markdown.Code(param), ":", Markdown.Paragraph(para).content...,])
	
	if !isempty(contents) && contents[end] isa Markdown.List
		push!(contents[end].items, param)
	else
		push!(contents, Markdown.List(param))
	end
end


