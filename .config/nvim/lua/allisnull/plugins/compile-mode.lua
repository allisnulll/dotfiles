return {
    "ej-shafran/compile-mode.nvim",
    branch = "nightly",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        vim.g.compile_mode = {
            default_command = "",
            ask_about_save = false,
            ask_to_interrupt = false,
            auto_jump_to_first_error = true,
            bang_expansion = true,
        }

        vim.keymap.set("n", "<F5>", ":vert Compile<CR>", { desc = "Compile Mode" })
        vim.keymap.set("n", "<F6>", ":vert Recompile<CR>", { desc = "Recompile Mode" })
    end
}
