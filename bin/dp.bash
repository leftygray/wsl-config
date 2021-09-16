#!/bin/bash

# A bash function to quickly change dirp projects without having to select from list 
# Copy of dirpp() and dirp_appendProject

dp() {
	if [ -z "$1" ]; then
		echo "Load Project File:"
		projects=($(ls $DIRP_PROJECTS_DIR))
		projects+=('Quit')
	
		select p in "${projects[@]}"
		do
			case $p in 
				"Quit") 
					break
					;;
				*)
					if [ -e "$DIRP_PROJECTS_DIR/$p" ]; then
						project=$p
					else 
						echo "Error: Bad input."
					fi
				break
				;;
			esac
		done 
		clear
	else
		projects=($(ls $DIRP_PROJECTS_DIR))
		project=${projects["$1"-1]}
	fi

	dirp_appendProject "$project" true 
	dirpl
}

