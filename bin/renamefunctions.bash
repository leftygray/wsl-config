#!/bin/bash

# Functions for manipulating file names

addrtg() {
	# Little function to append my initials to a filename. Usually because I have reviewed a 
	# document. 

	rename "s/\./-RTG./" "$1"
	echo "File $1 reviewed by RTG"  
}

rmfilespaces() {
	#!/bin/bash
	# Little function to remove spaces from a filename

	rename "s/ /_/g" "$1"
	echo "Spaces in filename removed..." 
} 
