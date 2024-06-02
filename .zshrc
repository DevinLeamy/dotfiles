# ===============PRE===============

# ===============ZSH PLUGINS===============
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  z
)

# ===============SOURCE OMZ===============
export ZSH=$HOME/.oh-my-zsh


# ===============NON-PATH ENVIRONMENT VARIABLES===============
export CR_PAT="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"
export SENDGRID_API_KEY="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"
export OPEN_AI_API_KEY="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"
export CARGO_REGISTRY_TOKEN="cios8X1zgf5TQffikyzbig061DDQm0kwdhD"
export UNSPLASH_API_KEY="dDD4ek7ULqlw162m0TN8O-fSE9Hk-OffkuQg-1UdKw8"
export SCRIPTS="$HOME/.scripts"
export BAT_STYLE="plain,header,grid"
export DOCKER_DEFAULT_PLATFORM=linux/amd64
export TERM=xterm-256color
export MYVIMRC="/Users/Devin/.config/nvim/init.vim"
export EDITOR="nvim"
export ZSH_THEME="countdown"
export JAVA_HOME="/Users/Devin/Library/Java/JavaVirtualMachines/openjdk-18-1/Contents/Home"
export PYTHONPATH="/opt/homebrew/lib/python3.11/site-packages"
export CARGO_NET_GIT_FETCH_WITH_CLI=true # Allow installing crates from a Github repository
export HOSTNAME=`hostname`
export LIBTORCH="/opt/homebrew/Cellar/pytorch/2.0.1" # pytorch

# ===============SOURCES===============
source "/Users/Devin/.local/zsh/themes/zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh"
source $ZSH/oh-my-zsh.sh


# ===============ALIASES===============
alias playground="cd ~/Desktop/Playground/Active"
alias cat="bat"
alias lfind="rg -e"
alias src="source ~/.zshrc && clear"
alias blocked="sudo nvim /etc/hosts"
alias temp="cd /Users/Devin/Desktop/temp"
alias stt="stty sane"
alias ymael="ssh ymael@68.147.28.143"

# ===DYNAMICALLY LINKED LIBRARIES===
# (set using https://github.com/guillaume-be/rust-bert/tree/main)
export LD_LIBRARY_PATH="/opt/homebrew/Cellar/pytorch/2.0.1/lib:$LD_LIBRARY_PATH"

# ===============PATHS===============
export PATH="/Users/Devin/.cargo/bin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH" # delete?
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH" # delete?
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
export PATH="/Users/Devin/.local/lua:$PATH" # lua
export PATH="/Users/Devin/Desktop/Github/OpenSource/aseprite/build/bin:$PATH" # asesprite
export PATH="/Users/Devin/.local/justfile:$PATH" # justfile
export PATH="/Users/Devin/.local/flutter/bin:$PATH"
export PATH="/Users/Devin/Library/Application Support/Coursier/bin:$PATH" # coursier
export PATH="/opt/homebrew/lib/python3.11/site-packages:$PATH"
export PATH="/Users/Devin/Desktop/Github/OpenSource/typst/target/release:$PATH"
export PATH="/Users/Devin/.local/bin:$PATH" # poetry

# ===============COMMANDS===============
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ===============FUNCTIONS===============

function flush-dns() {
  sudo killall -HUP mDNSResponder
}

function sdaila() {
  DIR=$PWD
  daila
  cp -r "/Users/Devin/Library/Application Support/com.dleamy.daila" "/Users/Devin/Desktop/Github/DevinLeamy/Storage/daila-rs/"
  cd "/Users/Devin/Desktop/Github/DevinLeamy/Storage/daila-rs"
  git add .
  git commit -m "Update"
  gp
  cd $DIR
}

function projects() {
  wd list | rg --color=never "\s__*"
}

function co() {
  clear
  if [[ "$1" == "" ]] then
    projects
    return 0
  fi
  if [[ "$1" == "ls" ]] then
    projects
  else
    DIR=$PWD
    wd "__$1"
    if [[ "$PWD" == "$DIR" ]] then
      projects
    else
      space_id=$(yabai -m query --spaces --space | jq -r '.index')
      code .
      sleep 1
      last_window_id=$(yabai -m query --windows | jq 'map(select(.app == "Code")) | .[].id')
      yabai -m window "${last_window_id}" --space "${space_id}"
      yabai -m window --focus $last_window_id
      current_pid=$(pgrep iTerm2)
      kill $current_pid
    fi
  fi
}

# Run yarn and kill any active process, if there is one.
function yyarn() {
  PORT=$(yarn run start -n | grep -oe "[0-9][0-9][0-9][0-9]")
  if [[ $PORT -ne "" ]] then
    kport "$PORT"
    yarn run start
  fi
}

# Terminate all activity on a port
function kport() {
  kill -9 `lsof -t -i:$1` 2> /dev/null
}

function window_cnt() {
	yabai -m query --spaces --display | jq '.[-1]["index"]'
}

function quit() {
	kill -9 $(yabai -m query --windows --window  | jq '.["pid"]')
}

function run() {
	ARG="$1"

  if [ "$ARG" = "yabai" ]
  then
    brew services restart yabai
    sudo yabai --load-sa
  elif [ "$ARG" = "skhd" ]
  then
    brew services restart skhd
  elif [ "$ARG" = "dns" ]
  then
    sudo brew services restart dnsmasq
  else
    echo "Options:\n- yabai\n- skhd\n- run"
  fi
}

function dot() {
	ARG="$1"

	if [ $ARG = 'nvim' ]
  then
		nvim ~/.config/nvim/init.vim
	elif [ $ARG = 'zsh' ]
	then
		nvim ~/.zshrc
		source ~/.zshrc
	elif [ $ARG = 'plugins' ]
	then
		nvim ~/.config/nvim/vim-plug/plugins.vim
	elif [ $ARG = 'yabai' ]
	then
		nvim ~/.yabairc
	elif [ $ARG = 'map' ]
	then
		nvim ~/.skhdrc
	elif [ $ARG = 'tmux' ]
	then
		nvim ~/.tmux.conf
    tmux source-file ~/.tmux.conf
	elif [ $ARG = 'packer' ]
	then
		nvim ~/.config/nvim/lua/plugins.lua
  elif [ $ARG = 'hammer' ]
  then
    nvim ~/.hammerspoon/init.lua
	else
		echo "Options:\n- zsh\n- nvim\n- plugins\n- yabai\n- map\n- tmux\n- packer\n- hammer"
	fi
}

function window_id() {
  echo $(yabai -m query --windows --window last | jq '.id')
}

function window_ids() {
  WINDOWS_JSON=$(yabai -m query --windows)
}

function toggle_icons() {
  ENABLED=$(defaults read com.apple.finder CreateDesktop 2>/dev/null)

  if [ -z "$ENABLED" ]; then
      echo "Could not read the icons setting. Exiting."
      exit 1
  fi

  # Toggle visibility
  if [ "$ENABLED" = "0" ]; then
      defaults write com.apple.finder CreateDesktop -bool true
  else
      defaults write com.apple.finder CreateDesktop -bool false
  fi

  killall Finder
}


# ===============POST===============

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/Devin/Desktop/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/Devin/Desktop/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/Users/Devin/Desktop/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/Devin/Desktop/google-cloud-sdk/completion.zsh.inc'; fi
# WarpDir (v1.7.0, appended on 2023-05-12 22:27:51 -0400) BEGIN
[[ -f ~/.bash_wd ]] && source ~/.bash_wd
# WarpDir (v1.7.0, appended on 2023-05-12 22:27:51 -0400) END
