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

            on_open = function(_)
                -- TODO: Figure out how to unload which-key on zen-mode https://github.com/folke/which-key.nvim/discussions/510
                vim.fn.system("tmux set status off")
                vim.fn.system('tmux list-panes -F "\\#F" | grep -q Z || tmux resize-pane -Z')
                vim.fn.system("kitten @ set-font-size +2")
                vim.diagnostic.enable(false)

                vim.keymap.set("n", "<M-j>", "gj", { noremap = true, silent = true, buffer = true })
                vim.keymap.set("n", "<M-k>", "gk", { noremap = true, silent = true, buffer = true })
            end,
            on_close = function(_)
                vim.fn.system("tmux set status on")
                vim.fn.system('tmux list-panes -F "\\#F" | grep -q Z && tmux resize-pane -Z')
                vim.fn.system("kitten @ set-font-size 0")
                vim.diagnostic.enable()

                if not vim.fn.getcwd():match("/home/allisnull/Vault") then
                    vim.api.nvim_buf_del_keymap(0, "n", "<M-j>")
                    vim.api.nvim_buf_del_keymap(0, "n", "<M-k>")
                end
            end,
        })

        vim.keymap.set("n", "<leader>zm", ":ZenMode<CR>", { desc = "Enter ZenMode" })
    end,
}
