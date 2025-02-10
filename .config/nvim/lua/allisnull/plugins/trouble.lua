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
        { "<leader>xx", ":Trouble diagnostics toggle<cr>", desc = "Open trouble diagnostics list" },
        { "<leader>xb", ":Trouble diagnostics toggle filter.buf=0<cr>", desc = "Open trouble buffer diagnostics list" },
        { "<leader>xe", ":Trouble diagnostics filter.severity=vim.diagnostic.severity.ERROR<cr>", desc = "Open trouble Error diagnostics list" },
        { "<leader>xq", ":Trouble qflist toggle<cr>", desc = "Open trouble quickfix list" },
        { "<leader>xl", ":Trouble loclist toggle<cr>", desc = "Open trouble location list" },
        { "<leader>cs", ":Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
        { "<leader>cl", ":Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
    },
}
