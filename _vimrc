" set
se nu
se list
se ts=2 sw=2 sts=0
se lcs=tab:>-,trail:~,extends:>,precedes:<,eol:$,nbsp:%
se clipboard+=unnamed
se cursorline
se autochdir
se expandtab

" map
nnoremap df :vertical diffsplit 
nnoremap bb :ls<CR>:buf 
nnoremap tn :tabnew<CR>
nnoremap <ESC><ESC> :nohlsearch<CR>

" for share folder
se nobackup
se noswapfile
se noundofile

" open URI
"http://d.hatena.ne.jp/shunsuk/20110508/1304865150
function! HandleURI()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
  echo s:uri
  if s:uri != ""
    exec "!start cmd /c chrome \"" . s:uri . "\""
  else
    let s:uri = matchstr(getline("."), '\\\\.*\\.*\.\a\{3,4}')
    echo s:uri
    if s:uri != ""
      exec "!start cmd /c \"" . s:uri . "\""
    else
      let s:uri = matchstr(getline("."), '\a\:\\.*\.\a\{3,4}')
      echo s:uri
      if s:uri != ""
        exec "!start cmd /c \"" . s:uri . "\""
      else
        echo "No URI found in line."
      endif
    endif
  endif
endfunction
nnoremap gu :call HandleURI()<CR>

" NeoBundle
" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'tpope/vim-surround'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


" vim-easymotion
" Disable default mapping
let g:EasyMotion_do_mapping = 0 "Disable default mappings

" Find Motions
" Jump to anywhere you want by just `4` or `3` key strokes without thinking!
" `<space>{char}{char}{target}`
map <space> <Plug>(easymotion-s2)

" Migemo feature (for Japanese user)
let g:EasyMotion_use_migemo = 1


" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level=2
