#!/bin/bash

case $1 in
install)
	# GOPATH=$(pwd) GOBIN=$(pwd) GO111MODULE=on go get -v github.com/mattn/efm-langserver@v0.0.27
	GOPATH=$(pwd) GOBIN=$(pwd) GO111MODULE=on go get -v github.com/mattn/efm-langserver
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
