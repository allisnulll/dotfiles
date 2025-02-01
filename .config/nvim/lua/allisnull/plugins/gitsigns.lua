return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadpre", "BufNewFile" },
    opts = {
        on_attach = function(_)
            local gs = package.loaded.gitsigns
            local keymap = vim.keymap

            vim.keymap.set("n", "]h", gs.next_hunk, { desc = "Next hunk" })
            keymap.set("n", "[h", gs.prev_hunk, { desc = "Previous hunk" })

            keymap.set({"n", "v"}, "<leader>h", "", { desc = "Hunk" })
            keymap.set("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
            keymap.set("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
            keymap.set("v", "<leader>hs", function()
                gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, { desc = "Stage hunk" })
            keymap.set("v", "<leader>hr", function()
                gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, { desc = "Reset hunk" })

            keymap.set("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
            keymap.set("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })

            keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })

            keymap.set("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })

            keymap.set("n", "<leader>hb", function()
                gs.blame_line({ full = true })
            end, { desc = "Blame line" })
            keymap.set("n", "<leader>hB", gs.toggle_current_line_blame, { desc = "Toggle current line blame" })

            keymap.set("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
            keymap.set("n", "<leader>hD", function()
                gs.diffthis("~")
            end, { desc = "Diff this ~" })

            keymap.set({ "o", "x" }, "ih", ":<C-U}Gitsigns select_hunk<CR>", { desc = "Gitsigns select hunk" })
        end,
    },
}
