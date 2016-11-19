"=============================================================================
" File:          vim-abinitio.vim
" Author:        Mattia72 
" Description:   DESCRIPTION   
" Created:       10 nov. 2016
" Project Repo:  https://github.com/Mattia72/vim-abinitio
"=============================================================================

scriptencoding utf-8

" Preprocessing {{{
if exists('g:loaded_vim_abinito')
  finish
elseif v:version < 700
  echoerr 'vim-abinito does not work this version of Vim "' . v:version . '".'
  finish
endif

let g:loaded_vim_abinito = 1

let s:save_cpo = &cpo
set cpo&vim
" Preprocessing }}}

" Global options defintion. {{{
"let g:vim_abinito_auto_open =
      "\ get(g:, 'vim_abinito_auto_open', 1)
" Global options defintion. }}}

" Autocommands {{{
" augroup vim_abinito_global_command_group
"   autocmd!
" augroup END
" Autocommands }}}

" Define commands to operate vim-abinitio
function! g:abinitio#DmlFileLineCount(...)
  echomsg string(line('$'))
endfunction

if exists(':Tabularize')
  " Align selected assignes in nice columns
  vnoremap <buffer> <silent> <leader>t= :Tabularize /=<CR>
  vnoremap <buffer> <silent> <leader>t: :Tabularize /::<CR>
else 
  " Align selected assignes in nice columns
  vnoremap <buffer> <silent> <C-S> :!column -t<CR>
endif

let &cpo = s:save_cpo
unlet s:save_cpo
