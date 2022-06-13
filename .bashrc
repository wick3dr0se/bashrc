# ~/.bashrc

shopt -s autocd
[[ $- != *i* ]] && return

prmpt() {
	echo

	local dir=`pwd`
	local branch=`git branch 2>/dev/null`
	local tag=`git tag 2>/dev/null`

	if [[ $dir != $HOME ]] ; then
		local dir=${dir/$HOME\/}
		_PS1="$dir "
	else
		_PS1='~ '
	fi

	[[ $branch ]] && _PS1+=`printf '[\e[1;36m%s\e[0m]' "${branch/\* }"`
	[[ $tag ]] && _PS1+="-$tag "
	echo -n "$_PS1"

PS1='$ '

	timeStart=$(date +%s)

	sec=$(((timeStart-timeEnd)%60))
	min=$(((timeStart-timeEnd)%3600/60))
	hr=$(((timeStart-timeEnd)/3600))
	secs=`printf '\e[32m%s\e[0ms ' "$sec"`
	mins=`printf '\e[33m%s\e[0mm, ' "$min"`
	hrs=`printf '\e[31m%s\e[0mh, ' "$hr"`
	if (( $hr > 0 )) ; then
		hr=`printf '\e[31m%s\e[0mh, ' "$hr"`
		timer="in $hrs $mins $secs"
	elif (( $hr <= 0 && $min > 0 )) ; then
		min=`printf '\e[33m%s\e[0mm, ' "$min"`
		timer="in $mins $secs"
	elif (( $sec > 0 )) ; then
		sec=`printf '\e[32m%s\e[0ms ' "$sec"`
		timer="in $secs"
	fi

	timeEnd=$timeStart
	
	echo $timer

	[[ $EUID -eq 0 ]] && symbol='#' || symbol='$'

	PS1="\$([[ \$? -eq 0 ]] && printf '\e[1;32m%s\e[0m ' "$symbol" || printf '\e[1;31m%s\e[0m ' "$symbol")"
}
PROMPT_COMMAND=prmpt
timeEnd=$(date +%s)
