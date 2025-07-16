return {
    "norcalli/nvim-colorizer.lua",
    config = function()
        require("colorizer").setup({
            "*",
            "!dart",
            html = { names = true, mode = "foreground" },
            css = { css = true, mode = "foreground" },
        }, { names = false, RRGGBBAA = true })

        vim.keymap.set("n", "<leader>mc", ":ColorizerToggle<CR>", { desc = "Toggle Colorizer" })
    end,
}
