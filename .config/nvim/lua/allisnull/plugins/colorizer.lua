return {
    "norcalli/nvim-colorizer.lua",
    cond = function()
        return vim.bo.filetype ~= "dart"
    end,
    config = function()
        require("colorizer").setup({
            "*",
            html = { names = true, mode = "foreground" },
            css = { css = true, names = true, mode = "foreground" },
        }, {
            names = false,
        })

        vim.keymap.set("n", "<leader>mc", ":ColorizerToggle<CR>", { desc = "Toggle Colorizer" })
    end,
}
