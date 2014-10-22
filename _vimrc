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
nnoremap <ESC><ESC> :nohlsearch<CR>

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
"map <Leader>w :call HandleURI()<CR>
nnoremap gu :call HandleURI()<CR>
