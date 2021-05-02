#!/bin/bash

case $1 in
	install)
		[[ ! -f package.json ]] && npm init -y --scope=lspconfigplus
		npm install yaml-language-server@latest
		;;

	update)
		npm update yaml-language-server
		;;

	uninstall)
		npm uninstall yaml-language-server
		;;

	*)
		exit 1
		;;

esac
