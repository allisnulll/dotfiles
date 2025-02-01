return {
    "rmagatti/auto-session",
    config = function()
        require("auto-session").setup({
            auto_restore_enabled = false,
            auto_session_suppress_dirs = { "~", "~/Dev", "~/Downloads", "~/Documents", "~/Desktop" },
        })
        vim.keymap.set("n", "<leader>w", "", { desc = "Write" })
        vim.keymap.set("n", "<leader>wr", ":SessionRestore<CR>", { desc = "Restore session for cwd" })
        vim.keymap.set("n", "<leader>ws", ":SessionSave<CR>", { desc = "Save session for auto session root dir" })
    end,
}
