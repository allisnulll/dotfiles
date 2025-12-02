local function maximize_status()
    return vim.t.maximized and "   " or ""
end

local function flutter_app_version()
    return vim.g.flutter_tools_decorations.app_version
end
local function flutter_app_version_exists()
    return vim.g.flutter_tools_decorations and vim.g.flutter_tools_decorations.app_version ~= nil
end

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
                    {
                        flutter_app_version,
                        cond = flutter_app_version_exists,
                        color = { fg = "#5c5c5c" },
                    },
                },
                lualine_x = {
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates,
                        color = { fg = "#FF9e64" },
                    },
                    "encoding",
                    "fileformat",
                    "filetype",
                },
            },
        })
    end
}
