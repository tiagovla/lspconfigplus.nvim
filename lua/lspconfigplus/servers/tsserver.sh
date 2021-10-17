#!/bin/bash

case $1 in
install)
	[[ ! -f package.json ]] && npm init -y --scope=lspconfigplus
	npm install typescript-language-server@latest typescript@latest
	;;

update)
	npm update typescript-language-server typescript
	;;

uninstall)
	npm uninstall typescript-language-server typescript
	;;

*)
	exit 1
	;;

esac
