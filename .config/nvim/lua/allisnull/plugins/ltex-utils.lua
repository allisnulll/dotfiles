return {
    "jhofscheier/ltex-utils.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-telescope/telescope.nvim",
        "nvim-telescope/telescope-fzf-native.nvim",
    },
    -- NOTE: From PR https://github.com/jhofscheier/ltex-utils.nvim/pull/21/commits
    commit = "f9bc136ca20f38233826faee7854d944fcaf49ac",
    opts = {
        dictionary = {
            path = vim.api.nvim_call_function("stdpath", {"config"}) .. "/spell/ltex",
        },
    },
}
