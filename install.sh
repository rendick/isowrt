#!/bin/bash

copy () {
	chmod +x isowrt.sh
	if [[ $1 == "system" ]] ; then
		sudo cp isowrt.sh /usr/bin/local
		echo 'Note that you need to add /usr/bin/local to your $PATH in your shell config file (e.g. .bashrc or .zshrc. Usually it already added, but you have to check it!'
	elif [[ $1 == "user" ]] ; then
		cp isowrt.sh ~/.local/bin/
		echo 'Note that you need to add $HOME/.local/bin to your $PATH in your shell config file (e.g. .bashrc or .zshrc. Usually it already added, but you have to check it!'
	else
		echo 'invalid installation type'
	fi
}

PS3='Installation type: '
types=("system" "user")

echo

select type in "${types[@]}" ; do
	if [[ -n $type ]] ; then
		echo 'You selected: $type'
		break
	else
		echo 'Please select between user and system installation'
	fi
done

echo ''

copy $type
