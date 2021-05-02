#!/bin/bash

case $1 in
	install)
		[[ ! -f package.json ]] && npm init -y --scope=lspconfigplus
		npm install vim-language-server@latest
		;;

	update)
		npm update vim-language-server
		;;

	uninstall)
		npm uninstall vim-language-server
		;;

	*)
		exit 1
		;;

esac
