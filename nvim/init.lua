-- let g:ayucolor="dark"
-- colorscheme ayu

vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.opt.backspace = "indent,eol,start"
vim.opt.mouse = "a"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.updatetime = 100

vim.opt.compatible = true -- " disable compatibility to old-time vi
vim.opt.hidden = true
vim.opt.showmatch = true  -- " show matching
vim.opt.number = true
vim.opt.ignorecase = true -- " case insensitive
vim.opt.hlsearch = true   -- " highlight search
vim.opt.incsearch = true  -- " incremental search
vim.opt.autoindent = true -- " indent a new line the same amount as the line just typed
-- " set wildmode=longest,list   " get bash-like tab completions
-- filetype plugin indent on   "allow auto-indenting depending on file type
-- syntax on                   " syntax highlighting
-- vim.opt.clipboard^=unnamed,unnamedplus
vim.opt.cursorline = true -- highlight current cursorline
vim.opt.ttyfast = true    -- Speed up scrolling in Vim
vim.opt.swapfile = false  -- disable creating swap file
