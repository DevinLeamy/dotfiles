" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
 	  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	"autocmd VimEnter * PlugInstall
	"autocmd VimEnter * PlugInstall | source $MYVIMRC
endif


call plug#begin('~/.config/nvim/autoload/plugged')
    " Better Syntax Support
    Plug 'jiangmiao/auto-pairs'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
    Plug 'ixru/nvim-markdown'

    Plug 'morhetz/gruvbox'
    Plug 'Luxed/ayu-vim'
    " Rust
    Plug 'simrat39/rust-tools.nvim'

    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'

    " Snippet completion source for nvim-cmp
    Plug 'hrsh7th/cmp-vsnip'

    " Other usefull completion sources
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-buffer'

    Plug 'machakann/vim-highlightedyank'
    Plug 'andymass/vim-matchup' 

    Plug 'itchyny/lightline.vim'

    " Javascript
    " Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Plug 'mxw/vim-jsx'
    " Plug 'pangloss/vim-javascript'
    
    " Godot
    Plug 'habamax/vim-godot' 

    " Rust
    Plug 'rust-lang/rust.vim'
call plug#end()
