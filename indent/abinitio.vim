" Vim indent file
" Language:           Ab Initio Data Manipulating Language
" Maintainer:         Ákos Mattiassich <mattia72@gmail.com>
" Version:            1.0
" Project Repository: https://github.com/mattia72/vim-abinitio
" Vim Script Page:    

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif

let b:did_indent = 1

setlocal indentexpr=GetAbinitioIndent(v:lnum)
setlocal indentkeys&
setlocal indentkeys+==end;,==begin
setlocal indentkeys+==if,==else,==switch,==case,==default,
setlocal indentkeys+==while,==for 
setlocal indentkeys+==record,==type

"if exists("*GetAbinitioIdent")
if exists("*GetAbinitioIndent")
  "finish
endif

let s:c_comment = '\/\*\(\*\(?!\/\)\|[^*]\)*\*\/'
let s:cpp_comment = '\/\/.*'

function! s:GetPrevNonCommentLineNum( line_num )
	" Skip lines starting with a comment
	let nline = a:line_num
	while nline > 0
		let nline = prevnonblank(nline-1)
		if getline(nline) !~? '^\s*\(\('.s:c_comment.'\)\|\('.s:cpp_comment.'\)\)'
			break
		endif
	endwhile

	return nline
endfunction

function! s:RemoveComment(line)
  let prev_unc_line =  substitute(a:line, s:c_comment, "", "")
  "echo "uc: ".substitute(prev_unc_line, s:cpp_comment, "", "") 
  return substitute(prev_unc_line, s:cpp_comment, "", "")
endfunction

" Search backwards the matching start element
" if end_element empty, doesn't check for nested elements
function! s:GetMatchingElemLineNum( line_num, start_element, end_element )

	let nline = prevnonblank(a:line_num - 1)
  "echom "prevnonblank:".nline
  let skip_start_elem_num = 0

	while nline > 0
		let line = getline(nline)
    echom line

		if !empty(a:end_element) && line =~ a:end_element
      "echom "another end elem found, skipp next start elem"
		  let skip_start_elem_num += 1
		endif

		if line  =~ a:start_element
      "echom "start elem found"
		  if skip_start_elem_num != 0
        "echom "but we skipp ".skip_start_elem_num
		    let skip_start_elem_num -= 1
		    next
		  else
        "echom "that's it :)".nline
		    break
		  endif
		endif

		let nline = prevnonblank(nline-1)
	endwhile

	return nline
endfunction


function! GetAbinitioIndent( line_num )
	" Line 0 always goes at column 0
	if a:line_num == 0 | return 0 | endif

	let this_line = getline( a:line_num )
	" If in the middle of a three-part comment
	if this_line =~ '^\s*\*'
		return indent( a:line_num )
	endif

	let prev_line_num = s:GetPrevNonCommentLineNum( a:line_num )
	let prev_line = getline( prev_line_num )
	let indnt = indent( prev_line_num )

	" Compiler directives should always go in column zero.
	if this_line =~ '^\s*include\>'
	  echom "include"
		return 0
	endif

	let this_unc_line = s:RemoveComment(this_line)
	" Function definitions have nothing before or after (not even a comment), and go on column 0. 
	if this_line =~ '^\s*\(\h\+\)*\s*\(\(\h\+\d*\s*\)*\)*\s*::\s*\h\+(.*)\s*=\s*$'
	  echom "function"
		return 0
	endif

  let prev_unc_line = s:RemoveComment(prev_line)
	
	" If the previous line hasn't ";" or "end" in the end ...
	if prev_unc_line !~# '\(\<end;\?\)\|\(;\)\s*$'
    echom "prev line not ended with ; or with end;?" " then indent.
    let indnt = indnt + &shiftwidth
    "
  " -----------------------------------------------
	endif

  " begin
	if this_unc_line =~ '^\s*begin\>\s*$' 
      echom "begin and prev line not ended with ;" " unindent.
			return indnt - &shiftwidth

  " begin/record/switch ... end
  elseif this_unc_line =~ '^\s*end\>\s*;\?' 
    echom "end;? get matching elem..."
	  let matching_elem_line_num = s:GetMatchingElemLineNum(a:line_num ,
	    \'\(\<begin\>\)\|\([^\[]\s*\<record\>\)\|\(\<switch\>\)', '\<end\>') 
    echom "end;?: match: ".matching_elem_line_num
	  let indnt = indent(matching_elem_line_num)

  " if ... else
	elseif this_unc_line =~ '^\s*else\>' 
    echom "else? get matching if..."
	  let matching_elem_line_num = s:GetMatchingElemLineNum(a:line_num ,
	    \'\<if\>', '\<else\>') 
    echom "if match: ".matching_elem_line_num
	  let indnt = indent(matching_elem_line_num)

	" switch ... case
	elseif this_unc_line =~ '^\s*\(\<case\>\)\|\(\<default\>\)' 
    echom "case? get matching switch..."
	  let matching_elem_line_num = s:GetMatchingElemLineNum(a:line_num ,
	    \'\<switch\>', '') 
    echom "switch match: ".matching_elem_line_num
	  let indnt = indent(matching_elem_line_num) + &shiftwidth
	    
	" [ ... ]
	elseif this_unc_line =~ '^[^\[]*\]' 
    echom "] get matching [..."
	  let matching_elem_line_num = s:GetMatchingElemLineNum(a:line_num ,
	    \'\[', '\]') 
    echom "] match: ".matching_elem_line_num
	  let indnt = indent(matching_elem_line_num)
	
	" between [ ] block?
	elseif this_unc_line =~ ',\s*$' 
	  echom "between [] block"
	  let matching_elem_line_num = s:GetMatchingElemLineNum(a:line_num ,
	    \'\[', '\]') 
    echom "] match: ".matching_elem_line_num
	  let indnt = indent(matching_elem_line_num) + &sw

	endif

	return indnt
endfunction    

