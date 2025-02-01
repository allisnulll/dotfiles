return {
    "m00qek/baleia.nvim",
    version = "*",
    config = function()
        vim.g.baleia = require("baleia").setup()
        local buffer = vim.api.nvim_get_current_buf()

        vim.api.nvim_create_user_command("BaleiaColorize", function()
            vim.g.baleia.once(buffer)
        end, { bang = true })
        vim.api.nvim_create_user_command("BaleiaLogs", vim.g.baleia.logger.show, { bang = true })

        -- -- vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
        -- --     pattern = "*",
        -- --     callback = function()
        -- --         vim.g.baleia.automatically(buffer)
        -- --     end,
        -- -- })

        -- vim.api.nvim_create_autocmd({ "BufReadPost" }, {
        --     pattern = "quickfix",
        --     callback = function()
        --         vim.api.nvim_set_option_value("modifiable", true, { buf = buffer })
        --         vim.g.baleia.automatically(buffer)
        --         vim.api.nvim_set_option_value("modified", false, { buf = buffer })
        --         vim.api.nvim_set_option_value("modifiable", false, { buf = buffer })
        --     end,
        -- })

        vim.keymap.set("n", "<leader>ma", ":BaleiaColorize<CR>", { desc = "Toggle ANSI Colorizer" })
    end,
}
