"version 6.0
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
nmap gx <Plug>NetrwBrowseX
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
let &cpo=s:cpo_save
unlet s:cpo_save
set backspace=indent,eol,start
set fileencodings=ucs-bom,utf-8,default,latin1
set helplang=ja
set history=200
set nomodeline
set printoptions=paper:a4
set ruler
set runtimepath=~/.vim,/var/lib/vim/addons,/usr/share/vim/vimfiles,/usr/share/vim/vim73,/usr/share/vim/vimfiles/after,/var/lib/vim/addons/after,~/.vim/after
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
" vim: set ft=vim :
" set autoindent
se clipboard=unnamedplus,autoselect
se cursorline
se hlsearch
se incsearch
se list
se number
se showmatch
se wildmenu wildmode=list:full
se ts=4 sw=4 sts=0
se lcs=tab:>-,trail:~,extends:>,precedes:<,eol:$,nbsp:%
if has('syntax')
  syntax enable
  function! ActivateInvisibleIndicator()
    highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=#FF0000
    match ZenkakuSpace /�@/
  endfunction
  augroup InvisibleIndicator
    autocmd!
    autocmd BufEnter * call ActivateInvisibleIndicator()
  augroup END
endif

nmap df :vertical diffsplit 
nmap bb :ls<CR>:buf 
nnoremap <ESC><ESC> :nohlsearch<CR>
colorscheme ron
"colorscheme koehler
"colorscheme elflord
"colorscheme zellner
au BufRead,BufNewFile *.cpp setlocal path+=/usr/include/c++,/opt/openmpi/include,/opt/intel/include,/opt/intel/composerxe/mkl/include,/opt/intel/composerxe/tbb/include,/opt/intel/composerxe/ipp/include
au BufRead,BufNewFile *.c setlocal path+=/usr/include/,/opt/openmpi/include,/opt/intel/include,/opt/intel/composerxe/mkl/include,/opt/intel/composerxe/tbb/include
