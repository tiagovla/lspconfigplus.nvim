#!/bin/bash

case $1 in
	install)
		[[ ! -f package.json ]] && npm init -y --scope=lspconfigplus
		npm install dockerfile-language-server-nodejs@latest
		;;

	update)
		npm update dockerfile-language-server-nodejs
		;;

	uninstall)
		npm uninstall dockerfile-language-server-nodejs
		;;

	*)
		exit 1
		;;

esac
