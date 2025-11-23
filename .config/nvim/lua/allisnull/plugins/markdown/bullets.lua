return {
    "bullets-vim/bullets.vim",
    config = function ()
        vim.keymap.set("i", "<F22>", "<CR>", { desc = "No Bullets" })
        vim.keymap.set("n", "<M-o>", "o", { desc = "No Bullets" })
    end,
}
