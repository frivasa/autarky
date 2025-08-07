# Autarky Oh My Zsh Theme
# Colors
local user_color='cyan'
local dir_color='blue'
local git_color='yellow'
local prompt_color='cyan'

# Git info
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[$git_color]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[$git_color]%}) %{$fg[red]%}%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[$git_color]%}) %{$fg[green]%}✓%{$reset_color%}"

# Main prompt
PROMPT=$'%{$fg_bold[blue]%}%~%{$reset_color%} $(git_prompt_info) %{$fg[green]%}$(pixi_prompt_info)%{$reset_color%}%{$fg[yellow]%}%D{[%Y-%m-%d %H:%M:%S]}\
%{$reset_color%} '

# Right prompt (optional)
# RPROMPT='%{$fg[gray]%}%*%{$reset_color%}'
RPROMPT=''

# Window title
precmd() {
  print -Pn "\e]0;%~\a"
}
