return {
    "norcalli/nvim-colorizer.lua",
    commit = "260bc9d2f56ad5333df53938835c69639ef0f452",
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
