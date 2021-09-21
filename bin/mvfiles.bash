#!/bin/bash
#
# This script contains a set of functions for moving files around and "pulling"
# files from other main directories   
#

glf() {
	# A little function to retrieve the last modified file in $wi/Documents/Inbox. 
	# echo "$wi"
	find "$wi" -maxdepth 1 -type f -printf "%T@ %p\n" | sort -n | cut -d' ' -f 2- | tail -n 1 | xargs -0 -d "\n" -I {} mv {} ./

	echo "Latest file from Inbox retrieved..."
}



gfib() {
	# A little function to retrieve a file from $wh/Documents/Inbox. 

	mv "$wi"/"$1" ./

	echo "File $1 from Inbox retrieved..."
}


getfile() {
	# A little function to get a file into the current directory

	mv "$1" ./
	echo "Moved $1 into pwd..."
}
