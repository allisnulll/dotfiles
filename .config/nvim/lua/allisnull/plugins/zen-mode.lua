return {
    "folke/zen-mode.nvim",
    config = function()
        require("zen-mode").setup({
            window = {
                width = 84,
                options = {
                    signcolumn = "no",
                    colorcolumn = "0",
                    laststatus = 0,
                    wrap = true,
               },
            },
            plugins = {
                enable = true,
                rules = false,
                showcmd = false,
            },
            gitsigns = { enabled = false },
            wezterm = { enabled = true },

            -- Disable Tmux statusline and LSP Diagnostics
            on_open = function(_)
                vim.fn.system([[tmux set status off]])
                vim.fn.system([[tmux list-panes -F "\#F" | grep -q Z || tmux resize-pane -Z]])
                vim.diagnostic.enable(false)
            end,
            on_close = function(_)
                vim.fn.system([[tmux set status on]])
                vim.fn.system([[tmux list-panes -F "\#F" | grep -q Z && tmux resize-pane -Z]])
                vim.diagnostic.enable()
            end,
        })

        vim.keymap.set("n", "<leader>zm", ":ZenMode<CR>", { desc = "Enter ZenMode" })
    end,
}
