return {
    "akinsho/flutter-tools.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "stevearc/dressing.nvim",
    },
    config = function()
        require("flutter-tools").setup({
            decorations = {
                statusline = {
                    app_version = true,
                    device = true,
                },
            },
            flutter_path = "/home/allisnull/flutter/bin/flutter",
            widget_guides = { enabled = true },
            lsp = {
                color = {
                    enabled = true,
                    background = true,
                    background_color = { r = 26, g = 27, b = 38},
                },
            },
        })

        -- local lsp_color_enabled = true
        -- local toggle_lsp_color = function()
        --     lsp_color_enabled = not lsp_color_enabled
        --     flutter_tools.setup({ lsp = { color = { enabled = lsp_color_enabled } } })
        --     vim.notify("Flutter color enabled: " .. tostring(lsp_color_enabled), vim.log.levels.INFO)
        -- end

        vim.keymap.set("n", "<leader>fl", "", { desc = "Flutter" })
        vim.keymap.set("n", "<leader>fl<CR>", ":FlutterRun --enable-software-rendering<CR>", { desc = "Flutter Run" })
        vim.keymap.set("n", "<leader>flr", ":FlutterReload<CR>", { desc = "Flutter Reload" })
        vim.keymap.set("n", "<leader>flR", ":FlutterRestart<CR>", { desc = "Flutter Restart" })
        vim.keymap.set("n", "<leader>flq", ":FlutterQuit<CR>", { desc = "Flutter Quit" })
        vim.keymap.set("n", "<leader>fle", ":FlutterEmulators<CR>", { desc = "Flutter show list of emulators" })
        vim.keymap.set("n", "<leader>flt", ":FlutterDevToolsActivate<CR>", { desc = "Flutter Activate DevTools" })
        vim.keymap.set("n", "<leader>fls", ":FlutterLspRestart<CR>", { desc = "Flutter Restart Lsp" })
        vim.keymap.set("n", "<leader>flo", ":FlutterOutlineToggle<CR>", { desc = "Flutter Outline Toggle" })
        vim.keymap.set("n", "<leader>flp", ":FlutterPubGet<CR>", { desc = "Flutter Pub Get" })
        vim.keymap.set("n", "<leader>fll", ":FlutterLogClear<CR>", { desc = "Flutter Log Clear" })
    end,
}
