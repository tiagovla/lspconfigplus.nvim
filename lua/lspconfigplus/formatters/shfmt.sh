#!/bin/bash

case $1 in
install)
	GOPATH=$(pwd) GOBIN=$(pwd) GO111MODULE=on go install mvdan.cc/sh/v3/cmd/shfmt@latest
	GOPATH=$(pwd) GO111MODULE=on go clean -modcache
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
