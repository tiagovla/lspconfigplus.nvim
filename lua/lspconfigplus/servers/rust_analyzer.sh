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
	curl -L -o "rust-analyzer-$platform" "https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-$platform"
	mv rust-analyzer-$platform rust-analyzer
	chmod +x rust-analyzer
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
