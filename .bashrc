# ~/.bashrc

shopt -s autocd cdspell dirspell cdable_vars
[[ $- != *i* ]] && return

prompt_command() {
  dir='~'
  [[ $PWD == $HOME ]] || dir=${PWD/$HOME\/}
  branch=$(git branch 2>/dev/null)
  tag=$(git tag 2>/dev/null)

	[[ $EUID -eq 0 ]] && symbol='#' || symbol='$'
  
  timeStart=$(date +%s)

	sec=$(((timeStart-timeEnd)%60))
	min=$(((timeStart-timeEnd)%3600/60))
	hr=$(((timeStart-timeEnd)/3600))

	timer=
  (( $hr > 0 )) && timer=$(printf '\e[31m%s\e[0mh, ' "$hr")
  (( $min > 0 )) && timer+=$(printf '\e[33m%s\e[0mm, ' "$min")
  (( $sec > 0 )) && timer+=$(printf '\e[32m%s\e[0ms ' "$sec")

  timeEnd=$timeStart
}

PROMPT_COMMAND=prompt_command
timeEnd=$(date +%s)

_PS1() {
  printf '%s \e[36m%s \e[0m%s in %s\n\e[3%sm$\e[0m ' \
    "$dir" "${branch/* }" "$tag" "$timer" "$1"
}

PS1="\$([[ \$? -eq 0 ]] && _PS1 2 || _PS1 1)"
