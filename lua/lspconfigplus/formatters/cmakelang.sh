#!/bin/bash

case $1 in
	install)
		python3 -m venv ./venv
		./venv/bin/pip3 install -U pip
		./venv/bin/pip3 install -U cmakelang
		;;

	update)
		./venv/bin/pip3 install -U --upgrade cmakelang
		;;

	uninstall)
		./venv/bin/pip3 uninstall cmakelang -y
		;;

	*)
		exit 1
		;;

esac
