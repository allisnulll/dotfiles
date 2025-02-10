return {
    "chrishrb/gx.nvim",
    keys = {{
        "gx",
        ":Browse<CR>",
        mode = { "n", "x" },
        desc = "Opens filepath or URI under cursor with the system handler (file explorer, web browser, …)",
    }},
    cmd = { "Browse" },
    init = function()
        vim.g.netrw_nogx = 1
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
}
