#!/usr/bin/env bash

if [ "$1" == "setup" ]; then
	sudo stow -t / system -vv
elif [ "$1" == "teardown" ]; then
	sudo stow -D -t / system -vv
else
	echo "Unknow or missing command!"
fi
