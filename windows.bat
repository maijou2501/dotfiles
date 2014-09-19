chdir %HOMEDRIVE%%HOMEPATH%\dotfiles
mklink %HOMEDRIVE%%HOMEPATH%"\_vimrc" %HOMEDRIVE%%HOMEPATH%"\dotfiles\_vimrc"
mklink %HOMEDRIVE%%HOMEPATH%"\_gvimrc" %HOMEDRIVE%%HOMEPATH%"\dotfiles\_gvimrc"
exit 0