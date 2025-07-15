return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            indent = {
                enable = true,
                disable = { "scheme" },
            },
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
                "latex",
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
                    init_selection = "<C-Space>",
                    node_incremental = "<C-Space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        })
    end
}
