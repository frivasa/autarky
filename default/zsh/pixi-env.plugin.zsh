function pixi_prompt_info(){
  [[ -n ${PIXI_ENVIRONMENT_NAME} ]] || return
  echo "${ZSH_THEME_PIXI_PREFIX=}${PIXI_PROMPT:t:gs/%/%%}${ZSH_THEME_PIXI_SUFFIX=}"
}

# export CHANGE_PS1=false
# sadly there's no env-var for pixi to not alter ps1,
# change the config on a per-project basis with
# pixi config set shell.change-ps1 false