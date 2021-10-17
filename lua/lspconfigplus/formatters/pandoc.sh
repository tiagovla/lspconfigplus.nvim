#!/bin/bash

os=$(uname -s | tr "[:upper:]" "[:lower:]")
case $os in
linux)
	platform="linux-amd64"
	;;
esac

case $1 in
install)
	curl -L -o "pandoc.tar.gz" "$(curl -s https://api.github.com/repos/jgm/pandoc/releases/latest | grep 'browser_' | cut -d\" -f4 | grep "$platform")"
	tar xvf pandoc.tar.gz --one-top-level=bin --strip-components 1
	rm pandoc.tar.gz
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
