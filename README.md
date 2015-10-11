# vim-abinitio
A VIM syntax plugin for Ab Initio Data Manipulation Language.
##  Installation
Copy the included directories into your .vim or vimfiles directory.

Or even better, use [neobundle](http://github.com/Shougo/neobundle.vim "Neobundle") and simply put this line after your neobundle list in your .vimrc:
```
NeoBundleLazy 'mattia72/vim-abinitio'
```
than add this line in your auto commands section:
```
autocmd FileType abinitio NeoBundleSource vim-abinitio
```
So the plugin will loaded only if you open a *.dml file or call `set filetype=abinitio`.

## Syntax highlight
![Screenshot](/../screenshot/screenshot.png?raw=true "Screenshot")

## Indent
Indentation works well on most cases, but there are some bugs yet.

## Thanks
* for the first inspiration: https://sites.google.com/site/abinitiobyte/
* for this indent script howto: http://psy.swansea.ac.uk/staff/Carter/Vim/vim_indent.htm



