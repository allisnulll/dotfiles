return {
    "knubie/vim-kitty-navigator",
    event = "VeryLazy",
    build = "cp ./*.py ~/.config/kitty/",
    cond = function()
        local term = os.getenv("TERM")
        return term and string.find(term, "kitty")
    end
}
