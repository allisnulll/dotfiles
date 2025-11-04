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
        })

        vim.cmd("colorscheme tokyonight")
    end
}
