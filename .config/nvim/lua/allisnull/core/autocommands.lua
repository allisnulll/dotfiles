-- TODO: figure out how to only use nvim-ufo on files with no mkview
-- local function get_view_files()
--     local viewdir = vim.opt.viewdir
--     if viewdir == "" then
--         viewdir = vim.fn.stdpath("state") .. "/view"
--     end
--
--     local patterns = {}
--
--     local files = vim.fn.glob(viewdir .. "/*", true, true)
--     for _, filepath in ipairs(files) do
--         local file = filepath:gsub("=+", "/"):sub(1, -2)
--
--         if file then
--             table.insert(patterns, file)
--         end
--     end
--
--     return patterns
-- end

-- NOTE: https://www.reddit.com/r/neovim/comments/146n4yy/what_is_the_smartest_condition_you_have_used_to/
-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--     pattern = get_view_files(),
--     command = "doautocmd User ufo",
-- })

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 100 })
    end,
})

vim.api.nvim_create_augroup("Text", { clear = true})
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "text", "markdown" },
    group = "Text",
    callback = function()
        vim.opt.spell = true
    end,
})

vim.api.nvim_create_augroup("HelpBuffer", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = "HelpBuffer",
    pattern = "help",
    command = "only",
})

vim.api.nvim_create_augroup("TwoSpaceGroup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "dart", "yaml", "lisp", "scheme", "nix" },
    group = "TwoSpaceGroup",
    callback = function()
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
        vim.opt.softtabstop = 2
    end,
})

vim.api.nvim_create_augroup("TabGroup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "txt", "go", "makefile", "haskell" },
    group = "TabGroup",
    callback = function()
        vim.opt.expandtab = false
    end,
})

vim.api.nvim_create_augroup("Obsidian", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = vim.fn.expand("~") .. "/Vault/*.md",
    group = "Obsidian",
    callback = function()
        vim.opt.conceallevel = 1
        vim.opt.wrap = true

        vim.keymap.set("n", "<M-j>", "gj", { noremap = true, silent = true, buffer = true })
        vim.keymap.set("n", "<M-k>", "gk", { noremap = true, silent = true, buffer = true })
    end,
})
