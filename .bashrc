# ~/.bashrc

shopt -s autocd cdspell dirspell cdable_vars
[[ $- != *i* ]] && return

prompt_command() {
	local dir=`pwd`
	local branch=`git branch 2>/dev/null`
	local tag=`git tag 2>/dev/null`

	[[ $dir != $HOME ]] && {
		local dir=${dir/$HOME\/}
		_PS1="$dir "
	} || _PS1='~ '
	[[ $branch ]] && _PS1+=`printf '[\e[1;36m%s\e[0m]' "${branch/\* }"`
	[[ $tag ]] && _PS1+="-$tag " || _PS1+=' '

	printf "$_PS1"

	[[ $EUID -eq 0 ]] && symbol='#' || symbol='$'
	timeStart=`date +%s`

	sec=$(((timeStart-timeEnd)%60))
	min=$(((timeStart-timeEnd)%3600/60))
	hr=$(((timeStart-timeEnd)/3600))

	timer=''
	(( $hr > 0 )) && timer=`printf '\e[31m%s\e[0mh, ' "$hr"`
	(( $min > 0 )) && timer+=`printf '\e[33m%s\e[0mm, ' "$min"`
	(( $sec > 0 )) && timer+=`printf '\e[32m%s\e[0ms ' "$sec"`

	echo $timer

	PS1="\$([[ \$? -eq 0 ]] && printf '\e[1;32m%s\e[0m ' "$symbol" || printf '\e[1;31m%s\e[0m ' "$symbol")"

	timeEnd=$timeStart
}

PROMPT_COMMAND=prompt_command
timeEnd=$(date +%s)
