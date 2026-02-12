return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "theHamsta/nvim-dap-virtual-text",
        "igorlfs/nvim-dap-view",
    },
    keys = {
        { "<M-d><M-d>", ":DapViewToggle<CR>", { desc = "DapViewToggle" }},
        { "<M-d>b", ":DapToggleBreakpoint<CR>", { desc = "DapToggleBreakpoint" }},
        { "<M-d>c", ":DapContinue<CR>", { desc = "DapContinue" }},
        { "<M-d>w", ":DapViewWatch<CR>", { desc = "DapViewWatch" }},
        { "<M-d>s", ":DapStepOver<CR>", { desc = "DapStepOver" }},
        { "<M-d>i", ":DapStepInto<CR>", { desc = "DapStepInto" }},
        { "<M-d>o", ":DapStepOut<CR>", { desc = "DapStepOut" }},
        { "<M-d>p", ":DapStepPause<CR>", { desc = "DapStepPause" }},
        { "<M-d>k", ":DapTerminate<CR>", { desc = "DapTerminate" }},
    },
    config = function()
        require("nvim-dap-virtual-text").setup()

        local dap = require("dap")

        dap.adapters.gdb = {
            type = "executable",
            command = "gdb",
            args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
        }
        dap.configurations.c = {
            {
                name = "Launch",
                type = "gdb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                args = {},
                cwd = "${workspaceFolder}",
                stopAtBeginningOfMainSubprogram = false,
            },
            {
                name = "Select and attach to process",
                type = "gdb",
                request = "attach",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                pid = function()
                    local name = vim.fn.input("Executable name (filter): ")
                    return require("dap.utils").pick_process({ filter = name })
                end,
                cwd = "${workspaceFolder}"
            },
            {
                name = "Attach to gdbserver :1234",
                type = "gdb",
                request = "attach",
                target = "localhost:1234",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}"
            }
        }
        dap.configurations.cpp = dap.configurations.c

        dap.adapters["rust-gdb"] = {
            type = "executable",
            command = "rust-gdb",
            args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
        }
        dap.configurations.rust = {
            {
                name = "Launch",
                type = "rust-gdb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                args = {}, -- provide arguments if needed
                cwd = "${workspaceFolder}",
                stopAtBeginningOfMainSubprogram = false,
            },
            {
                name = "Select and attach to process",
                type = "rust-gdb",
                request = "attach",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                pid = function()
                    local name = vim.fn.input("Executable name (filter): ")
                    return require("dap.utils").pick_process({ filter = name })
                end,
                cwd = "${workspaceFolder}"
            },
            {
                name = "Attach to gdbserver :1234",
                type = "rust-gdb",
                request = "attach",
                target = "localhost:1234",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}"
            }
        }
    end,
}
