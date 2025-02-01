return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        local whichkey = require("which-key")
        local mappings = {
            { "<leader>1", group = "Harpoon to file (1-9)" },
            { "<C-z>", hidden = true },
        }

        for i = 2, 9 do
            table.insert(mappings, {"<leader>" .. i, hidden = true })
        end
        whichkey.add(mappings)

        whichkey.setup()

        vim.keymap.set("n", "?", function()
            whichkey.show()
        end, { desc = "Buffer Local Keymaps (which-key)" })
        vim.keymap.set("n", "<leader>?", function()
            whichkey.show({ global = false })
        end, { desc = "Buffer Local Keymaps (which-key)" })
    end,
}
