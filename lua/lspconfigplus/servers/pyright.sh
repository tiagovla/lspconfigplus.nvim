#!/bin/bash

case $1 in
install)
	[[ ! -f package.json ]] && npm init -y --scope=lspconfigplus
	npm install pyright@latest
	;;

update)
	npm update pyright
	;;

uninstall)
	npm uninstall pyright
	;;

*)
	exit 1
	;;

esac
