# ~/.bashrc

[[ $- != *i* ]]&& return

shopt -s autocd cdspell dirspell cdable_vars

alias b='bash'
alias v='vim'

alias ls='ls --file-type --color=auto'
alias la='ls -A'
alias ll='ls -l'

alias rm='rm -fr'

sucColor='\e[38;2;102;255;102m'
errColor='\e[38;2;255;110;106m'
if (( EUID )); then
  userColor="$sucColor" userSymbol='$'
else
  userColor="$errColor" userSymbol='#'
fi

prompt_command(){
  unset branch tag

  [[ $PWD =~ ^$HOME ]]&& { PWD="${PWD#$HOME}" PWD="~$PWD"; }

  local branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
  local tag="$(git describe --tags --abbrev=0 2>/dev/null)"

  printf '\e[2;38;2;255;176;0m%s\e[m' "$PWD"
  [[ $branch ]]&& printf ' \e[2m%s\e[m \e[38;2;243;79;41m\e[m \e[2m%s\e[m' \
    "$branch" "$tag"
  echo
}

PROMPT_COMMAND=prompt_command

PS1="\[$userColor\]\$USER\[\e[m\]@\[\e[38;2;255;176;0m\]\$HOSTNAME\[\e[m\] \
\$((( \$? ))\
  && printf '\[$errColor\]$userSymbol\[\e[m\]> '\
  || printf '\[$sucColor\]$userSymbol\[\e[m\]> ')"

PS4="-[\e[33m${BASH_SOURCE[0]%.sh}\e[m: \e[32m$LINENO\e[m]\
  ${FUNCNAME:+${FUNCNAME[0]}(): }"
