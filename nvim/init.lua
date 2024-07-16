-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Disable swap files.
vim.opt.swapfile = false

-- Autosave files.
vim.api.nvim_create_autocmd("BufModifiedSet", {
    pattern = "*.rs",
    command = "silent! write",
})

-- Enable 'svelte-language-server'.
require("lspconfig").svelte.setup({})

-- Enable 'typescript-language-server'.
require("lspconfig").tsserver.setup({})

-- Toggle comments with Ctrl+/.
require("Comment").setup()
