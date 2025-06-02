return {
    "folke/snacks.nvim",
    priority = 1000,
    ---@type snacks.Config
    opts = {
        styles = {
            snacks_image = {
                relative = "editor",
                col = -1,
            },
        },
        image = {
            enabled = true,
            doc = {
                inline = false,
                float = true,
                max_width = 60,
                max_height = 30,
            },
        },
    },
}
