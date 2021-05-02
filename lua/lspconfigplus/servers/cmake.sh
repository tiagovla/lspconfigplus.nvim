#!/bin/bash

case $1 in
	install)
		python3 -m venv ./venv
		./venv/bin/pip3 install -U pip
		./venv/bin/pip3 install -U cmake-language-server
		;;

	update)
		./venv/bin/pip3 install -U --upgrade cmake-language-server
		;;

	uninstall)
		./venv/bin/pip3 uninstall cmake-language-server -y
		;;

	*)
		exit 1
		;;

esac
