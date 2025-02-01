local function maximize_status()
  return vim.t.maximized and '   ' or ''
end

-- local function flutter_app_version()
--     return vim.g.flutter_tools_decorations.app_version
-- end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
        local lazy_status = require("lazy.status")
        require("lualine").setup({
            options = { theme = "auto" },
            sections = {
                lualine_c = {
                    "filename",
                    maximize_status,
                },
                lualine_x = {
                    {
                        -- flutter_app_version,
                        lazy_status.updates,
                        cond = lazy_status.has_updates,
                        color = { fg = "#FF9e64" },
                    },
                    { "encoding" },
                    { "fileformat" },
                    { "filetype" },
                },
            },
        })
    end
}
