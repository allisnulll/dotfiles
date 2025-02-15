return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    cond = function()
        return not vim.fn.getcwd():match("/home/allisnull/Vault")
    end,
    ---@module "render-markdown"
    ---@type render.mc.UserConfig
    config = function()
        require("render-markdown").setup({
            debounce = 100,
            pipe_table = {
                preset = "round",
                alignment_indicator = "┅",
            },
            file_types = { "markdown", "text", "dart" },
            injections = {
                dart = {
                    enabled = true,
                    query = [[
                        ((comment) @injection.content
                            (#set! injection.language "markdown"))
                    ]],
                },
            },
        })

        vim.keymap.set("n", "<leader>md", ":RenderMarkdown toggle<CR>", { desc = "Toggle RenderMarkdown" })
    end
}
