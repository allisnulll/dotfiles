return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
        "folke/todo-comments.nvim",
    },
    config = function()
        local telescope = require("telescope")
        local actions= require("telescope.actions")

        telescope.setup({
            defaults = {
                path_display = { "smart" },
                mappings = {
                    i = {
                        -- ["<C-h>"] = "which_key",
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-h>"] = actions.select_all,
                        ["<C-q>"] = actions.send_selected_to_qflist,
                    },
                },
            },
        })

        telescope.load_extension("fzf")

        vim.keymap.set("n", "<leader>f", "", { desc = "Find" })
        vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Fuzzy find files in cwd" })
        vim.keymap.set("n", "<leader>f.", ":Telescope find_files hidden=true<CR>", { desc = "Fuzzy find hidden files in cwd" })
        vim.keymap.set("n", "<leader>fr", ":Telescope oldfiles<CR>", { desc = "Fuzzy find recent files" })
        vim.keymap.set("n", "<leader>fs", ":Telescope live_grep<CR>", { desc = "Fuzzy find string in cwd" })
        vim.keymap.set("n", "<leader>fw", ":Telescope grep_string<CR>", { desc = "Fuzzy find word under cursor in cwd" })
        vim.keymap.set("n", "<leader>fW", function()
            require("telescope.builtin").grep_string({ search = vim.fn.expand("<cWORD>") })
        end, { desc = "Fuzzy find WORD under cursor in cwd" })
        vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Fuzzy find buffers" })
        vim.keymap.set("n", "<leader>fm", ":Telescope marks<CR>", { desc = "Fuzzy find vim marks" })
        vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Fuzzy find help tags" })
        vim.keymap.set("n", "<leader>fg", ":Telescope git_files<CR>", { desc = "Fuzzy find files tracked by Git" })
        vim.keymap.set("n", "<leader>ft", ":TodoTelescope<CR>", { desc = "Fuzzy find todos" })
        vim.keymap.set("n", "<leader>fd", ":Telescope diagnostics<CR>", { desc = "Fuzzy find diagnostics" })
        vim.keymap.set("n", "<leader>fk", require('telescope.builtin').commands, { desc = "Fuzzy find diagnostics" })
    end,
}
