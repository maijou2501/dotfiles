#!/bin/bash

if [ "$1" = "" ]; then
	echo "input dotfiles FULL path. (ex: . ./linux.sh /home/ito/.dotfiles)"
else
	{
		echo ""
		echo "BASH_CONF=$1"
		# shellcheck disable=SC2016
		echo '. $BASH_CONF/.bash_ito'
	} | tee -a ~/.bashrc

	source ~/.bashrc

	# Git
	mkdir ~/.git_template

	ln -s "$1"/.aspell.conf ~/.aspell.conf
	ln -s "$1"/.inputrc ~/.inputrc
	ln -s "$1"/.ctags   ~/.ctags
	ln -s "$1"/.toprc   ~/.toprc
	ln -s "$1"/.tmux.conf /.config/byobu/.tmux.conf
	ln -s "$1"/githooks ~/.git_template/hooks
	mkdir "$XDG_CONFIG_HOME"/nvim
	ln -s "$1"/init.vim "$XDG_CONFIG_HOME"/nvim/init.vim
	ln -s "$1"/dein.toml "$XDG_CONFIG_HOME"/nvim/dein.toml
	ln -s "$1"/dein_lazy.toml "$XDG_CONFIG_HOME"/nvim/dein_lazy.toml
	ln -s "$1"/ftdetect "$XDG_CONFIG_HOME"/nvim/

fi
