return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    event = {
        "BufReadPre " .. vim.fn.expand("~") .. "/Vault/*.md",
        "BufNewFile " .. vim.fn.expand("~") .. "/Vault/*.md",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
        "nvim-telescope/telescope.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    attachments = { img_folder = "assets" },
    config = function()
        local obsidian = require("obsidian")

        obsidian.setup({
            workspaces = {{
                name = "Vault",
                path = "~/Vault",
            }},
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
                    opts = { buffer = true, desc = "Toggle checkbox" },
                },
                ["<CR>"] = {
                    action = function()
                        return require("obsidian").util.smart_action()
                    end,
                    opts = { buffer = true, expr = true },
                },
            },
            daily_notes = { folder = "dailies" },
        })

        vim.keymap.set("n", "<leader>n", "", { desc = "Notes/Obsidian" })
        vim.keymap.set("n", "<leader>nn", ":ObsidianNew<CR>", { desc = "Obsidian New Note" })
        vim.keymap.set("n", "<leader>nq", ":ObsidianQuickSwitch<CR>", { desc = "Obsidian Quick Switch" })
        vim.keymap.set("n", "<leader>nb", ":ObsidianBacklinks<CR>", { desc = "Obsidian Backlinks" })
        vim.keymap.set("n", "<leader>nft", ":ObsidianTags<CR>", { desc = "Obsidian Find Tags" })
        vim.keymap.set("n", "<leader>nd", ":ObsidianToday<CR>", { desc = "Obsidian Today" })
        vim.keymap.set("n", "<leader>nm", ":ObsidianToday +1<CR>", { desc = "Obsidian Tomorrow" })
        vim.keymap.set("n", "<leader>ny", ":ObsidianToday -1<CR>", { desc = "Obsidian Yesterday" })
        vim.keymap.set("n", "<leader>nfd", ":ObsidianDailies<CR>", { desc = "Obsidian Find Dailies" })
        vim.keymap.set("n", "<leader>nt", ":ObsidianTemplate<CR>", { desc = "Obsidian Template" })
        vim.keymap.set("n", "<leader>nff", ":ObsidianSearch<CR>", { desc = "Obsidian Find" })
        vim.keymap.set("v", "<leader>nl", ":ObsidianLink<CR>", { desc = "Obsidian Link" })
        vim.keymap.set("v", "<leader>nw", ":ObsidianLinkNew<CR>", { desc = "Obsidian Link New" })
        vim.keymap.set("n", "<leader>nfl", ":ObsidianLinks<CR>", { desc = "Obsidian Find Links" })
        vim.keymap.set("v", "<leader>e", ":ObsidianExtractNote<CR>", { desc = "Obsidian Extract Note" })
        vim.keymap.set("n", "<leader>nr", ":ObsidianRename<CR>", { desc = "Obsidian Rename" })
        vim.keymap.set("n", "<leader>nc", ":ObsidianToc<CR>", { desc = "Obsidian ToC" })
    end,
}
