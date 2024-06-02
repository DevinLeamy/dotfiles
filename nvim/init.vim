source $HOME/.config/nvim/vim-plug/plugins.vim 
" Lua plugins
lua require('plugins')
filetype plugin on
" Gruvbox theme
" let g:gruvbox_italic=1
" let g:gruvbox_contrast_dark='hard'
" let g:gruvbox_invert_selection=0
" colorscheme gruvbox 
set background=dark
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" TokyoNight theme 
" colorscheme tokyonight-night
" Ayu Mirage theme
set termguicolors
let g:ayucolor="dark"
colorscheme ayu

set backspace=indent,eol,start
set mouse=a
set tabstop=2
set shiftwidth=2
set expandtab
set nowrap 
set updatetime=100

" Keep cursor centered 
" set scrolloff=999
" Highlight color
highlight Visual cterm=none ctermbg=darkgray ctermfg=cyan

" Change window
nnoremap <C-w> <C-w><C-w>
tnoremap <C-w> <C-w><C-w>

" Open file tree
nnoremap <C-l> :NvimTreeToggle<Esc>
inoremap <C-l> :NvimTreeToggle<Esc>

nnoremap <C-t> :NvimTreeFocus<Esc>
inoremap <C-t> :NvimTreeFocus<Esc>

" Navigate buffers
nnoremap <C-f> :WintabsPrevious<Esc>
inoremap <C-f> <Esc>:WintabsPrevious<Esc>


set nocompatible            " disable compatibility to old-time vi
set hidden
set showmatch               " show matching 
set number
set ignorecase              " case insensitive 
set hlsearch                " highlight search 
set incsearch               " incremental search
set autoindent              " indent a new line the same amount as the line just typed
" set wildmode=longest,list   " get bash-like tab completions
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard^=unnamed,unnamedplus

set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
set noswapfile              " disable creating swap file


" Python3
lua << EOF
-- require('lspconfig').jedi_language_server.setup{}
EOF

" Rust
let g:rustfmt_autosave = 1

lua << EOF
local nvim_lsp = require'lspconfig'

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },
    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    -- command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(opts)
EOF
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>

" Quick-fix
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm(),
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
EOF



lua << EOF
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  diagnostics = {
    enable = false -- true
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
  actions = {
    open_file = {
        window_picker = {
          enable = false,
        }
    }
  }
})
EOF

lua << EOF
require('telescope').setup{}
require('telescope').load_extension('fzf')
require('nvim_comment').setup()
EOF

inoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-p> <cmd>Telescope find_files<cr>
tnoremap <C-p> <cmd>Telescope find_files<cr>

" Comments
" Note: This maps <C-/>, in reality
nnoremap <C-_> :CommentToggle<Esc>
inoremap <C-_> :CommentToggle<Esc>
vnoremap <C-_> :CommentToggle<Esc>

lua << EOF
require('bufferline').setup {
  minimum_padding = 5,
  maximum_padding = 5,

}

local hl = require'bufferline.utils'.hl

local fg_current  = hl.fg_or_default({'Normal'}, '#efefef', 255)
local bg_current  = hl.bg_or_default({'Normal'}, '#333333', 25)
hl.set('BufferDefaultCurrent',        bg_current, fg_current)
EOF

lua << EOF
local nvim_tree_events = require('nvim-tree.events')
local bufferline_api = require('bufferline.api')

local function get_tree_size()
  return require'nvim-tree.view'.View.width
end

nvim_tree_events.subscribe('TreeOpen', function()
  bufferline_api.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe('Resize', function()
  bufferline_api.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe('TreeClose', function()
  bufferline_api.set_offset(0)
end)
EOF

" Tab management
hi BufferCurrent guibg=#fefefe guifg=black
hi BufferCurrentIndex guibg=#fefefe guifg=black
hi BufferCurrentMod guibg=#fefefe guifg=black
hi BufferCurrentSign guibg=#fefefe guifg=black
hi BufferCurrentTarget guibg=#fefefe guifg=black

" nnoremap <C-u> <Cmd>BufferClose<CR>
" nnoremap <C-i> <Cmd>BufferPrevious<CR>
" nnoremap <C-o> <Cmd>BufferNext<CR>



" Vim lightline
set laststatus=2
set noshowmode
let g:lightline={ 
      \ 'colorscheme': 'ayu_dark'
      \}
if !has('gui_running')
  set t_Co=256
endif



" Lua language server
lua << EOF
require'lspconfig'.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
        disable = {'trailing-space'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
EOF

" JavaScript/TypeScript/JSX/TSX
lua << EOF
require'lspconfig'.eslint.setup{}
require'lspconfig'.flow.setup{}
EOF

" Relational notes
let mapleader = ";"
nnoremap <Leader>f :JotJump<Esc>
nnoremap <Leader>F :JotJump --force<Esc>
lua << EOF
  require("jot").setup({
     directories = {
       "~/Desktop/test_vault",
       "/Users/Devin/.local/obsidian/dl/neovim",
       "/Users/Devin/jot_vault/fall_2022"
     },
     display_completions = true,
   })
EOF

" set rtp+=/Users/Devin/Desktop/Github/DevinLeamy/jot.nvim
" nnoremap <Leader>r :lua require("jot").setup({ directories = { "~/Desktop/test_vault" }})<CR>

" dl.nvim

lua << EOF
  require("dl").setup()
EOF
nnoremap <Leader>t :Today<Esc>i<Backspace><Esc>$a
