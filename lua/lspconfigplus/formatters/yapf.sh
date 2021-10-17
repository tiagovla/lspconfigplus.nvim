#!/bin/bash

case $1 in
install)
	python3 -m venv ./venv
	./venv/bin/pip3 install -U pip
	./venv/bin/pip3 install -U yapf
	./venv/bin/pip3 install -U toml
	;;

update)
	./venv/bin/pip3 install -U --upgrade yapf
	;;

uninstall)
	./venv/bin/pip3 uninstall yapf -y
	;;

*)
	exit 1
	;;

esac
