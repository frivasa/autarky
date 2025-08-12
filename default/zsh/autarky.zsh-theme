# Autarky Oh My Zsh Theme
# Colors
local user_color='magenta'
local dir_color='blue'
local git_color='yellow'
local prompt_color='white'

# Git info
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[$git_color]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[$git_color]%}) %{$fg[red]%} %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[$git_color]%}) %{$fg[green]%} %{$reset_color%}"

# Main prompt
PROMPT='%F{$user_color}(%m)%f${$(git_prompt_info):+ }$(git_prompt_info)${$(pixi_prompt_info):+ }$(pixi_prompt_info)
%F{$prompt_color}%~%f %F{red}%D{[%Y-%m-%d %H:%M:%S]}%f
'

# Right prompt (optional)
# RPROMPT='%{$fg[gray]%}%*%{$reset_color%}'
RPROMPT=''

# Window title
precmd() {
  print -Pn "\e]0;%~\a"
}
