return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        require("mason").setup()

        vim.schedule(
            function()
                require("mason-lspconfig").setup({
                    ensure_installed = {
                        "marksman",
                        "harper_ls",
                        "ltex_plus",
                        "lua_ls",
                        "html",
                        "cssls",
                        "pylsp",
                        "clangd",
                        "bashls",
                        "jsonls",
                        "gopls",
                        "jdtls",
                        "tinymist",
                        "intelephense",
                        "laravel_ls",
                    },
                })
            end
        )

        require("mason-tool-installer").setup({
            ensure_installed = {
                "stylua",
                "ruff",
                "prettier",
                "eslint_d",
                "pint",
            },
        })
    end,
}
