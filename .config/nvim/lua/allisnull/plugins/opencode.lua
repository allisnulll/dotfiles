return {
    "NickvanDyke/opencode.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
        vim.o.autoread = true

        local opencode = require("opencode")

        vim.keymap.set({ "n", "x" }, "<M-a><M-a>", function()
            opencode.ask("@this: ", { submit = true })
        end, { desc = "Ask opencode" })
        vim.keymap.set({ "n", "x" }, "<M-a>b", function()
            opencode.ask("@buffer: ", { submit = true })
        end, { desc = "Ask opencode about buffer" })
        vim.keymap.set({ "n", "x" }, "<M-a>a", function()
            opencode.ask("@buffers: ", { submit = true })
        end, { desc = "Ask opencode about all buffers" })
        vim.keymap.set({ "n", "x" }, "<M-a>v", function()
            opencode.ask("@visible: ", { submit = true })
        end, { desc = "Ask opencode about visible text" })
        vim.keymap.set({ "n", "x" }, "<M-a>e", function()
            opencode.ask("@diagnostics: ", { submit = true })
        end, { desc = "Ask opencode about diagnostics" })
        vim.keymap.set({ "n", "x" }, "<M-a>q", function()
            opencode.ask("@quickfix: ", { submit = true })
        end, { desc = "Ask opencode about quickfix list" })
        vim.keymap.set({ "n", "x" }, "<M-a>d", function()
            opencode.ask("@diff: ", { submit = true })
        end, { desc = "Ask opencode about diff" })

        vim.keymap.set({ "n", "x" }, "<M-x>", function()
            opencode.select()
        end, { desc = "Execute opencode action…" })

        vim.keymap.set({ "n", "x" }, "gA", function()
            opencode.prompt("@this")
        end, { desc = "Add to opencode" })
        vim.keymap.set({ "n", "t" }, "<M-.>", opencode.toggle, { desc = "Toggle opencode" })

        vim.keymap.set("n", "<M-PageUp>", function()
            opencode.command("session.page.up")
        end, { desc = "opencode page up" })
        vim.keymap.set("n", "<M-PageDown>", function()
            opencode.command("session.page.down")
        end, { desc = "opencode page down" })
    end,
}
