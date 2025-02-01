return {
    "wa11breaker/flutter-bloc.nvim",
    dependencies = {
        "nvimtools/none-ls.nvim",
    },
    config = function()
        local flutter_bloc = require("flutter-bloc")

        flutter_bloc.setup({
            bloc_type = "equatable",
            use_sealed_classes = true,
            enable_code_actions = true,
        })

        vim.keymap.set("n", "<leader>flb", function()
            flutter_bloc.create_bloc()
        end, { desc = "Create Flutter Bloc" })

        vim.keymap.set("n", "<leader>flc", function()
            flutter_bloc.create_cubit()
        end, { desc = "Create Flutter Cubit" })
    end,
}
