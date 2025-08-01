# Omarchy Oh My Zsh Theme
# A clean, minimal theme with a lightning bolt prompt

# Colors
local user_color='cyan'
local dir_color='blue'
local git_color='yellow'
local prompt_color='cyan'

# Git info
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[$git_color]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[$git_color]%}) %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[$git_color]%}) %{$fg[green]%}✓%{$reset_color%}"

# Main prompt
PROMPT='%{$fg[$dir_color]%}%c%{$reset_color%} $(git_prompt_info)%{$fg[$prompt_color]%}⚡%{$reset_color%} '

# Right prompt (optional)
# RPROMPT='%{$fg[gray]%}%*%{$reset_color%}'

# Window title
precmd() {
  print -Pn "\e]0;%~\a"
}