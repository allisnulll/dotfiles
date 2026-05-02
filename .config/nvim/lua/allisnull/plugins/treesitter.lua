return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").install({
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
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "scheme",
            callback = function()
                vim.bo.indentexpr = ""
            end,
        })
    end
}
