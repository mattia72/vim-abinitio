# vim-abinitio
A VIM syntax plugin for Ab Initio Data Manipulation Language.
##  Installation
Copy the included directories into your .vim or vimfiles directory.

Or even better, use [neobundle](http://github.com/Shougo/neobundle.vim "Neobundle") and simply put this line after your neobundle list in your .vimrc:
```
NeoBundleLazy 'mattia72/vim-abinitio'
```
then add this line in your auto commands section:
```
autocmd FileType abinitio NeoBundleSource vim-abinitio
```
So the plugin will loaded only if you open a *.dml file or call `set filetype=abinitio`.

## Syntax highlight
![Screenshot](/../screenshot/screenshot.png?raw=true "Screenshot")

## Indent
Indentation works well (in most cases :)) 
![Screenshot](/../screenshot/align.gif?raw=true "Aligning")

1. Select the lines you wan't to indent. (eg.`V%`)
2. Push `=`

## Matchit support
`b:match_words` contains matching words to jump between "begin" and "end" or
"record" and "end" with %

## Tabularize

## Neosnippet support
For this feature you need to install [neosnippet](http://github.com/Shougo/neosnippet.vim "Neosnippet").

The snippet file should loaded automatically, if not, you can load it by:
```
:NeoSnippetSource <path_to_the_vim-abinitio_plugin>\snippets\abinitio.snip
```    
Then you can start type a snippet alias eg. `func`. 
* `C-k` selects and expands a snippet from the [neocomplcache](https://github.com/Shougo/neocomplcache.vim)/ [neocomplete](https://github.com/Shougo/neocomplete.vim) popup (Use `C-n` and `C-p` to select it). 
* `C-k` can be used to jump to the next field in the snippet.
* `Tab` to select the next field to fill in the snippet.

## Thanks
* for the first inspiration: https://sites.google.com/site/abinitiobyte/
* for this indent script howto: http://psy.swansea.ac.uk/staff/Carter/Vim/vim_indent.htm

