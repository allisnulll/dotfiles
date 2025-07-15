return {
    "thePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        vim.keymap.set("n", "<leader>e", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Harpoon quick menu" })

        vim.keymap.set("n", "<leader>a", function()
            harpoon:list():add()
        end, { desc = "Edit Harpoon file" })

        vim.keymap.set("n", "<C-Tab>", function()
            harpoon:list():next()
        end, { desc = "Harpoon next" })

        vim.keymap.set("n", "<C-S-Tab>", function()
            harpoon:list():prev()
        end, { desc = "Harpoon previous" })

        for i = 1, 9 do
            vim.keymap.set("n", "<leader>" .. i, function() harpoon:list():select(i) end)
        end
    end,
}
