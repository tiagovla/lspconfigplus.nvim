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
		curl -L -o "clangd.zip" "$(curl -s https://api.github.com/repos/clangd/clangd/releases/latest | grep 'browser_' | cut -d\" -f4 | grep "clangd-$platform")"
		rm -rf clangd
		unzip clangd.zip
		rm clangd.zip
		mv clangd_* clangd
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
