" Vim filetype plugin file
" Language:           Ab Initio Data Manipulating Language
" Maintainer:         mattia72
" Version:            1.0
" Project Repository: https://github.com/mattia72/vim-abinitio
" Vim Script Page:    

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin") 
  finish  
endif

" Don't load another plug-in for this buffer
let b:did_ftplugin = 1

let b:end_match_words = '\%(\<begin\>\|\%(\[\)\@<!\s*\<record\>\|\<switch\>\)'

" For matchit plugin to jump with % to the matching word:
let b:match_words = b:end_match_words.':\<end\>,\<if\>:\<else\>'

setlocal textwidth=0
setlocal commentstring=//%s
setlocal formatoptions=tcqro

" Change the browse dialog on Win32 to show mainly PowerShell-related files
if has("gui_win32")
	let b:browsefilter =
				\ "All Ab Initio Files (*.dml)\t*.dml\n" .
				\ "All Files (*.*)\t*.*\n"
endif

" Undo the stuff we changed
let b:undo_ftplugin = "setlocal tw< cms< fo< isk< " .
			\ " | unlet! b:browsefilter"

