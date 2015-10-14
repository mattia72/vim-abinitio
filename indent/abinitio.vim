" Vim indent file
" Language:           Ab Initio Data Manipulating Language
" Maintainer:         mattia72
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
setlocal indentkeys+==end,==begin,==;
setlocal indentkeys+==if,==else,==switch,==case,==default,
setlocal indentkeys+==while,==for 
setlocal indentkeys+==vector,==record,==type

setlocal cindent

if exists("*GetAbinitioIndent")
  finish
endif

let s:c_comment = '\/\*\%(\*\%(?!\/\)\|[^*]\)*\*\/'
let s:cpp_comment = '\/\/.*'

function! s:GetPrevNonCommentLineNum( line_num )
	" Skip lines starting with a comment
	let nline = a:line_num
	while nline > 0
		let nline = prevnonblank(nline-1)
		if getline(nline) !~? '^\s*\%(\%('.s:c_comment.'\)\|\%('.s:cpp_comment.'\)\)'
			break
		endif
	endwhile
	return nline
endfunction

function! s:RemoveComment(line)
  let prev_unc_line =  substitute(a:line, s:c_comment, "", "")
  "" echom "RemCom: ".substitute(prev_unc_line, s:cpp_comment, "", "") 
  return substitute(prev_unc_line, s:cpp_comment, "", "")
endfunction

" Search backwards the matching start element
" if end_element empty, it doesn't check for nested elements
function! s:GetMatchingElemLineNum( line_num, start_element, end_element )

	let nline = prevnonblank(a:line_num - 1)
  let skip_start_elem_num = 0

	while nline > 0
		let line = getline(nline)

		if !empty(a:end_element) && line =~ a:end_element
		  let skip_start_elem_num += 1
		endif

		if line  =~ a:start_element
      "echom 'start elem found'
		  if skip_start_elem_num != 0
        "echom 'but we skipp '.skip_start_elem_num
		    let skip_start_elem_num -= 1
		    next
		  else
        "echom 'that's it :)'.nline
		    break
		  endif
		endif

		let nline = prevnonblank(nline-1)
	endwhile

	return nline
endfunction

" words in line after which we should indent
let s:ind_block_words = join(['let','type','record','vector','enum'],'\>\|')

let s:ind_line_words = join([ 'if', 'else', 
                            \ 'for', 'while',
                            \ 'case','default'], '\>\|')


function! GetAbinitioIndent( line_num )
	" Line 0 always goes at column 0
	if a:line_num == 0 | return 0 | endif

	let this_line = getline( a:line_num )
	
	" Todo: If in the middle of a three-part comment, this check is not enough!
	if this_line =~ '^\s*\*' | return indent( a:line_num ) | endif

	let prev_line_num = s:GetPrevNonCommentLineNum( a:line_num )
	let prev_line = getline( prev_line_num )
	let this_line_indent = indent( prev_line_num )
	let shift_val = 0

	" Compiler directives should always go in column zero.
	if this_line =~ '^\s*include\>' | return 0 | endif

	let this_unc_line = s:RemoveComment(this_line)
	" Function definitions have nothing before or after (not even a comment), and go on column 0. 
	if this_line =~ '^\s*\%(\h\+\)*\s*\%(\%(\h\+\d*\s*\)*\)*\s*::\s*\h\+(.*)\s*=\s*$'
		return 0
	endif

  let prev_unc_line = s:RemoveComment(prev_line)

	" If the previous line hasn't ";" or "end" in the end ...
  "echom ' ---prev_unc_line: '.prev_unc_line
  if prev_unc_line !~# '\%(;\|,\|\<end\>\)\s*$'
    "echom 'prev line not ended with ; or , or with end;?' 
    if prev_unc_line =~ '^\s*\%(begin\>\|'.s:ind_line_words.'\>\|'.s:ind_block_words.'\>\)'
      "echom 'prev line started with: '.'^\s*\%(begin\>\|'.s:ind_line_words.'\>\|'.s:ind_block_words.'\>\)'
      let shift_val += &shiftwidth
    endif
  endif

  " begin
  if this_unc_line =~ '^\s*begin\>\s*$' 
      return this_line_indent
  endif

  " begin/record/switch ... end
  if this_unc_line =~ '^\s*end\>\s*;\?' 
    "echom 'end;? get matching elem...'
	  let matching_elem_line_num = s:GetMatchingElemLineNum(a:line_num , b:end_match_words, '\<end\>') 
    "echom 'end;?: match: '.matching_elem_line_num
	  let this_line_indent = indent(matching_elem_line_num)

  " if ... else
	elseif this_unc_line =~ '^\s*else\>' 
    "echom 'else? get matching if...'
	  let matching_elem_line_num = s:GetMatchingElemLineNum(a:line_num ,'\<if\>','\<else\>') 
    "echom "if match: ".matching_elem_line_num
	  let this_line_indent = indent(matching_elem_line_num)

	" switch ... case
	elseif this_unc_line =~ '^\s*\%(case\>\|default\>\)' 
    "echom 'case? get matching switch...'
	  let matching_elem_line_num = s:GetMatchingElemLineNum(a:line_num ,'\<switch\>','') 
    "echom 'switch match: '.matching_elem_line_num
	  let this_line_indent = indent(matching_elem_line_num)
    let shift_val += &shiftwidth

	" [ ... ]
	elseif this_unc_line =~ '^[^\[]*\]' 
    "echom '] get matching [...'
	  let matching_elem_line_num = s:GetMatchingElemLineNum(a:line_num ,'\[', '\]') 
    "echom '] match: '.matching_elem_line_num
	  let this_line_indent = indent(matching_elem_line_num)

	" between [ ] block?
	elseif this_unc_line =~ ',\s*$' 
    "echom 'between [] block'
	  let matching_elem_line_num = s:GetMatchingElemLineNum(a:line_num ,'\[','\]') 
    "echom '] match: '.matching_elem_line_num
	  let this_line_indent = indent(matching_elem_line_num)
    let shift_val += &shiftwidth

  elseif this_unc_line =~ ';\s*$'
    let prev_prev_line = s:RemoveComment(getline(prevnonblank(prev_line_num - 1)))
    "echom 'ppline: '.prev_prev_line
    if prev_prev_line =~ '^\s*\%('.s:ind_line_words.'\>\)' && 
      \ prev_unc_line !~# '^\s*begin\>\s*$' " && prev_unc_line !~# ';\s*$'
      "echom 'prev not begin but but pp indenting word: '.prev_prev_line
      let shift_val -= &sw      
    endif

	endif

	" if shift_val biger then one indent, then correct it
	if shift_val > &sw | let shift_val = &sw | elseif shift_val < -&sw | let shift_val = -&sw | endif
  "echom 'sw: '.shift_val

	return this_line_indent + shift_val
endfunction    

