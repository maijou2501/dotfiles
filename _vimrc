set fileencodings=guess,ucs-bom,ucs-2le,ucs-2,iso-2022-jp-3,utf-8,euc-jisx0213,euc-jp
set formatexpr=autofmt#japanese#formatexpr()
set formatoptions=tcqmM
set guifont=MS_Gothic:h12:cSHIFTJIS
set helplang=ja
set history=50
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set printfont=MS_Mincho:h12:cSHIFTJIS
set showmatch
set smartcase
set title

" color style
colorscheme desert

" set
syntax enable
se backspace=indent,eol,start
se clipboard+=unnamed
se cursorline
"画面最後の行をできる限り表示する。
se display+=lastline
se foldlevel=2
"日本語の行の連結時には空白を入力しない。+ wrap
se formatoptions+=mMt
se formatoptions-=l
se textwidth=78
se ic
se lcs=tab:>-,trail:~,extends:>,precedes:<,eol:$,nbsp:%
se list
se nu
se spell
se spelllang=en,cjk
se ts=2 sw=2 sts=0
se wildmenu wildmode=list:full

" map
nnoremap df :vertical diffsplit 
nnoremap tn :tabnew<CR>
nnoremap <ESC><ESC> :nohlsearch<CR>
nnoremap mkd :setf markdown<CR>
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

" [open URI]( http://d.hatena.ne.jp/shunsuk/20110508/1304865150 )
function! HandleURI()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^)\] >,;:]*')
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
nnoremap gu :call HandleURI()<CR><CR>

" NeoBundle
if &compatible
	set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neoyank.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
" utility
NeoBundle 'fuenor/im_control.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'open-browser.vim'
NeoBundle 'tpope/vim-surround'

" Git
NeoBundle 'mattn/gist-vim', {'depends': 'mattn/webapi-vim'}
NeoBundle 'mattn/webapi-vim'
NeoBundle 'tpope/vim-fugitive'
" Markdown syntax
NeoBundle 'godlygeek/tabular'
NeoBundle 'joker1007/vim-markdown-quote-syntax'
NeoBundle 'rcmdnk/vim-markdown'


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
let g:lightline = {
			\ 'colorscheme': 'wombat',
			\ 'active': {
			\   'left' : [ [ 'mode', 'paste' ],
			\              [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
			\ },
			\ 'component_function': {
			\   'fugitive': 'LightLineFugitive',
			\   'filename': 'LightLineFilename',
			\   'mode': 'LightLineMode'
			\ },
			\ }

function! LightLineFilename()
	return ( &ft == 'vimfiler' ? vimfiler#get_status_string() :
				\  &ft == 'unite' ? unite#get_status_string() :
				\  ''  != expand('%:t') ? expand('%:t') : '[No Name]')
endfunction

function! LightLineFugitive()
	try
		if &ft !~? 'vimfiler' && exists('*fugitive#head')
			let mark = ''  " edit here for cool mark
			let _ = fugitive#head()
			return strlen(_) ? mark._ : ''
		endif
	catch
	endtry
	return ''
endfunction

function! LightLineMode()
	return  &ft == 'unite' ? 'Unite' :
				\ &ft == 'vimfiler' ? 'VimFiler' :
				\ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0


" gist-vim
let g:gist_clip_command = 'putclip'

" unite.vim
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,uk :<C-u>Unite bookmark<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>

" open-browser.vim
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" vimfiler
let g:vimfiler_as_default_explorer = 1
