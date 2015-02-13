" set
se nu
se list
se ts=2 sw=2 sts=0
se lcs=tab:>-,trail:~,extends:>,precedes:<,eol:$,nbsp:%
se clipboard+=unnamed
se cursorline
se autochdir
se spelllang=en,cjk
se expandtab
"日本語の行の連結時には空白を入力しない。
se formatoptions+=mM
"画面最後の行をできる限り表示する。
se display+=lastline

" map
nnoremap df :vertical diffsplit 
nnoremap bb :ls<CR>:buf 
nnoremap tn :tabnew<CR>
nnoremap <ESC><ESC> :nohlsearch<CR>
nnoremap mkd :setf ghmarkdown<CR>
"カーソルを表示行で移動する。物理行移動は<C-n>,<C-p>
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk
nnoremap / g/

" for share folder
se nobackup
se noswapfile
se noundofile

" [Writing a custom fold expression](http://vimcasts.org/episodes/writing-a-custom-fold-expression/)
function! MarkdownFolds()
  let thisline = getline(v:lnum)
  if match(thisline, '^## ') >= 0
    return "0"
  elseif match(thisline, '^### ') >= 0
    return ">1"
  else
    return "="
  endif
endfunction
se foldmethod=expr
se foldexpr=MarkdownFolds()

function! MarkdownFoldText()
  let foldsize = (v:foldend-v:foldstart)
  return getline(v:foldstart).' ('.foldsize.' lines)'
endfunction
se foldtext=MarkdownFoldText()

" [open URI]( http://d.hatena.ne.jp/shunsuk/20110508/1304865150 )
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
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle "fuenor/im_control.vim"
NeoBundle "itchyny/lightline.vim"
NeoBundle "tpope/vim-fugitive"
NeoBundle "mru.vim"

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
"NeoBundleCheck


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
let g:indent_guides_auto_colors = 0 
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#222222 ctermbg=gray
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#555555 ctermbg=darkgray
let g:indent_guides_guide_size = 1


" im_control.vim
if has('gui_running')
  " 「日本語入力固定モード」の動作モード
  let IM_CtrlMode = 4
  " GVimで<C-^>が使える場合の「日本語入力固定モード」切替キー
  inoremap <silent> <C-j> <C-^><C-r>=IMState('FixMode')<CR>
else
  " 非GUIの場合(この例では「日本語入力固定モード」を無効化している)
  let IM_CtrlMode = 0
endif

" lightline.vim
se laststatus=2
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

" mru.vim
let MRU_Max_Entries = 50
let MRU_Auto_Close = 1
let MRU_Exclude_Files='^.*\\AppData\\Local\\Temp\\.*$'
