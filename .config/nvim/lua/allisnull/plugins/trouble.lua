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
        { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Open trouble diagnostics list" },
        { "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Open trouble buffer diagnostics list" },
        { "<leader>xe", "<cmd>Trouble diagnostics filter.severity=vim.diagnostic.severity.ERROR<cr>", desc = "Open trouble Error diagnostics list" },
        { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Open trouble quickfix list" },
        { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Open trouble location list" },
        { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
        { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
    },
}
