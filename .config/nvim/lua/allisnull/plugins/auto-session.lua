return {
    "rmagatti/auto-session",
    config = function()
        require("auto-session").setup({
            auto_restore_enabled = false,
            auto_session_suppress_dirs = { "~", "~/Downloads", "~/Documents", "~/Desktop" },
        })
        vim.keymap.set("n", "<leader>w", "", { desc = "Write" })
        vim.keymap.set("n", "<leader>ws", ":AutoSession save<CR>", { desc = "Save session" })
        vim.keymap.set("n", "<leader>wl", ":AutoSession restore<CR>", { desc = "Load session" })
    end,
}
