return {
    "folke/trouble.nvim",
    opts = {},
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "folke/todo-comments.nvim",
    },
    cmd = "Trouble",
    keys = {
        { "<leader>x", "", desc = "Trouble" },
        { "<leader>xx", ":Trouble diagnostics toggle<CR>", desc = "Open trouble diagnostics list" },
        { "<leader>xb", ":Trouble diagnostics toggle filter.buf=0<CR>", desc = "Open trouble buffer diagnostics list" },
        { "<leader>xe", ":Trouble diagnostics filter.severity=vim.diagnostic.severity.ERROR<CR>", desc = "Open trouble Error diagnostics list" },
        { "<leader>xq", ":Trouble qflist toggle<CR>", desc = "Open trouble quickfix list" },
        { "<leader>xl", ":Trouble loclist toggle<CR>", desc = "Open trouble location list" },
        { "<leader>cs", ":Trouble symbols toggle focus=false<CR>", desc = "Symbols (Trouble)" },
        { "<leader>ct", ":Trouble lsp toggle focus=false win.position=right<CR>", desc = "LSP Definitions / references / ... (Trouble)" },
    },
}
