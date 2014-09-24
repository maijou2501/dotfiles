se nu
se list
se lcs=tab:>-,trail:~,extends:<,eol:$,nbsp:%
se clipboard+=unnamed
se cursorline
if has('syntax')
  syntax enable
  function! ActivateInvisibleIndicator()
    highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=#FF0000
    match ZenkakuSpace /@/
  endfunction
  augroup InvisibleIndicator
    autocmd!
    autocmd BufEnter * call ActivateInvisibleIndicator()
  augroup END
endif

" for share folder
se nobackup
se noswapfile
se noundofile
