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
            -- on_colors = function(colors)
            --     colors.bg = 
            --     colors.bg_dart = 
            --     colors.bg_float = 
            --     colors.bg_highlight = 
            --     colors.bg_popup = 
            --     colors.bg_search = 
            --     colors.bg_sidebar = 
            --     colors.bg_statusline = 
            --     colors.bg_visual = 
            --     colors.border = 
            --     colors.fg = 
            --     colors.fg_dark = 
            --     colors.fg_float = 
            --     colors.fg_gutter = 
            --     colors.fg_sidebar = 
            -- end
        })
        vim.cmd("colorscheme tokyonight")
    end
}
