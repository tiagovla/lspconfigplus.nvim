#!/bin/bash

case $1 in
	install)
		python3 -m venv ./venv
		./venv/bin/pip3 install -U pip
		./venv/bin/pip3 install -U flake8
		;;

	update)
		./venv/bin/pip3 install -U --upgrade flake8
		;;

	uninstall)
		./venv/bin/pip3 uninstall flake8 -y
		;;

	*)
		exit 1
		;;

esac
