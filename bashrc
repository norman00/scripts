# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

screenfetch

# fedora colors 
#export PS1="\[\e[92m\]» \u@\[\e[m\]\[\e[1;36m\]\h\[\e[m\] \W\\$ "

# ubuntu colors
PS1="\[\e[38;5;226m\]\u\[\e[38;5;208m\]@\[\e[38;5;208m\]\h:\[\e[38;5;208m\]\$PWD\[\e[35m\]\n\[\e[38;5;39m\]» \[\e[0m\] "

# color your output - install bat https://github.com/sharkdp/bat#installation
# dnf module install bat
# use bat
alias cat='bat -p --paging=never'

# powerline config
#if [ -f `which powerline-daemon` ]; then
#  powerline-daemon -q
#  POWERLINE_BASH_CONTINUATION=1
#  POWERLINE_BASH_SELECT=1
#  . /usr/share/powerline/bash/powerline.sh
#fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

PS1="\[\e[38;5;226m\]\u\[\e[38;5;208m\]@\[\e[38;5;208m\]\h:\[\e[38;5;208m\]\$PWD\[\e[35m\]\n\[\e[38;5;39m\]» \[\e[0m\] "
