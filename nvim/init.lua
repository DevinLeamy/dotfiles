-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Disable swap files.
vim.opt.swapfile = false

-- Autosave files.
vim.api.nvim_create_autocmd("BufModifiedSet", {
    pattern = "*.rs",
    command = "silent! write",
})
