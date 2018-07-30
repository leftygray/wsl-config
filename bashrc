################################################################################
# Aliases
#
# Global bash file which calls system specific aliases
# Need to link to .bashrc in $HOME folder
# ln -s ~/wsl-config ~/.bashrc:
#
# Some people use a different file for aliases
# if [ -f "${HOME}/.bash_aliases" ]; then
#   source "${HOME}/.bash_aliases"
# fi
#
# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.

# List all my aliases
alias aka='cat ~/.bashrc | grep alias'

# Interactive operation aliases.
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias rmspaces='rename "s/ /_/g" *' # Remnove spaces from file names in a directory

# Default to human readable figures aliases
alias df='df -h'
alias du='du -h'

# Misc aliases :)
alias less='less -r'                          # raw control characters
# alias whence='type -a'                        # where, of a sort
#alias grep='grep --color'                     # show differences in colour
# alias egrep='egrep --color=auto'              # show differences in colour
# alias fgrep='fgrep --color=auto'              # show differences in colour
alias clr='clear'

# Setup colours for directories (blue is too hard to read on black background)
LS_COLORS=$LS_COLORS:'di=1;37:' ; export LS_COLORS

# Some aliases for different directory listings
alias ls='ls -hF --color=tty'                 # classify files in colour
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias ll='ls -laF'                              # long list
alias la='ls -A'                              	# all but . and ..
alias l='ls -CF'                              	#
alias ld='ls -d */'
alias lda='ls -dlA */'		       	# List directories only
alias lld='ls -dlaF {.*,*}/'
alias lt='ls -rt'
alias llt='ls -lArt' 				# List by last modified in reverse order 

# Directory aliases
cdl() { cd "$@" && ls; }  # Change directory and list

pushd()
{
  if [ $# -eq 0 ]; then
    DIR="${HOME}"
  else
    DIR="$1"
  fi

  builtin pushd "${DIR}" > /dev/null
  printf "DIRSTACK:\n"
  dirs -v
}

pushd_builtin()
{
  builtin pushd > /dev/null
  printf "DIRSTACK:\n"
  dirs -v
}

popd()
{
  builtin popd > /dev/null
  printf "DIRSTACK:\n"
  dirs -v
}

dstack()
{
  printf "DIRSTACK:\n"
  dirs -v
}

alias cdb='cd -'
alias pd='pushd'
alias back='popd'
alias flip='pushd_builtin'
alias dirs='dirs -v'
alias ds='dstack'

# Disk usage aliases
alias du='du -h'
alias dul='du -h --max-depth=1'
alias dua='du -ha --max-depth=1'

# Global directory and program launch aliases
shopt -s direxpand

alias ex='cmd.exe /c start .' #'star t.'   #Open explorer in current directory
alias o='cmd.exe /c start'
alias edit='/mnt/c/Program\ Files/Sublime\ Text\ 3/sublime_text.exe'
#alias pdftk='/c/Program\ Files\ \(x86\)/PDFtk\ Server/bin/pdftk.exe'

# Key bindings, up/down arrow searches through history
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\eOA": history-search-backward'
bind '"\eOB": history-search-forward'

# git aliases
alias g='git'
alias gs='git status'
alias gl='git lg'
alias gl2='git lg2'
alias gl3='git lg3'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'

# todo.txt aliases
export TODOTXT_DEFAULT_ACTION=ls
alias t='todo.sh'
complete -F _todo t

###############################################################################
# Local workstation specific aliases

if [ $HOSTNAME = "lefty9000" ]; then 
	source ~/wsl-config/leftygray.bashrc
fi

if [ $HOSTNAME = "KI840G5W10-22" ]; then 
	source ~/wsl-config/rgray.bashrc
fi

###############################################################################
#  Customize BASH PS1 prompt to show current GIT repository and branch.
#  by Mike Stewart - http://MediaDoneRight.com


#  SETUP CONSTANTS
#  Bunch-o-predefined colors.  Makes reading code easier than escape sequences.
#  I don't remember where I found this.  o_O

# Enable tab completion
#source ~/git-completion.bash
source /usr/share/bash-completion/completions/git

# colors!
# green="\[\033[0;32m\]"
# blue="\[\033[0;34m\]"
# purple="\[\033[0;35m\]"
# reset="\[\033[0m\]"

# Reset
Color_Off="\[\033[0m\]"       # Text Reset

# Regular Colors
Black="\[\033[0;30m\]"        # Black
Red="\[\033[0;31m\]"          # Red
Green="\[\033[0;32m\]"        # Green
Yellow="\[\033[0;33m\]"       # Yellow
Blue="\[\033[0;34m\]"         # Blue
Purple="\[\033[0;35m\]"       # Purple
Cyan="\[\033[0;36m\]"         # Cyan
White="\[\033[0;37m\]"        # White

# Bold
BBlack="\[\033[1;30m\]"       # Black
BRed="\[\033[1;31m\]"         # Red
BGreen="\[\033[1;32m\]"       # Green
BYellow="\[\033[1;33m\]"      # Yellow
BBlue="\[\033[1;34m\]"        # Blue
BPurple="\[\033[1;35m\]"      # Purple
BCyan="\[\033[1;36m\]"        # Cyan
BWhite="\[\033[1;37m\]"       # White

# Various variables you might want for your PS1 prompt instead
Time12h="\T"
Time12a="\@"
PathShort="\w"
PathFull="\W"
NewLine="\n"
Jobs="\j"

# This PS1 snippet was adopted from code for MAC/BSD I saw from: http://allancraig.net/index.php?option=com_content&view=article&id=108:ps1-export-command-for-git&catid=45:general&Itemid=96
# I tweaked it to work on UBUNTU 11.04 & 11.10 plus made it mo' better

export PS1=$BPurple"\u"$Color_Off':$(git branch &>/dev/null;\
if [ $? -eq 0 ]; then \
  echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
  if [ "$?" -eq "0" ]; then \
    # @4 - Clean repository - nothing to commit
    echo "'$BGreen'"$(__git_ps1 " (%s)"); \
  else \
    # @5 - Changes to working tree
    echo "'$BRed'"$(__git_ps1 " {%s}"); \
  fi) '$Color_Off[$BYellow$PathShort$Color_Off]$NewLine$Color_Off[$BCyan$Time12h$Color_Off]' \$ "; \
else \
  # @2 - Prompt when not in GIT repo
  echo "'[$BYellow$PathShort$Color_Off]$NewLine$Color_Off[$BCyan$Time12h$Color_Off]' \$ "; \
fi)'

# Change command prompt — Udacity style
#source ~/git-prompt.sh
source /usr/lib/git-core/git-sh-prompt
export GIT_PS1_SHOWDIRTYSTATE=1
# '\u' adds the name of the current user to the prompt
# '\$(__git_ps1)' adds git-related stuff
# '\W' adds the name of the current directory
# export PS1="$Red \u $Green\$(__git_ps1)$Yellow \W $ $Color_Off"
################################################################################

# Setup Display for Xming
export DISPLAY=:0
