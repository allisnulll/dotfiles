return {
    "declancm/maximize.nvim",
    config = function()
        local maximize = require("maximize")

        maximize.setup()

        vim.keymap.set("n", "<C-w>m", maximize.toggle, { desc = "Toggle maximize window" })
    end,
}
