################################################################################
# Local aliases for personal computer
#
# Stored in ~/wsl-config and called by ~/.bashrc
#
# List all my local aliases
alias akal='cat ~/wsl-config/leftygray.bashrc | grep alias'

# Managing inbox files
#alias lsib='ls /mnt/c/Users/lefty/Desktop/Inbox/'
#alias ltib='ls -rt /mnt/c/Users/lefty/Desktop/Inbox/'

# Favorite directory aliases
alias cwh='cd /mnt/c/Users/leftygray/'
alias cwi='cd /mnt/c/Users/leftygray/Desktop/Inbox/'
alias cwdoc='cd /mnt/c/Users/leftygray/Documents/'
alias cwdl='cd /mnt/c/Users/leftygray/Downloads/'
#alias cwork='cd /mnt/c/Users/leftygray/OneDrive\ -\ UNSW/'
#alias cunsw='cd /mnt/c/Users/leftygray/UNSW/'

# Need to "$var" to handle spaces in paths for cd etc to work
wh=/mnt/c/Users/leftygray/
wi=/mnt/c/Users/leftygray/Desktop/Inbox/
wdoc=/mnt/c/Users/leftygray/Documents/
wdl=/mnt/c/Users/leftygray/Downloads/
#work=/mnt/c/Users/leftygray/OneDrive\ -\ UNSW/
#unsw=/mnt/c/lefty/UNSW/

# Opening stuff and launching program aliases
alias keepass='/mnt/c/Users/leftygray/OneDrive/WindowsApps/KeePass/KeePass-2.61.1/KeePass.exe'
alias ruler='/mnt/c/Users/leftygray/OneDrive/WindowsApps/Ruler.exe'

# Local todo aliases
alias tlproj='cat /mnt/c/Users/leftygray/OneDrive/todo.txt/readme.txt | grep "* +"'
alias tlcon='cat /mnt/c/Users/leftygray/OneDrive/todo.txt/readme.txt | grep "* @"'

# Local dirp configuration 

DIRP_PROJECTS_DIR="$HOME/dirlists/leftygray/"

# Local Windows scrcpy aliases
# Scrcpy windows install: https:/github.com/Genymobile/scrcpy
alias wscrcpy='/mnt/c/Users/leftygray/OneDrive/WindowsApps/Scrcpy/scrcpy.exe --no-audio'

