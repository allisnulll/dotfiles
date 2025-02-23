return {
    "folke/snacks.nvim",
    priority = 1000,
    ---@type snacks.Config
    opts = {
        image = {
            enabled = true,
            doc = {
                inline = true,
                float = true,
                max_width = 60,
                max_height = 30,
            },
        },
    },
}
