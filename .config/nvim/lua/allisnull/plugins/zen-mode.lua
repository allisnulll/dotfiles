return {
    "folke/zen-mode.nvim",
    config = function()
        require("zen-mode").setup({
            window = {
                width = 84,
                options = {
                    signcolumn = "no",
                    colorcolumn = "0",
                    wrap = true,
                    foldcolumn = "1",
                    foldlevel = 99,
                    foldlevelstart = 99,
                    foldenable = true,
                    fillchars = "foldopen:,foldclose:,eob: ,fold: ,foldsep: ,foldinner: ",
                },
            },

            on_open = function(_)
                -- TODO: Figure out alternative to unloading which-key to disable it on zen-mode https://github.com/folke/which-key.nvim/discussions/510
                vim.fn.system("tmux set status off")
                vim.fn.system('tmux list-panes -F "\\#F" | grep -q Z || tmux resize-pane -Z')
                vim.fn.system("kitten @ set-font-size +2")
                vim.diagnostic.enable(false)
            end,

            on_close = function(_)
                vim.fn.system("tmux set status on")
                vim.fn.system('tmux list-panes -F "\\#F" | grep -q Z && tmux resize-pane -Z')
                vim.fn.system("kitten @ set-font-size 0")
                vim.diagnostic.enable()
            end,
        })

        vim.keymap.set("n", "<M-z>", ":ZenMode<CR>", { desc = "Enter ZenMode" })
    end,
}
