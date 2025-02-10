return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufreadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = { "windwp/nvim-ts-autotag" },
    config = function()
        require("nvim-treesitter.configs").setup({
            highlight = { enable = true },
            indent = {
                enable = true,
                disable = { "scheme" },
            },
            autotag = { enable = true },
            auto_install = true,
            ensure_installed = {
                "json",
                "javascript",
                "yaml",
                "toml",
                "html",
                "css",
                "gitignore",
                "java",
                "dart",
                "bash",
                "c",
                "lua",
                "markdown",
                "python",
                "vim",
                "vimdoc",
                "query",
                "scheme",
                "commonlisp",
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-I>",
                    node_incremental = "<C-I>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        })

        require("ufo").setup({
            provider_selector = function(bufnr, filetype, buftype)
                return {"treesitter", "indent"}
            end
        })
    end
}
