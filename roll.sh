#/bin/bash

# it returns a pseudo random number
# usage:
# roll.sh [max number]
# roll.sh 6 // to get a number between 1 - 6

if [ "$#" -eq "1" ]; then
	number=$RANDOM
	let "number %= $1"
	let "number = $number + 1"
	echo $number
else
	echo "##########################################"
	echo "usage: "
	echo "roll.sh [max number]"
        echo "roll.sh 6 // to get a number between 1 - 6"
	echo "##########################################"
fi
