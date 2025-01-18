-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Disable swap files.
vim.opt.swapfile = false

-- Autosave files.
vim.api.nvim_create_autocmd("BufModifiedSet", {
    pattern = { "*.rs", "*.c", "*.h", "*.lua", "*.ts", "*.js" },
    command = "silent! write",
})

-- Enable 'svelte-language-server'.
require("lspconfig").svelte.setup({})

-- Enable 'typescript-language-server'.
require("lspconfig").tsserver.setup({})
require("lspconfig").eslint.setup({})

require("lspconfig").clangd.setup({})

require("lspconfig")["lua_ls"].setup({
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = "/Users/Devin/.local/lua/lua",
            },
        },
    },
})

-- Toggle comments with Ctrl+/.
require("Comment").setup()
