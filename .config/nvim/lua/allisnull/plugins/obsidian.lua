return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    event = {
        "BufReadPre /home/allisnull/Vault/*.md",
        "BufNewFile /home/allisnull/Vault/*.md",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        -- "hrsh7th/nvim-cmp",
        -- "nvim-telescope/telescope.nvim",
        -- "nvim-treesitter/nvim-treesitter",
    },
    mappings = {
        ["gf"] = {
            action = function()
                return require("obsidian").util.gf_passthrough()
            end,
            opts = { noremap = false, expr = true, buffer = true },
        },
        ["<leader>cb"] = {
            action = function()
                return require("obsidian").util.toggle_checkbox()
            end,
            opts = { buffer = true },
        },
        ["<CR>"] = {
            action = function()
                return require("obsidian").util.smart_action()
            end,
            opts = { buffer = true, expr = true },
        }
    }
}
