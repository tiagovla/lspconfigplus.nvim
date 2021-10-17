#!/bin/bash

case $1 in
install)
	python3 -m venv ./venv
	./venv/bin/pip3 install -U pip
	./venv/bin/pip3 install -U restructuredtext_lint
	;;

update)
	./venv/bin/pip3 install -U --upgrade restructuredtext_lint
	;;

uninstall)
	./venv/bin/pip3 uninstall restructuredtext_lint -y
	;;

*)
	exit 1
	;;

esac
