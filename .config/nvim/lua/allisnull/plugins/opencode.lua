return {
    "NickvanDyke/opencode.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
        local started = false

        vim.g.opencode_opts = {
            server = {
                start = function()
                    if not started then
                        started = true

                        vim.system({"tmux", "split-window", "-h", "-l", "40%", "opencode", "--port"}):wait()
                        vim.system({"tmux", "select-pane", "-l"})

                        vim.defer_fn(function()
                            vim.cmd("horizontal wincmd =")
                        end, 100)
                    end
                end,
                stop = function()
                    if started then
                        started = false
                        local pane_id, pane_pid = vim.fn.system("tmux list-panes -F '#{pane_id} #{pane_pid} #{pane_current_command}' -t . | grep opencode"):match("(%S+)%s+(%S+)")

                        vim.system({"kill", "-9", pane_pid})
                        vim.system({"tmux", "kill-pane", "-t", pane_id})

                        vim.defer_fn(function()
                            vim.cmd("horizontal wincmd =")
                        end, 100)
                    end
                end,
                toggle = function()
                    local output = vim.fn.system("tmux list-panes -F '#{pane_current_command}' -t . | grep opencode")
                    if output == "" then
                        vim.g.opencode_opts.server.start()
                    else
                        vim.g.opencode_opts.server.stop()
                    end
                end,
            }
        }

        vim.api.nvim_create_autocmd("VimLeave", {
            callback = vim.g.opencode_opts.server.stop,
        })

        vim.o.autoread = true

        local opencode = require("opencode")

        vim.keymap.set({ "n", "x" }, "<M-a><M-a>", function() opencode.select() end, { desc = "Execute opencode action…" })
        vim.keymap.set({ "n", "x" }, "<M-a>a", function() opencode.ask("@this: ") end, { desc = "Ask opencode" })
        vim.keymap.set({ "n", "x" }, "<M-a>A", function() opencode.prompt("@this") end, { desc = "Add line to opencode" })
        vim.keymap.set({ "n", "x" }, "<M-a>b", function() opencode.ask("@buffer: ") end, { desc = "Ask opencode about buffer" })
        vim.keymap.set({ "n", "x" }, "<M-a>B", function() opencode.prompt("@buffer: ") end, { desc = "Add buffer to opencode" })
        vim.keymap.set({ "n", "x" }, "<M-a>v", function() opencode.ask("@visible: ") end, { desc = "Ask opencode about visible text" })
        vim.keymap.set({ "n", "x" }, "<M-a>e", function() opencode.ask("@diagnostics: ") end, { desc = "Ask opencode about diagnostics" })
        vim.keymap.set({ "n", "x" }, "<M-a>q", function() opencode.ask("@quickfix: ") end, { desc = "Ask opencode about quickfix list" })
        vim.keymap.set({ "n", "x" }, "<M-a>d", function() opencode.ask("@diff: ") end, { desc = "Ask opencode about diff" })

        vim.keymap.set({ "n", "x" }, "<M-a>t", vim.g.opencode_opts.server.toggle, { desc = "Toggle opencode" })

        vim.keymap.set({ "n", "i" }, "<M-PageUp>", function() opencode.command("session.page.up") end, { desc = "opencode page up" })
        vim.keymap.set({ "n", "i" }, "<M-PageDown>", function() opencode.command("session.page.down") end, { desc = "opencode page down" })
    end,
}
