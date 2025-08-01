return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        local whichkey = require("which-key")
        local mappings = {
            { "<leader>1", group = "Harpoon to file (1-9)" },
            { "<C-z>", hidden = true },
            { "cr", desc = "Coerce" },
            { "crs", desc = "Coerce to snake_case" },
            { "crm", desc = "Coerce to MixedCase" },
            { "crc", desc = "Coerce to CamelCase" },
            { "cru", desc = "Coerce to UPPER_SNAKE_CASE" },
            { "cr-", desc = "Coerce to dash-case" },
            { "cr.", desc = "Coerce to dot.case" },
        }
        for i = 2, 9 do
            table.insert(mappings, {"<leader>" .. i, hidden = true })
        end

        whichkey.add(mappings)
        whichkey.setup({ delay = function(ctx) return ctx.plugin and 0 or 300 end })

        vim.keymap.set("n", "?", whichkey.show, { desc = "Buffer Glabal Keymaps" })
        vim.keymap.set("n", "<leader>?", function()
            whichkey.show({ global = false })
        end, { desc = "Buffer Local Keymaps" })
    end,
}
