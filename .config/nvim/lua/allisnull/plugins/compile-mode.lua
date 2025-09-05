return {
    "ej-shafran/compile-mode.nvim",
    branch = "nightly",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        vim.g.compile_mode = {}

        vim.keymap.set("n", "<F5>", ":Compile<CR>", { desc = "Compile Mode" })
    end
}
