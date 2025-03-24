return {
    "stevearc/oil.nvim",
    ---@module "oil"
    ---@type oil.SetupOpts
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        function _G.get_oil_winbar()
            local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
            local dir = require("oil").get_current_dir(bufnr)
            if dir then
                return vim.fn.fnamemodify(dir, ":~")
            else
                return vim.api.nvim_buf_get_name(0)
            end
        end

        require("oil").setup({
            view_options = { show_hidden = true },
            win_options = {
                winbar = "%!v:lua.get_oil_winbar()",
            },
            keymaps = {
                ["gl"] = {
                    desc = "Toggle file detail",
                    callback = function()
                        detail = not detail
                        if detail then
                            require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
                        else
                            require("oil").set_columns({ "icon" })
                        end
                    end,
                },
                -- TODO: Figure out how to hide desc
                ["<leader>p"] = function()
                    local oil = require("oil")
                    local filename = oil.get_cursor_entry().name
                    local dir = oil.get_current_dir()
                    oil.close()

                    local img_clip = require("img-clip")
                    img_clip.paste_image({}, dir .. filename)
                end,
            },
            telescope = true,
        })

        vim.keymap.set("n", "<C-e>", ":Oil<CR>", { desc = "Oil" })
        vim.keymap.set("v", "<C-e>", ":\b\b\b\b\bOil<CR>", { desc = "Oil" })
    end,
}
