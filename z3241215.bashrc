################################################################################
# Local aliases for work computer
#
# Stored in ~/wsl-config and called by ~/.bashrc

# List all my local aliases
alias akal='cat ~/wsl-config/z3241215.bashrc | grep alias'

# Managing inbox files
#alias lsib='ls /mnt/c/Users/z3241215/OneDrive\ -\ UNSW/Inbox/'
#alias ltib='ls -rt /mnt/c/Users/z3241215/OneDrive\ -\ UNSW/Inbox/'

# Favorite directory aliases
alias cwh='cd /mnt/c/Users/z3241215/'
alias cwd='cd /mnt/c/Users/z3241215/Desktop/'
alias cwi='cd /mnt/c/Users/z3241215/OneDrive\ -\ UNSW/Inbox/'
alias cwa='cd /mnt/c/Users/z3241215/OneDrive\ -\ UNSW/Admin/'
alias cwr='cd /mnt/c/Users/z3241215/OneDrive\ -\ UNSW/Research/'
alias cwt='cd /mnt/c/Users/z3241215/OneDrive\ -\ UNSW/Teaching/'
alias cws='cd /mnt/c/Users/z3241215/OneDrive\ -\ UNSW/Service/'
alias cdrop='cd /mnt/c/Users/z3241215/Dropbox/'
alias codp='cd /mnt/c/Users/z3241215/OneDrive/'
alias codu='cd /mnt/c/Users/z3241215/OneDrive\ -\ UNSW/'
alias cunsw='cd /mnt/c/Users/z3241215/UNSW/'


# need "$var" for paths with spaces otherwise cd etc won't work. 
wh=/mnt/c/Users/z3241215/
wd=/mnt/c/Users/z3241215/Desktop/
wi=/mnt/c/Users/z3241215/OneDrive\ -\ UNSW/Inbox/
wa=/mnt/c/Users/z3241215/OneDrive\ -\ UNSW/Admin/
wr=/mnt/c/Users/z3241215/OneDrive\ -\ UNSW/Research/
wt=/mnt/c/Users/z3241215/OneDrive\ -\ UNSW/Teaching/
ws=/mnt/c/Users/z3241215/OneDrive\ -\ UNSW/Service/
drop=/mnt/c/Users/z3241215/Dropbox/
odp=/mnt/c/Users/z3241215/OneDrive/
odu=/mnt/c/Users/z3241215/OneDrive\ -\ UNSW/
unsw=/mnt/c/Users/z3241215/UNSW/

# Opening stuff and launching program aliases
alias keepass='/mnt/c/Users/z3241215/OneDrive/WindowsApps/KeePass/KeePass-2.61.1/KeePass.exe'
alias ruler='/mnt/c/Users/z3241215/OneDrive/WindowsApps/Ruler.exe'

alias rstudio='/mnt/c/Program\ Files/RStudio/bin/rstudio.exe'
alias matlab14='/mnt/c/Program\ Files/MATLAB/R2014a/bin/matlab.exe'
alias matlab18='/mnt/c/Program\ Files/MATLAB/R2018a/bin/matlab.exe'
alias spyder='/mnt/c/Users/z3241215/AppData/Local/Continuum/anaconda2/pythonw.exe'

# Local todo aliases
alias tlproj='cat /mnt/c/Users/z3241215/OneDrive/todo.txt/readme.txt | grep "* +"'
alias tlcon='cat /mnt/c/Users/z3241215/OneDrive/todo.txt/readme.txt | grep "* @"'

# Local dirp configuration

#DIRP_LATEST_FILE="/tmp/dirp_latest"

DIRP_PROJECTS_DIR="$HOME/dirlists/z3241215/"

#DIRP_LIST_COLOR1='\e[0;33m'
#DIRP_LIST_COLOR2='\e[0;36m'
#DIRP_EXPERT=false
#DIRP_USEALIASES_SUITE=true
#DIRP_USEALIASES_DIRNUMS=true

# Local Windows scrcpy aliases
# Scrcpy windows install: https://github.com/Genymobile/scrcpy
alias wscrcpy='/mnt/c/Users/z3241215/OneDrive/WindowsApps/Scrcpy/scrcpy.exe --no-audio'
#export ADB=/mnt/c/Users/z3241215/OneDrive/WindowsApps/Scrcpy/
