################################################################################
# Local aliases for personal computer
#
# Stored in ~/wsl-config and called by ~/.bashrc

# List all my local aliases
alias akal='cat ~/wsl-config/leftygray.bashrc | grep alias'

# Managing inbox files
alias lsib='ls /mnt/c/Users/lefty/Desktop/Inbox/'
alias ltib='ls -rt /mnt/c/Users/lefty/Desktop/Inbox/'

# Favorite directory aliases
alias cwh='cd /mnt/c/Users/lefty/'
alias cwi='cd /mnt/c/Users/lefty/Desktop/Inbox/'
alias cwd='cd /mnt/c/Users/lefty/Documents/'

alias cwork='cd /mnt/c/Users/lefty/UNSW/OneDrive\ -\ UNSW/'
alias cunsw='cd /mnt/c/Users/lefty/UNSW/UNSW/'

wh=/mnt/c/Users/lefty/
wi=/mnt/c/Users/lefty/Desktop/Inbox/
wd=/mnt/c/Users/lefty/Documents/
work=/mnt/c/Users/lefty/UNSW/OneDrive\ -\ UNSW/
unsw=/mnt/c/lefty/UNSW/UNSW/

# Opening stuff and launching program aliases
alias keepass='/mnt/c/Users/lefty/OneDrive/WindowsApps/KeePass/KeePass.exe'
alias ruler='/mnt/c/Users/lefty/OneDrive/WindowsApps/Ruler.exe'

# Local todo aliases
alias tlproj='cat /mnt/c/Users/lefty/OneDrive/todo.txt/readme.txt | grep "* +"'
alias tlcon='cat /mnt/c/Users/lefty/OneDrive/todo.txt/readme.txt | grep "* @"'

# Local dirp configuration 

#DIRP_LATEST_FILE="/tmp/dirp_latest

DIRP_PROJECTS_DIR="$HOME/dirlists/leftygray/"

#DIRP_LIST_COLOR1='\e[0;33m'
#DIRP_LIST_COLOR2='\e[0;36m'
#DIRP_EXPERT=false
#DIRP_USEALIASES_SUITE=true
#DIRP_USEALIASES_DIRNUMS=true
