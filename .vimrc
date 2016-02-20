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

" ito setting
se clipboard=unnamedplus,autoselect
se cursorline
se foldlevel=2
se hlsearch
se ic
se incsearch
se list
se number
se showmatch
se spelllang=en,cjk
se wildmenu wildmode=list:full
se ts=2 sw=2 sts=0
se lcs=tab:>-,trail:~,extends:>,precedes:<,eol:$,nbsp:%
syntax enable
colorscheme ron
"colorscheme koehler
"colorscheme elflord
"colorscheme zellner

" map
nnoremap df :vertical diffsplit 
nnoremap <ESC><ESC> :nohlsearch<CR>
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk

" autocmd
" OpenMPI, Intel Compiler
augroup cpp-path
	autocmd!
	autocmd FileType cpp setlocal path=.,/usr/include,/usr/local/include,/usr/include/c++,/opt/openmpi/include,/opt/intel/include,/opt/intel/composerxe/mkl/include,/opt/intel/composerxe/tbb/include,/opt/intel/composerxe/ipp/include,/opt/arrayfire/include
augroup END

augroup c-path
	autocmd!
	autocmd FileType c setlocal path=.,/usr/include/,/opt/openmpi/include,/opt/intel/include,/opt/intel/composerxe/mkl/include,/opt/intel/composerxe/tbb/include,/opt/arrayfire/include
augroup END

" 全角スペースをハイライト表示
function! ZenkakuSpace()
	"highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
	highlight ZenkakuSpace cterm=underline ctermfg=DarkMagenta gui=underline guifg=DarkMagenta
endfunction
if has('syntax')
	augroup ZenkakuSpace
		autocmd!
		autocmd ColorScheme       * call ZenkakuSpace()
		autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
	augroup END
	call ZenkakuSpace()
endif

" neobundle
if &compatible
	set nocompatible               " Be iMproved
endif

" Required:
set runtimepath^=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neoyank.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimproc', {
			\ 'build' : {
			\     'windows' : 'tools\\update-dll-mingw',
			\     'cygwin' : 'make -f make_cygwin.mak',
			\     'mac' : 'make',
			\     'linux' : 'make',
			\     'unix' : 'gmake',
			\    },
			\ }
" utility
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'mru.vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'thinca/vim-ref'
NeoBundle 'open-browser.vim'
" Git
NeoBundle 'mattn/gist-vim', {'depends': 'mattn/webapi-vim'}
NeoBundle 'mattn/webapi-vim'
NeoBundle 'tpope/vim-fugitive'
" markdown
NeoBundle 'godlygeek/tabular'
NeoBundle 'joker1007/vim-markdown-quote-syntax'
NeoBundle 'rcmdnk/vim-markdown'
" programing
NeoBundle 'honza/vim-snippets'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tyru/caw.vim'
" English
NeoBundle 'deton/eblook.vim'
NeoBundle 'ujihisa/neco-look'
" CPP
NeoBundleLazy 'vim-jp/cpp-vim', {
			\ 'autoload' : {'filetypes' : 'cpp'}
			\ }
" Haskell
NeoBundle 'eagletmt/ghcmod-vim'
NeoBundle 'eagletmt/unite-haddock'
NeoBundle 'kana/vim-filetype-haskell'
NeoBundle 'mpickering/hlint-refactor-vim'
NeoBundle 'ujihisa/neco-ghc'
NeoBundle 'ujihisa/unite-haskellimport'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
call neobundle#end()

" Required:
filetype plugin indent on


" neosnippet

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
			\ "\<Plug>(neosnippet_expand_or_jump)"
			\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
			\ "\<Plug>(neosnippet_expand_or_jump)"
			\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
	set conceallevel=2 concealcursor=i
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'


" neocomplete

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
			\ 'default' : '',
			\ 'c' : $HOME.'/.vim/dict/c.dict',
			\ 'ruby' : $HOME.'/.vim/dict/ruby.dict',
			\ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
	let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
	return neocomplete#close_popup() . "\<CR>"
	" For no inserting <CR> key.
	"return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
	let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'


" eblook.vim
let eblook_dictlist1 = [
			\{
			\'book': '/home/ito/Dictionary/Readers\ Plus',
			\'name': 'plus',
			\'title': '研究社_リーダーズ＋プラス',
			\},
			\{
			\'book': '/home/ito/Dictionary/EIJIRO',
			\'name': 'eijiro',
			\'title': '英辞郎',
			\},
			\{
			\'book': '/home/ito/Dictionary/EDICT',
			\'name': 'edict',
			\'title': 'EDICT',
			\},
			\{
			\'book': '/home/ito/Dictionary/rikagaku',
			\'name': 'rikagaku',
			\'title': '理化学辞典第５版',
			\},
			\{
			\'book': '/home/ito/Dictionary/biology',
			\'name': 'honmon',
			\'title': '岩波_生物学辞典_第４版',
			\},
			\{
			\'book': '/home/ito/Dictionary/LSD1',
			\'name': 'lsd',
			\'title': 'ライフサイエンス辞書',
			\},
			\]

" vim-easymotion
" Disable default mapping
let g:EasyMotion_do_mapping = 0 "Disable default mappings
" Find Motions
" Jump to anywhere you want by just `4` or `3` key strokes without thinking!
" `<space>{char}{char}{target}`
map <space> <Plug>(easymotion-s2)
" Migemo feature (for Japanese user)
let g:EasyMotion_use_migemo = 1

" syntastic
let g:syntastic_c_include_dirs = [ '/opt/openmpi/include','/opt/intel/include','/opt/arrayfire/include']
let g:syntastic_cpp_include_dirs = ['/opt/openmpi/include','/opt/intel/include','/opt/arrayfire/include']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

" gist-vim
let g:gist_clip_command = 'xclip -selection clipboard'
let g:gist_detect_filetype = 1

" unite.vim
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,uh :<C-u>Unite -auto-preview hoogle<CR>
nnoremap <silent> ,uc :<C-u>UniteWithCursorWord -auto-preview hoogle<CR>
nnoremap <silent> ,ui :<C-u>Unite haskellimport<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#222222 ctermbg=gray
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#555555 ctermbg=green

" open-browser.vim
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" caw.vim
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

" vimfiler.vim
let g:vimfiler_as_default_explorer = 1

" gvim
" メニューバーを非表示にする
set guioptions-=m
" ツールバーを非表示にする
set guioptions-=T
" 左右のスクロールバーを非表示にする
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
" 水平スクロールバーを非表示にする
set guioptions-=b

" lightline.vim
set guioptions-=e
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left' : [ [ 'mode', 'paste' ],
      \              [ 'fugitive', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode'
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag'
      \ },
      \ 'component_type': {
      \   'syntastic': 'error'
      \ }
      \ }

function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

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

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  return  &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
" let g:vimshell_force_overwrite_statusline = 0
