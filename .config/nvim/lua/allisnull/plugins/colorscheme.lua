return {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
        require("tokyonight").setup({
            style = "night",
            transparent = true,
            styles = {
                floats = "transparent",
                comments = { italic = true },
            },
            on_colors = function(colors)
                colors.bg_search = "#660606"
            end,
            on_highlights = function(highlights, colors)
                highlights.IncSearch = {
                    bg = "#990909",
                    fg = "#000000",
                }
            end,
        })

        vim.cmd("colorscheme tokyonight")
    end
}
