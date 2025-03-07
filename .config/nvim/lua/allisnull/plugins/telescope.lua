return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
        "folke/todo-comments.nvim",
        { "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" },
    },
    config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")
        local actions = require("telescope.actions")
        local lga_actions = require("telescope-live-grep-args.actions")

        telescope.setup({
            defaults = {
                path_display = { "smart" },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-a>"] = actions.select_all,
                        ["<C-s>"] = actions.select_horizontal,
                        ["<C-q>"] = actions.send_selected_to_qflist,
                        ["<C-g>"] = lga_actions.quote_prompt(),
                        ["<C-x>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                        ["<C-Space>"] = lga_actions.to_fuzzy_refine,
                    },
                },
            },
        })

        telescope.load_extension("fzf")
        telescope.load_extension("live_grep_args")

        vim.keymap.set("n", "<leader>f", "", { desc = "Find" })
        vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Fuzzy find files in cwd" })
        vim.keymap.set("n", "<leader>fr", ":Telescope oldfiles<CR>", { desc = "Fuzzy find recent files" })
        vim.keymap.set("n", "<leader>fs", ":Telescope live_grep<CR>", { desc = "Fuzzy find string in cwd" })
        vim.keymap.set("n", "<leader>fs", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { desc = "Fuzzy find string in cwd" })
        vim.keymap.set("n", "<leader>fc", ":Telescope command_history<CR>", { desc = "Fuzzy find command history" })
        vim.keymap.set("n", "<leader>fo", ":Telescope vim_options<CR>", { desc = "Fuzzy find vim options" })
        vim.keymap.set("n", "<leader>fi", ":Telescope man_pages<CR>", { desc = "Fuzzy find man pages" })
        vim.keymap.set("n", "<leader>fw", ":Telescope grep_string<CR>", { desc = "Fuzzy find word under cursor in cwd" })
        vim.keymap.set("n", "<leader>fW", function()
            builtin.grep_string({ search = vim.fn.expand("<cWORD>") })
        end, { desc = "Fuzzy find WORD under cursor in cwd" })
        vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Fuzzy find buffers" })
        vim.keymap.set("n", "<leader>fm", ":Telescope marks<CR>", { desc = "Fuzzy find vim marks" })
        vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Fuzzy find help tags" })
        vim.keymap.set("n", "<leader>fg", ":Telescope git_files<CR>", { desc = "Fuzzy find files tracked by Git" })
        vim.keymap.set("n", "<leader>hf", ":Telescope git_status<CR>", { desc = "Fuzzy find Git Status" })
        vim.keymap.set("n", "<leader>ft", ":TodoTelescope<CR>", { desc = "Fuzzy find todos" })
        vim.keymap.set("n", "<leader>fd", ":Telescope diagnostics<CR>", { desc = "Fuzzy find diagnostics" })
        vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Fuzzy find kaymaps" })
    end,
}
