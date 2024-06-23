# ===============PRE===============

# ===============NON-PATH ENVIRONMENT VARIABLES===============
set -gx EDITOR nvim

# Locations.
set -gx HOME "/Users/Devin"
set -gx DESKTOP "$HOME/Desktop"
set -gx DOTFILES_GIT "$DESKTOP/Github/DevinLeamy/dotfiles"
set -gx JAVA_HOME '/Users/Devin/Library/Java/JavaVirtualMachines/openjdk-18-1/Contents/Home'
set -gx PYTHONPATH '/opt/homebrew/lib/python3.11/site-packages'

# Files.
set -gx FISHRC "$HOME/.config/fish/config.fish"

# API keys.
set -gx SENDGRID_API_KEY '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'
set -gx OPENAI_API_KEY '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'
set -gx UNSPLASH_API_KEY 'dDD4ek7ULqlw162m0TN8O-fSE9Hk-OffkuQg-1UdKw8'

# Other.
set -gx SHELL '/opt/homebrew/bin/fish'

# ===============PATH ENVIRONMENT VARIABLES===============
fish_add_path --path "/Users/Devin/.cargo/bin"
fish_add_path --path "/usr/local/opt/openssl/bin" # delete?
fish_add_path --path "/usr/local/opt/openssl@1.1/bin" # delete?
fish_add_path --path "$HOME/.poetry/bin"
fish_add_path --path "/opt/homebrew/bin"
fish_add_path --path "/opt/homebrew/opt/openjdk@11/bin"
fish_add_path --path "/Users/Devin/.local/lua" # lua
fish_add_path --path "/Users/Devin/Desktop/Github/OpenSource/aseprite/build/bin" # asesprite
fish_add_path --path "/Users/Devin/Library/Application Support/Coursier/bin" # coursier
fish_add_path --path "/opt/homebrew/lib/python3.11/site-packages"
fish_add_path --path "/Users/Devin/Desktop/Github/OpenSource/typst/target/release"
fish_add_path --path "/Users/Devin/.local/bin" # poetry

# ===============ALIASES===============
abbr --add s --position command nvim

# ===============MISC===============
set fish_greeting # suppress introduction message


# ===============PROMPT===============
# Based on: https://github.com/DeanPDX/fish-prompt/blob/master/fish_prompt.fish
function fish_prompt
    if not set -q -g __fish_robbyrussell_functions_defined
        set -g __fish_robbyrussell_functions_defined

        function _git_branch_name
            echo (git symbolic-ref HEAD | sed -e 's|^refs/heads/||')
        end

        function _is_git_dirty
            echo (git status -s --ignore-submodules=dirty ^/dev/null)
        end

        function _is_git_repo
            git rev-parse --is-inside-work-tree > /dev/null 2>&1
        end

        function _repo_branch_name
            eval "_$argv[1]_branch_name"
        end

        function _is_repo_dirty
            eval "_is_$argv[1]_dirty"
        end

        function _repo_type
            if _is_git_repo
                echo 'git'
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
    if [ $USER = 'root' ]
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
function src
    source $FISHRC
end

# ===============POST===============
