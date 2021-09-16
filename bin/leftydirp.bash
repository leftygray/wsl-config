#!/bin/bash

# A bash function to quickly change dirp projects without having to select from list 
# Copy of dirpp() and dirp_appendProject

dp() {
	if [ -z "$1" ]; then
		dirpp
	else
		projects=($(ls $DIRP_PROJECTS_DIR))
		project=${projects["$1"-1]}
		dirp_appendProject "$project" true 
	fi

	dirpl
}


# A function to quickly change dirp projects without having to select from list 
dpl() {

	# Copy of dirpp() and dirp_appendProject
	echo "Projects:"
	projects=($(ls $DIRP_PROJECTS_DIR))

	for (( i=0; i < ${#projects[@]}; i++));
	do
		echo -e "$[i+1]) ${projects[i]}"
	done
}
