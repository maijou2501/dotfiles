# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -ahlF'
alias la='ls -Ah'
alias l='ls -CFh'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# add
alias b='bc -ql'
alias c='cat -n'
alias g='grep'
alias h='history'
alias p='ps auwwxf'
alias s='vim -c ":e ++enc=Shift_JIS"'
alias t='top'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias beep="paplay /usr/share/sounds/ubuntu/stereo/system-ready.ogg"
export VISUAL=vim
export EDITOR=vim
bind '"\C-n": history-search-forward'
bind '"\C-p": history-search-backward'
function share_history {
	history -a
	history -c
	history -r
}
PROMPT_COMMAND='share_history'
shopt -u histappend

# PATH of intel compiler, OpenMPI, CUDA
source /opt/intel/composerxe/bin/compilervars.sh intel64
export PATH=$PATH:/opt/openmpi/bin:/usr/local/cuda/bin
export CPATH=$CPATH:/opt/openmpi/include:/usr/local/cuda/include:/opt/arrayfire/include:/usr/local/include
export MANPATH=$MANPATH:/opt/openmpi/share/man:/usr/local/cuda/doc/man
export LIBRARY_PATH=$LIBRARY_PATH:/opt/openmpi/lib/:/usr/local/cuda/lib64:/opt/arrayfire/lib64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/openmpi/lib:/usr/local/cuda/lib64:/opt/arrayfire/lib64
export LD_PRELOAD=/lib/x86_64-linux-gnu/libSegFault.so
export SEGFAULT_SIGNALS=all

# byobu
if [ $SHLVL = 1 ]; then
  byobu
fi

# mkdir $1 && cd $1
function mkcd () { mkdir -p "$@" && eval cd "\"\$$#\""; }

# vim option
function v () { [ $# -eq 0 ] && vim -c "let MRU_Window_Height=50" -c MRU -c "let MRU_Window_Height=10" || vim $@; }
# vim
alias vim="/usr/local/bin/vim"
alias view="/usr/local/bin/view"

# AWS setting
if [ -f ~/.aws ]; then
        . ~/.aws
fi

# ArrayFire
export AF_PATH=/opt/arrayfire

# Haskell
export PATH=~/.local/bin:$PATH
alias ghc="stack ghc --"
alias ghci="stack ghci"
alias runghc="stack runghc --"
alias runhaskell="stack runghc --"
eval "$(stack --bash-completion-script stack)"

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# added by travis gem
[ -f /home/ito/.travis/travis.sh ] && source /home/ito/.travis/travis.sh
