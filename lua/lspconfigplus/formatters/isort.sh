#!/bin/bash

case $1 in
	install)
		python3 -m venv ./venv
		./venv/bin/pip3 install -U pip
		./venv/bin/pip3 install -U isort
		;;

	update)
		./venv/bin/pip3 install -U --upgrade isort
		;;

	uninstall)
		./venv/bin/pip3 uninstall isort -y
		;;

	*)
		exit 1
		;;

esac
