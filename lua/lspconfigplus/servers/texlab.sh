#!/bin/bash

os=$(uname -s | tr "[:upper:]" "[:lower:]")
case $os in
	linux)
		platform="linux"
		;;
	darwin)
		platform="macos"
		;;
esac

case $1 in
	install)
		curl -L -o texlab.tar.gz "$(curl -s https://api.github.com/repos/latex-lsp/texlab/releases/latest | grep 'browser_' | cut -d\" -f4 | grep "$platform")"
		tar -xzf texlab.tar.gz
		rm texlab.tar.gz
		;;

	update)
		echo not implemented yet
		;;

	uninstall)
		echo not implemented yet
		;;

	*)
		exit 1
		;;

esac
