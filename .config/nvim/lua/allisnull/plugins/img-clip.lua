return {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
        default = {
            dir_path = function()
                return vim.fn.expand("%:t:r") .. "-img"
            end,
            use_absolute_path = false,
            relative_to_current_file = true,
            prompt_for_file_name = false,
            file_name = "%Y-%m-%d-at-%H-%M-%S",
            extension = "avif",
            process_cmd = "convert - -quality 75 avif:-",
        },
        filetypes = {
            markdown = {
                url_encode_path = true,
                template = "![$FILE_NAME]($FILE_PATH)",
            },
        },
        dirs = {
            ["~/Vault"] = { dir_path = "assets/images" },
        },
    },
    keys = {{ "<leader>p", ":PasteImage<CR>", desc = "Paste image from system clipboard" }},
}
