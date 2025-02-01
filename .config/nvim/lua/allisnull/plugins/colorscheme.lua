-- https://github.com/jesseleite/nvim-noirbuddy
-- https://github.com/scottmckendry/cyberdream.nvim
-- https://github.com/mcchrish/vim-no-color-collections
-- https://github.com/xero/evangelion.nvim

return {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
        -- local bg = "#16181A"
        -- local bg_alt = "#1E2124"
        -- local bg_highlight = "#3C4048"
        -- local fg = "#FFFFFF"
        -- local grey = "#7B8496"
        -- local blue = "#5EA1FF"
        -- local green = "#5EFF6C"
        -- local cyan = "#5EF1FF"
        -- local red = "#FF6E5E"
        -- local yellow = "#F1FF5E"
        -- local magenta = "#FF5EF1"
        -- local pink = "#FF5EA0"
        -- local orange = "#FFBD5E"
        -- local purple = "#BD5EFF"

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

-- return {
--     "scottmckendry/cyberdream.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         require("cyberdream").setup({
--             transparent = true,
--             italic_comments = true,
--             borderless_telescope = false,
--             extensions = {
--                 telescope = true,
--                 treesitter = true,
--                 whichkey = true,
--             },
--         })
--         vim.cmd("colorscheme cyberdream")
--     end
-- }
