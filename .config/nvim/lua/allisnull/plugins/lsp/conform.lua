return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "ruff" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "mdformat" },
                php = { "pint" },
                zsh = { "beautysh" },
            },
        })

        vim.keymap.set({ "n", "v" }, "<leader>l", "", { desc = "Lint/Format" })
        vim.keymap.set({ "n", "v" }, "<leader>lf", function()
            conform.format({ lsp_format = "fallback" })
        end, { desc = "Format file or Range (visual mode)" })
    end,
}
