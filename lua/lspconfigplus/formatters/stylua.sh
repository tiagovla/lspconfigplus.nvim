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
		curl -L -o "stylua.zip" "$(curl -s https://api.github.com/repos/JohnnyMorganz/StyLua/releases/latest | grep 'browser_' | cut -d\" -f4 | grep "$platform")"
		rm -rf stylelua
		unzip stylua.zip
		rm stylua.zip
		chmod +x stylua
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
