return {
    "knubie/vim-kitty-navigator",
    event = "VeryLazy",
    build = "cp ./*.py ~/.config/kitty/",
    cond = os.getenv("TERM") and string.find(os.getenv("TERM"), "kitty")
}
