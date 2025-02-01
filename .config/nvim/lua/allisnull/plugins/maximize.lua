return {
    'declancm/maximize.nvim',
    config = function()
        require("maximize").setup()
        vim.keymap.set("n", "<C-w>m", function() require("maximize").toggle() end, { desc = "Toggle maximize window" })
    end,
}
