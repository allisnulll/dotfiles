return {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    -- TODO: figure out how to unload nvim-ufo on files with mkview
    -- event = "User ufo",
    config = function()
        local ufo = require("ufo")

        vim.o.foldcolumn = "1"
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true
        vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

        vim.keymap.set("n", "zR", ufo.openAllFolds)
        vim.keymap.set("n", "zM", ufo.closeAllFolds)
        vim.keymap.set("n", "<C-f>", function()
            local winid = ufo.peekFoldedLinesUnderCursor()
            if not winid then
                vim.lsp.buf.hover()
            end
        end, { desc = "UFO Fold Preview" })

        ufo.setup({
            provider_selector = function(bufnr, filetype, buftype)
                return {"treesitter", "indent"}
            end
        })
    end
}
