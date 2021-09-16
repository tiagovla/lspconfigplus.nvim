#!/bin/bash

os=$(uname -s | tr "[:upper:]" "[:lower:]")
case $os in
	linux)
		platform="linux"
		;;
	darwin)
		platform="mac"
		;;
esac

case $1 in
	install)
	    curl -L -o "shellcheck.tar.xz" "$(curl -s https://api.github.com/repos/koalaman/shellcheck/releases/latest | grep 'browser_' | cut -d\" -f4 | grep "${platform}.x86_64.tar.xz")"
        tar xvf shellcheck.tar.xz --one-top-level=bin --strip-components 1
        rm shellcheck.tar.xz
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
