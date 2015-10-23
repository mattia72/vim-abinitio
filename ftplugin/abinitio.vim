"=============================================================================
" File:          abinitio.vim
" Author:        Mattia72 
" Description:   Ab Initio Data Manipulating Language    
" Created:       22 okt. 2015
" Project Repo:  https://github.com/Mattia72/vim-abinitio
"=============================================================================

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin") 
  finish  
endif

" Don't load another plug-in for this buffer
let b:did_ftplugin = 1

" This variable is used in indent script also
let b:end_match_words = '\%(\<begin\>\|\%(\[\)\@<!\s*\<vector\>\|\<union\>\|\<record\>\|\<switch\>\)'

" For matchit plugin to jump with % to the matching word:
let b:match_words = b:end_match_words.':\<end\>,\<if\>:\<else\>'

" Set path for neosnippets
if exists("g:neosnippet#snippets_directory")
  let s:plugin_directory = fnamemodify(resolve(expand('<sfile>:p')), ':h')
  let g:abinitio#neosnippet_directory = simplify(s:plugin_directory."/../snippets")
  if stridx(string(g:neosnippet#snippets_directory), g:abinitio#neosnippet_directory) < 0
    let g:neosnippet#snippets_directory.=', '.g:abinitio#neosnippet_directory
    echomsg "get_dir:".string(neosnippet#get_snippets_directory())
  endif
endif

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

