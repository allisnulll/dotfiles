return {
    "NickvanDyke/opencode.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
        vim.g.opencode_opts = {
            server = {
                start = function()
                    vim.system({"tmux", "split-window", "-h", "-l", "40%", "opencode", "--agent", "plan", "--port"}):wait()
                    vim.system({"tmux", "select-pane", "-l"})

                    vim.defer_fn(function()
                        vim.cmd("horizontal wincmd =")
                    end, 100)
                end,
                stop = function()
                    local pane_id, pane_pid = vim.fn.system("tmux list-panes -F '#{pane_id} #{pane_pid} #{pane_current_command}' -t . | grep opencode"):match("(%S+)%s+(%S+)")

                    vim.system({"kill", "-9", pane_pid})
                    vim.system({"tmux", "kill-pane", "-t", pane_id})

                    vim.defer_fn(function()
                        vim.cmd("horizontal wincmd =")
                    end, 100)
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

        vim.keymap.set({ "n", "x" }, "<M-a><M-a>", function() opencode.ask("@this: ", { submit = true }) end, { desc = "Ask opencode" })
        vim.keymap.set({ "n", "x" }, "<M-a>a", function() opencode.select() end, { desc = "Execute opencode action…" })
        vim.keymap.set({ "n", "x" }, "<M-a>b", function() opencode.ask("@buffer: ", { submit = true }) end, { desc = "Ask opencode about buffer" })
        vim.keymap.set({ "n", "x" }, "<M-a>a", function() opencode.ask("@buffers: ", { submit = true }) end, { desc = "Ask opencode about all buffers" })
        vim.keymap.set({ "n", "x" }, "<M-a>v", function() opencode.ask("@visible: ", { submit = true }) end, { desc = "Ask opencode about visible text" })
        vim.keymap.set({ "n", "x" }, "<M-a>e", function() opencode.ask("@diagnostics: ", { submit = true }) end, { desc = "Ask opencode about diagnostics" })
        vim.keymap.set({ "n", "x" }, "<M-a>q", function() opencode.ask("@quickfix: ", { submit = true }) end, { desc = "Ask opencode about quickfix list" })
        vim.keymap.set({ "n", "x" }, "<M-a>d", function() opencode.ask("@diff: ", { submit = true }) end, { desc = "Ask opencode about diff" })

        vim.keymap.set({ "n", "x" }, "gA", function() opencode.prompt("@this") end, { desc = "Add to opencode" })
        vim.keymap.set({ "n", "t" }, "<M-.>", opencode.toggle, { desc = "Toggle opencode" })

        vim.keymap.set({ "n", "i" }, "<M-PageUp>", function() opencode.command("session.page.up") end, { desc = "opencode page up" })
        vim.keymap.set({ "n", "i" }, "<M-PageDown>", function() opencode.command("session.page.down") end, { desc = "opencode page down" })
    end,
}
