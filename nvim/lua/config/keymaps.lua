-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set('n', '<C-l>', function()
    require('nvim-tree.api').tree.toggle({ focus = true })
end)

vim.keymap.set('n', '<C-p>',
    function()
        require('telescope.builtin').find_files({ follow = true })
    end,
    { noremap = true, silent = true })
vim.keymap.set('i', '<C-p>',
    function()
        require('telescope.builtin').find_files({ follow = true })
    end,
    { noremap = true, silent = true })

vim.keymap.set('n', '<C-q>', function()
    vim.cmd(':wqall!')
end)
