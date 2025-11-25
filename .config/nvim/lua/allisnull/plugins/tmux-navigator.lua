return {
    "christoomey/vim-tmux-navigator",
    cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
        "TmuxNavigatorProcessList",
    },
    keys = {
        { "<C-h>", ":TmuxNavigateLeft<CR>" },
        { "<C-j>", ":TmuxNavigateDown<CR>" },
        { "<C-k>", ":TmuxNavigateUp<CR>" },
        { "<C-l>", ":TmuxNavigateRight<CR>" },
        { "<C-Left>", ":TmuxNavigateLeft<CR>" },
        { "<C-Down>", ":TmuxNavigateDown<CR>" },
        { "<C-Up>", ":TmuxNavigateUp<CR>" },
        { "<C-Right>", ":TmuxNavigateRight<CR>" },
        { "<C-\\>", ":TmuxNavigatePrevious<CR>" },
    },
}
