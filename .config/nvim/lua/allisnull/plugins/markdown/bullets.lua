return {
    "bullets-vim/bullets.vim",
    config = function ()
        vim.keymap.set("i", "<F20>", "<CR>", { desc = "No Bullets" })
        vim.keymap.set("n", "<M-o>", "o", { desc = "No Bullets" })
    end,
}
