#!/bin/bash

# A bash function to quickly change dirp projects without having to select from list 
# Copy of dirpp() and dirp_appendProject

dp() {
	if [ -z "$1" ]; then
		dirpp
		clear
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

# A function to add a directory to a project
dpu() {
	# Two inputs required 
	# $1: integer of dirp directory
	# $2: project number
	
	# dir=($(eval echo ~$1))
	# sed -i '1i$dir\n'  ~/dirlists/rgray/"$2"
    #dp $2
	#echo $dir
	#dirpu $dir
	#cd .
	eval echo ~$1 >> ~/dirlists/rgray/"$2"
	
	echo "Directory $1 moved to project $2..."
	
	# Remove from current project
	dirpo $1
}
