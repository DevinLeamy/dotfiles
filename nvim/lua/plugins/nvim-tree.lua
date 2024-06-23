-- Docs: https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt

local function on_attach(buffer)
    local api = require "nvim-tree.api"

    -- Setup the default mappings.
    api.config.mappings.default_on_attach(buffer)
end

return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup({
            view = {
                width = 60,
                adaptive_size = true,
                side = "right"
            },
            on_attach = on_attach
        })
    end,
}
