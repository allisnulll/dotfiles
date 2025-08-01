return {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local todo_comments = require("todo-comments")

        vim.keymap.set("n", "]t", todo_comments.jump_next, { desc = "Next todo comment" })
        vim.keymap.set("n", "[t", todo_comments.jump_prev, { desc = "Previous todo comment" })

        todo_comments.setup()
    end,
}

-- TODO: test
-- FIX: test
-- HACK: test
-- WARN: test
-- PERF: test
-- NOTE: test
-- TEST: test
