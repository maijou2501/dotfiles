se autochdir
se cindent
se clipboard=unnamedplus
se cursorline
se display+=lastline
se fileencodings=ucs-bom,utf-8,euc-jp,cp932
se foldlevel=2
se formatoptions+=mM
se hlsearch
se ignorecase
se incsearch
se list listchars=tab:>-,trail:~,extends:>,precedes:<,eol:$,nbsp:%
se showmatch
se spelllang=en,cjk
se tags=tags;/,codex.tags;/
se textwidth=78
se ts=2 sw=2 sts=0
se wildmenu wildmode=longest,list:full
colorscheme ron "koehler elflord zellner
nnoremap bb :ls<CR>:buf 
nnoremap j gj
nnoremap k gk
nnoremap Y y$
nnoremap <ESC><ESC> :nohlsearch<CR>

" netrw-explore
let g:netrw_use_errorwindow = 0
let g:netrw_silent = 1
let g:netrw_banner = 0
let g:netrw_cursor = 3
let g:netrw_browse_split = 4
let g:netrw_altv    = 1
let g:netrw_preview = 1
let g:netrw_winsize = 85
let g:netrw_liststyle = 3
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

" Zenkaku Space highlight
function! ZenkakuSpace()
	highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction
if has('syntax')
	augroup ZenkakuSpace
		autocmd!
		autocmd ColorScheme       * call ZenkakuSpace()
		autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
	augroup END
	call ZenkakuSpace()
endif

" dein settings {{{
" dein self installation
if &cp | set nocp | endif
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
	call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
" reading plug-in & making caches
let s:toml = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
let s:lazy_toml = fnamemodify(expand('<sfile>'), ':h').'/dein_lazy.toml'
if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir, [s:toml, s:lazy_toml])
	call dein#load_toml(s:toml)
	call dein#load_toml(s:lazy_toml, {'lazy': 1})
	call dein#end()
	call dein#save_state()
endif
" plug-in self installation
" 1st installation
if has('vim_starting') && dein#check_install(['vimproc'])
	call dein#install(['vimproc'])
endif
" other installation
if has('vim_starting') && dein#check_install()
	call dein#install()
endif
" }}}
filetype plugin indent on
syntax enable
" ad hoc
filetype detect
