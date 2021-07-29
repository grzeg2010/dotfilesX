#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# MY SETTINGS
if [ "$(tty)" = "/dev/tty1" ]; then
	echo
	/home/typsz/.config/pigeonstats/diskspace.sh # Z FalconStats (https://github.com/Heholord/FalconStats) - wymaga config.sh z tego samego repozytorium
	echo
	/home/typsz/.config/pigeonstats/usage.sh # Z PigeonStats (https://gitlab.com/jennydaman/PigeonStats)
	echo
	/home/typsz/.config/pigeonstats/since.sh # Z PigeonStats (https://gitlab.com/jennydaman/PigeonStats)
	echo
fi




# Bemenu colors
export BEMENU_OPTS="--fn 'DejaVu Sans Mono 11'\
 --tb '#6272a4'\
 --tf '#f8f8f2'\
 --fb '#282a36'\
 --ff '#f8f8f2'\
 --nb '#282a36'\
 --nf '#6272a4'\
 --hb '#44475a'\
 --hf '#50fa7b'\
 --sb '#44475a'\
 --sf '#50fa7b'\
 --scb '#282a36'\
 --scf '#ff79c6'"
