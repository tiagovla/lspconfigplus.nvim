#!/bin/bash

case $1 in
install)
	git clone --recurse-submodules https://github.com/Koihik/LuaFormatter.git
	mkdir build
	cd build || exit 1
	cmake ../LuaFormatter
	make
	rm ../LuaFormatter -rf
	;;

update)
	echo not implemented yet
	;;

uninstall)
	rm build -rf
	;;

*)
	exit 1
	;;

esac
