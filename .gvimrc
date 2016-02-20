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

function! s:syntastic()
	SyntasticCheck
	call lightline#update()
endfunction
