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
                        "harper_ls",
                        "ltex_plus",
                        "lua_ls",
                        "html",
                        "cssls",
                        "pyright",
                        "clangd",
                        "bashls",
                        "jsonls",
                        "gopls",
                        "jdtls",
                        "tinymist",
                    },
                })
            end
        )

        require("mason-tool-installer").setup({
            ensure_installed = {
                "prettier",
                "stylua",
                "isort",
                "black",
                "pylint",
                "eslint_d",
            },
        })
    end,
}
