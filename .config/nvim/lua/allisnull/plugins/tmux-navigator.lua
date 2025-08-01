return {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
    cond = function()
        local term = os.getenv("TERM")
        return term and string.find(term, "tmux")
    end,
}
