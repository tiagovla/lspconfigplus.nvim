#!/bin/bash

case $1 in
install)
	[[ ! -f package.json ]] && npm init -y --scope=lspconfigplus
	npm install bash-language-server@latest
	;;

update)
	npm update bash-language-server
	;;

uninstall)
	npm uninstall bash-language-server
	;;

*)
	exit 1
	;;

esac
