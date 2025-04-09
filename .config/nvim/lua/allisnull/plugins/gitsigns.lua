return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
        { "<leader>h", "", desc = "Git/Hunks", mode = { "n", "v" }},
        { "<leader>hq", function()
            require("gitsigns").setqflist("all")
            vim.cmd("sleep 1")
            vim.cmd("resize 20")
        end, desc = "Add Repository Hunks to Quickfix List" },
    },
    opts = {
        on_attach = function(_)
            local gs = package.loaded.gitsigns

            vim.keymap.set("n", "]h", gs.next_hunk, { desc = "Next hunk" })
            vim.keymap.set("n", "[h", gs.prev_hunk, { desc = "Previous hunk" })

            vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
            vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
            vim.keymap.set("v", "<leader>hs", function()
                gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, { desc = "Stage hunk" })
            vim.keymap.set("v", "<leader>hr", function()
                gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end, { desc = "Reset hunk" })

            vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
            vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })

            vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })

            vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })

            vim.keymap.set("n", "<leader>hb", function()
                gs.blame_line({ full = true })
            end, { desc = "Blame line" })
            vim.keymap.set("n", "<leader>hB", gs.toggle_current_line_blame, { desc = "Toggle current line blame" })

            vim.keymap.set("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
            vim.keymap.set("n", "<leader>hD", function()
                gs.diffthis("~")
            end, { desc = "Diff this ~" })

            vim.keymap.set({ "o", "x" }, "ih", ":<C-U}Gitsigns select_hunk<CR>", { desc = "Gitsigns select hunk" })
        end,
    },
}
