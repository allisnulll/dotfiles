return {
    "ej-shafran/compile-mode.nvim",
    branch = "nightly",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "m00qek/baleia.nvim", tag = "v1.3.0" },
    },
    config = function()
        vim.g.compile_mode = {
            default_command = "",
            ask_about_save = false,
            ask_to_interrupt = false,
            auto_jump_to_first_error = true,
            baleia_setup = true,
            bang_expansion = true,
            focus_compilation_buffer = true,
        }

        local compile_mode = require("compile-mode")

        vim.keymap.set("n", "<F5>", function()
            vim.ui.input({ prompt = "Compile command: " }, function(command)
                if command and command ~= "" then
                    vim.cmd("vert Compile " .. command)
                    vim.defer_fn(compile_mode.send_to_qflist, 100)
                end
            end)
        end, { desc = "Compile Mode" })
        vim.keymap.set("n", "<F6>", function()
            vim.cmd("vert Recompile")
            vim.defer_fn(compile_mode.send_to_qflist, 100)
        end, { desc = "Recompile Mode" })
    end
}
