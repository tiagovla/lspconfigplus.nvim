#!/bin/bash

case $1 in
install)
	python3 -m venv ./venv
	./venv/bin/pip3 install -U pip
	./venv/bin/pip3 install -U git+git://github.com/psf/black
	;;

update)
	./venv/bin/pip3 install -U --upgrade black
	;;

uninstall)
	./venv/bin/pip3 uninstall black -y
	;;

*)
	exit 1
	;;

esac
