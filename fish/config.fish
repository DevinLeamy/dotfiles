# ===============PRE===============

# secrets
if test -f ~/.config/secrets/.secrets.fish
    source ~/.config/secrets/.secrets.fish
end

# ===============NON-PATH ENVIRONMENT VARIABLES===============
set -gx EDITOR nvim

# Locations.
set -gx HOME /Users/Devin
set -gx DESKTOP "$HOME/Desktop"
set -gx DOTFILES_GIT "$DESKTOP/Github/DevinLeamy/dotfiles"
set -gx JAVA_HOME /Users/Devin/Library/Java/JavaVirtualMachines/openjdk-18-1/Contents/Home
set -gx PYTHONPATH '/opt/homebrew/lib/python3.11/site-packages'
set -gx PLAYGROUND /Users/Devin/workspace/playground
set -gx WORKSPACE /Users/Devin/workspace

# Files.
set -gx FISHRC "$HOME/.config/fish/config.fish"
set -gx HKW_FILE "$HOME/.config/hotkey_window/window_id.txt"

# Other.
set -gx SHELL /opt/homebrew/bin/fish

# ===============PATH ENVIRONMENT VARIABLES===============
fish_add_path --path "/Users/Devin/.cargo/bin"
fish_add_path --path /usr/local/opt/openssl/bin # delete?
fish_add_path --path "/usr/local/opt/openssl@1.1/bin" # delete?
fish_add_path --path "$HOME/.poetry/bin"
fish_add_path --path /opt/homebrew/bin
fish_add_path --path "/opt/homebrew/opt/openjdk@11/bin"
fish_add_path --path "/Users/Devin/.local/lua" # lua
fish_add_path --path /Users/Devin/Desktop/Github/OpenSource/aseprite/build/bin # asesprite
fish_add_path --path "/Users/Devin/Library/Application Support/Coursier/bin" # coursier
fish_add_path --path "/opt/homebrew/lib/python3.11/site-packages"
fish_add_path --path /Users/Devin/Desktop/Github/OpenSource/typst/target/release
# fish_add_path --path /Users/Devin/Desktop/Github/OpenSource/yabai/bin
fish_add_path --path "/Users/Devin/.local/bin" # poetry
fish_add_path --path "/Users/Devin/.local/flutter/bin" # flutter
fish_add_path --path "$HOME/.pub-cache/bin" # flutter packages
fish_add_path /opt/homebrew/opt/libpq/bin # postgres

# ===============ALIASES===============
abbr --add s --position command nvim
abbr --add vi --position command nvim
abbr --add vim --position command nvim
abbr --add cat --position command bat

# ===============MISC===============
set fish_greeting # suppress introduction message
set BAT_STYLE "plain,header,grid"

# ===============PROMPT===============
# Based on: https://github.com/DeanPDX/fish-prompt/blob/master/fish_prompt.fish
function fish_prompt
    if not set -q -g __fish_robbyrussell_functions_defined
        set -g __fish_robbyrussell_functions_defined

        function _git_branch_name
            echo (git symbolic-ref HEAD | sed -e 's|^refs/heads/||')
        end

        function _is_git_dirty
            echo (git status -s --ignore-submodules=dirty 2>/dev/null)
        end

        function _is_git_repo
            git rev-parse --is-inside-work-tree >/dev/null 2>&1
        end

        function _repo_branch_name
            eval "_$argv[1]_branch_name"
        end

        function _is_repo_dirty
            eval "_is_$argv[1]_dirty"
        end

        function _repo_type
            if _is_git_repo
                echo git
            end
        end
    end

    set -l cyan (set_color cyan)
    set -l yellow (set_color -o yellow)
    set -l red (set_color -o red)
    set -l blue (set_color -o blue)
    set -l green (set_color -o green)
    set -l normal (set_color normal)

    set -l home_escaped (echo -n $HOME | sed 's/\//\\\\\//g')
    set -l custom_pwd (echo -n $PWD | sed "s/^$home_escaped/~/" | sed 's/ /%20/g')

    set -l arrow "$green➜ "
    if [ $USER = root ]
        set arrow "$red# "
    end

    set -l directory_info $cyan $custom_pwd

    set -l separator $blue '|'

    set -l repo_type (_repo_type)
    if [ $repo_type ]
        set -l repo_branch $red(_repo_branch_name $repo_type)
        set repo_info "$blue $repo_type:($repo_branch$blue)"

        if [ (_is_repo_dirty $repo_type) ]
            set -l dirty "$yellow✗"
            set repo_info "$repo_info$dirty"
        end
    end

    echo -n -s $directory_info $repo_info ' ' $arrow $normal
end

# ===============FUNCTIONS===============
# Edit secrets
function secrets
    set DIRECTORY $PWD

    cd "$HOME/.config/secrets"
    nvim ".secrets.fish"
    source $FISHRC

    cd $DIRECTORY
end

function src
    source $FISHRC
end

function home
    cd $HOME
end

function os
    cd "$HOME/Desktop/Github/OpenSource"
end


function play
    cd $PLAYGROUND
end

function 4a
    cd "$HOME/Desktop/School/4A"
end

function 4160
    cd "$HOME/Desktop/School/4A/CSCI 4160/Assignments/"
end

function 4480
    cd "$HOME/Desktop/School/4A/CENG 4480"
end

function 2740
    cd "/Users/Devin/Desktop/School/4A/CSCI 2740/A2"
end

function school
    sshpass -p "$CUHK_SSH_PASSWORD" ssh "s1155232564@$argv[1]"
end

function lab
    sshpass -p "$VULTR_PASSWORD" ssh vultr
end

function pi
    sshpass -p nicoanddevin ssh nicoanddevin@172.20.10.14
end

# Edit dotfiles.
function dots
    set DIRECTORY $PWD

    cd "$DOTFILES_GIT"
    nvim "fish/config.fish"
    source $FISHRC

    cd $DIRECTORY
end

# Save dotfiles.
function stash_dots
    set DIRECTORY $PWD

    cd "$DOTFILES_GIT"
    ./stash.sh

    cd $DIRECTORY
end

# r <name> [open]
# open: Navigate to and open. 
function r
    set PROJECT $argv[1]

    if test -d "$DESKTOP/Github/DevinLeamy/$PROJECT"
        cd "$DESKTOP/Github/DevinLeamy/$PROJECT"
    else if test -d "$DESKTOP/Github/OpenSource/$PROJECT"
        cd "$DESKTOP/Github/OpenSource/$PROJECT"
    else if test -d "$WORKSPACE/$PROJECT"
        cd "$WORKSPACE/$PROJECT"
    else if test -d "$PLAYGROUND/$PROJECT"
        cd "$PLAYGROUND/$PROJECT"
    else if test "$PROJECT" = os
        cd "$DESKTOP/Github/OpenSource/"
    else
        echo "Project \"$PROJECT\" not found."
        return 1
    end

    if test (count $argv) -eq 2; and test $argv[2] = open
        nvim
    end
end

function gc
    git add .
    git commit -m $argv[1]
    git push
end

# ===============POST===============

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# pnpm
# set -gx PNPM_HOME /Users/Devin/Library/pnpm
# if not string match -q -- $PNPM_HOME $PATH
#     set -gx PATH "$PNPM_HOME" $PATH
# end
# pnpm end
