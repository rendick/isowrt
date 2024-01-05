#!/bin/bash

copy () {
	chmod +x isowrt.sh
	if [[ $1 == "yes" ]] ; then
		cp isowrt.sh isowrt
		sudo chmod +x isowrt
		sudo mv isowrt /bin/
	elif [[ $1 == "no" ]] ; then
		exit
		else
		echo 'invalid installation type'
	fi
}

PS3='Installation type: '
types=("yes" "no")

echo

select type in "${types[@]}" ; do
	if [[ -n $types ]] ; then
		echo 'You selected: $1'
		break
	else
		echo 'Please select between user and system installation'
	fi
done

sleep 2

copy $type
