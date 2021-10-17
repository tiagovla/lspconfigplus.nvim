#!/bin/bash

case $1 in
install)
	[[ ! -f package.json ]] && npm init -y --scope=lspconfigplus
	npm install markdownlint@latest
	npm install markdownlint-cli@latest
	;;

update)
	npm update markdownlint
	npm update markdownlint-cli
	;;

uninstall)
	npm uninstall markdownlint
	npm uninstall markdownlint-cli
	;;

*)
	exit 1
	;;

esac
