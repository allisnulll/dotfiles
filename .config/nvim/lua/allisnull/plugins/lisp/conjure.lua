return {
    "Olical/conjure",
    ft = { "lisp", "scheme" },
    -- TODO: Get conjure to work with baleia
    -- dependency = { "m00qek/baleia.nvim" },
    -- init = function()
    --     local colorize = require("lazyvim.util").has("baleia.nvim")
    --     vim.g["conjure#log#strip_ansi_escape_sequences_line_limit"] = colorize and 1 or nil
    --
    --     vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    --         pattern = "conjure-log-*",
    --         callback = function()
    --             local buffer = vim.api.nvim_get_current_buf()
    --             vim.diagnostic.enable(false, { bufnr = buffer })
    --             if colorize and vim.g.conjure_baleia then
    --                 vim.g.conjure_baleia.automatically(buffer)
    --             end
    --         end,
    --     })
    -- end,
}
