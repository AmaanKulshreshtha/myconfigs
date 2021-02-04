zmodload zsh/zprof

# PATHS 
########################################

export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="$ZSH/custom/themes"
export ZSH_PLUGINS=$ZSH/custom/plugins
export DENO_INSTALL="$HOME/.local"
export DENO_PATH="$DENO_INSTALL/bin"
export YARN_PATH="$HOME/.yarn/bin"
export MAMP_PHP73="/Applications/MAMP/bin/php/php7.3.24/bin"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_211.jdk/Contents/Home"
export M2_HOME="/opt/apache-maven-3.6.3/bin"
export IDEA_PATH="/opt/idea/bin"
export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_EMULATOR=$ANDROID_HOME/emulator
export ANDROID_TOOLS=$ANDROID_HOME/tools
export ANDROID_BIN=$ANDROID_HOME/tools/bin
export ANDROID_PLATFORM_TOOLS=$ANDROID_HOME/platform-tools
export RBENV_PATH="$HOME/.rbenv/bin"

# CUSTOM JAVSCRIPT PROMPT
########################################

POWERLEVEL9K_CUSTOM_JAVASCRIPT="echo -n '\ue781' JavaScript"
POWERLEVEL9K_CUSTOM_JAVASCRIPT_FOREGROUND="black"
POWERLEVEL9K_CUSTOM_JAVASCRIPT_BACKGROUND="yellow"

# CUSTOM EMOJI PROMPT
#######################################

POWERLEVEL9K_CUSTOM_EMOJI="echo -n '\u2728'"
POWERLEVEL9K_CUSTOM_EMOJI_BACKGROUND="transparent"


# PROMPT ELEMENTS
#######################################

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(ssh dir vcs custom_emoji)
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_DISABLE_RPROMPT=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="$ "

# PLUGINS
########################################

source "$ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting evalcache)

# CUSTOM FUNCTIONS
########################################

# CALL `nvm use` automatically in a directory with `.nvmrc` file
autoload -U add-zsh-hook

lazynvm() {
  unset -f nvm node npm npx
  export NVM_DIR=~/.nvm
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
  if [ -f "$NVM_DIR/bash_completion" ]; then
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
  fi
}

nvm() {
  lazynvm 
  nvm $@
}
 
node() {
  lazynvm
  node $@
}
 
npm() {
  lazynvm
  npm $@
}

npx() {
  lazynvm
  npx $@
}

mkcd() {
  mkdir -p -- "$1" &&
  cd -P -- "$1"
}

nvmi() {
	nvm install "$1" --reinstall-packages-from=node --latest-npm
}

ytdl() {
  youtube-dl -x --audio-format 'mp3' --embed-thumbnail "$1"
}

mirror-android-screen() {
  scrcpy -m 1024
}

record-android-screen() {
  scrcpy -r "$1"
}

restart-sound() {
  sudo launchctl stop com.apple.audio.coreaudiod && sudo launchctl start com.apple.audio.coreaudiod
}

timezsh() {
  time zsh -i -c exit
}

prettify-path() {
  tr ':' '\n' <<< "$PATH"
}

check-rbenv-update() {
  RBENV_GIT="$HOME/.rbenv/.git"
  OUT="$(git --git-dir=$RBENV_GIT diff master origin/master)"
  
  if [ -n "$OUT" ]; then
    git --git-dir=$RBENV_GIT pull
  fi
}

# THEME ENGINE
########################################

POWERLEVEL9K_MODE='nerdfont-complete'
source $ZSH_THEME/Powerlevel9k/powerlevel9k.zsh-theme
ZSH_THEME="Powerlevel9k/powerlevel9k"

# ALIAS
########################################

#alias ls='colorls -1'
#alias lc='colorls -lA --sd'
alias cls='clear'
alias c='code'
alias cin='code-insiders'
alias ip='ifconfig | grep "inet 1"'
alias log='git log --color --oneline | emojify | less -r'
alias mas='mirror-android-screen'
alias ras='record-android-screen'
alias ez='code ~/.zshrc'
alias execz='exec zsh'
alias mage='php bin/magento'

# EXECUTIONS
########################################

source $ZSH/oh-my-zsh.sh
export PATH="/usr/local/sbin:$IDEA_PATH:$RBENV_PATH:$M2_HOME:$JAVA_HOME:$DENO_PATH:$YARN_PATH:$ANDROID_HOME:$ANDROID_EMULATOR:$ANDROID_TOOLS:$ANDROID_BIN:$ANDROID_PLATFORM_TOOLS:$MAMP_PHP73:$PATH"
_evalcache rbenv init -
check-rbenv-update
