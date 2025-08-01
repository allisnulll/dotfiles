-- Options
vim.opt.clipboard = "unnamedplus"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.hlsearch = false
vim.opt.cursorline = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.swapfile = false

vim.opt.updatetime = 500

vim.opt.listchars = {
    space = "◦",
    tab = "»—",
    extends = "→",
    precedes = "←",
    nbsp = "␣",
    trail = "×",
    eol = "⏎",
}

vim.g.mapleader = " "

-- Keymaps
local function to_fold_level()
    vim.api.nvim_echo({{ "Fold Level: ", "Normal" }}, false, {})
    local char = vim.fn.getchar()
    local input = vim.fn.nr2char(char)
    local level = tonumber(input)

    if not level then
        vim.notify("Invalid input", vim.log.levels.INFO)
        return 0
    end

    vim.api.nvim_echo({{ "Fold Level: " .. tostring(level), "Normal" }}, false, {})

    if level == 0 then
        level = 100
    end

    vim.opt.foldlevel = level - 1
end

local function to_heading_level()
    vim.api.nvim_echo({{ "Heading Level: ", "Normal" }}, false, {})
    local char = vim.fn.getchar()
    local input = vim.fn.nr2char(char)
    local level = tonumber(input)

    if not level then
        vim.notify("Invalid input", vim.log.levels.INFO)
        return 0
    end

    vim.api.nvim_echo({{ "Heading Level: " .. tostring(level), "Normal" }}, false, {})

    local pattern = "^" .. string.rep("#", level) .. " "
    local curpos = vim.fn.getpos(".")

    for lnum = 1, vim.fn.line("$") do
        local line = vim.fn.getline(lnum)
        if line:match(pattern) then
            vim.api.nvim_win_set_cursor(0, { lnum, 0 })
            vim.cmd("normal! za")
        end
    end

    vim.fn.setpos(".", curpos)
end

local function toggle_fold()
    local line = vim.fn.line(".")
    local foldlevel = vim.fn.foldlevel(line)

    if foldlevel == 0 then
        vim.cmd("normal! <CR>")
    else
        vim.cmd("normal! za")
    end
end

local function highest_fold()
    local max_fold = 0
    for line = 1, vim.api.nvim_buf_line_count(0) do
        local fold_level = vim.fn.foldlevel(line)
        if fold_level > max_fold then
            max_fold = fold_level
        end
    end

    return max_fold
end

local function fold_more()
    local foldlevel = vim.wo.foldlevel
    if foldlevel == 0 then
        return
    end

    local highestfold = highest_fold()
    if foldlevel > highestfold then
        vim.opt.foldlevel = highestfold
    else
        vim.opt.foldlevel = foldlevel - 1
    end
end

vim.keymap.set({ "n", "i", "v" }, "<C-z>", "")

vim.keymap.set("n", "Y", "y$", { desc = "Yank to eol" })

vim.keymap.set({ "n", "v" }, "g/", "/\\v^((.**)@!.)*$" .. string.rep("<Left>", 8), { desc = "Inverse Search" })

vim.keymap.set("n", "<Tab>", toggle_fold, { desc = "Toggle fold" })
vim.keymap.set("n", "<F14>", fold_more, { desc = "+ Fold level"})
vim.keymap.set("n", "<F15>", ":normal! zr<CR>", { desc = "- Fold level" })
vim.keymap.set("n", "zm", fold_more, { desc = "Fold more"})
vim.keymap.set("n", "zl", to_fold_level, { desc = "To fold level" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })
vim.keymap.set("n", "n", "nzzzv", { desc = 'Repeat the latest "/" or "?"' })
vim.keymap.set("n", "N", "Nzzzv", { desc = 'Repeat the latest "/" or "?" in reverse' })

vim.keymap.set("n", "<C-w><", "5<C-w><")
vim.keymap.set("n", "<C-w>>", "5<C-w>>")
vim.keymap.set("n", "<C-w>+", "2<C-w>+")
vim.keymap.set("n", "<C-w>-", "2<C-w>-")

vim.keymap.set("n", "<leader>o", "", { desc = "Options" })
vim.keymap.set("n", "<leader>oc", ":nohl<CR>", { desc = "Clear search highlights" })
vim.keymap.set("n", "<leader>ol", ":set list!<CR>", { desc = "Toggle listchars" })
vim.keymap.set("n", "<leader>ot", ":set expandtab!<CR>", { desc = "Toggle expandtab" })
vim.keymap.set("n", "<leader>or", ":set relativenumber!<CR>", { desc = "Toggle relativenumber" })
vim.keymap.set("n", "<leader>oh", ":set hlsearch!<CR>", { desc = "Toggle hlsearch" })
vim.keymap.set("n", "<leader>ow", ":set wrap!<CR>", { desc = "Toggle wrap" })

vim.keymap.set("n", "<leader>m", "", { desc = "Markup" })
vim.keymap.set("n", "<leader>mh", to_heading_level, { desc = "Fold Header Level" })

-- Plugins
vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/kevinhwang91/promise-async" },
    { src = "https://github.com/kevinhwang91/nvim-ufo" },
    { src = "https://github.com/folke/tokyonight.nvim" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/folke/zen-mode.nvim" },
    { src = "https://github.com/folke/todo-comments.nvim" },
    { src = "https://github.com/norcalli/nvim-colorizer.lua" },
    { src = "https://github.com/chentoast/marks.nvim" },
    { src = "https://github.com/echasnovski/mini.ai" },
    { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
    { src = "https://github.com/iamcco/markdown-preview.nvim" },
})

-- Treesitter
require("nvim-treesitter.configs").setup({
    highlight = { enable = true },
    auto_install = true,
    ensure_installed = {
        "json",
        "javascript",
        "yaml",
        "toml",
        "html",
        "css",
        "gitignore",
        "java",
        "dart",
        "bash",
        "c",
        "lua",
        "markdown",
        "latex",
        "python",
        "vim",
        "vimdoc",
        "query",
        "scheme",
        "commonlisp",
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<C-Space>",
            node_incremental = "<C-Space>",
            scope_incremental = false,
            node_decremental = "<bs>",
        },
    },
})

-- Ufo
local ufo = require("ufo")

vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

vim.keymap.set("n", "zR", ufo.openAllFolds)
vim.keymap.set("n", "zM", ufo.closeAllFolds)
vim.keymap.set("n", "<C-f>", function()
    local winid = ufo.peekFoldedLinesUnderCursor()
    if not winid then
        vim.lsp.buf.hover()
    end
end, { desc = "UFO Fold Preview" })

ufo.setup({
    provider_selector = function(bufnr, filetype, buftype)
        return {"treesitter", "indent"}
    end
})

-- Colorscheme
require("tokyonight").setup({
    style = "night",
    transparent = true,
    styles = {
        floats = "transparent",
        comments = { italic = true },
    },
})

vim.cmd("colorscheme tokyonight")
vim.cmd(":hi statusline guibg=NONE")

-- WhickKey
local whichkey = require("which-key")
whichkey.add({{ "<C-z>", hidden = true }})
whichkey.setup({ delay = function(ctx) return ctx.plugin and 0 or 300 end })

vim.keymap.set("n", "?", whichkey.show, { desc = "Buffer Glabal Keymaps" })
vim.keymap.set("n", "<leader>?", function()
    whichkey.show({ global = false })
end, { desc = "Buffer Local Keymaps" })

-- ZenMode
require("zen-mode").setup({
    window = {
        width = 84,
        options = {
            signcolumn = "no",
            colorcolumn = "0",
            laststatus = 0,
            wrap = true,
        },
    },
    plugins = {
        enable = true,
        rules = false,
        showcmd = false,
    },
    gitsigns = { enabled = false },

    on_open = function(_)
        -- NOTE: Figure out how to toggle which-key https://github.com/folke/which-key.nvim/discussions/510
        vim.fn.system("tmux set status off")
        vim.fn.system('tmux list-panes -F "\\#F" | grep -q Z || tmux resize-pane -Z')
        vim.fn.system("kitten @ set-font-size +6")
        vim.diagnostic.enable(false)

        vim.keymap.set("n", "<M-j>", "gj", { noremap = true, silent = true, buffer = true })
        vim.keymap.set("n", "<M-k>", "gk", { noremap = true, silent = true, buffer = true })
    end,
    on_close = function(_)
        vim.fn.system("tmux set status on")
        vim.fn.system('tmux list-panes -F "\\#F" | grep -q Z && tmux resize-pane -Z')
        vim.fn.system("kitten @ set-font-size 0")
        vim.diagnostic.enable()

        if not vim.fn.getcwd():match("/home/allisnull/Vault") then
            vim.api.nvim_buf_del_keymap(0, "n", "<M-j>")
            vim.api.nvim_buf_del_keymap(0, "n", "<M-k>")
        end
    end,
})

vim.keymap.set("n", "<leader>z", ":ZenMode<CR>", { desc = "ZenMode" })

-- TodoComments
local todo_comments = require("todo-comments")

vim.keymap.set("n", "]t", todo_comments.jump_next, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", todo_comments.jump_prev, { desc = "Previous todo comment" })

todo_comments.setup()

-- Colorizer
require("colorizer").setup({
    "*",
    "!dart",
    html = { names = true, mode = "foreground" },
    css = { css = true, mode = "foreground" },
}, { names = false, RRGGBBAA = true })

vim.keymap.set("n", "<leader>mc", ":ColorizerToggle<CR>", { desc = "Toggle Colorizer" })
-- Mini.ai
local function ai_line(ai_type)
    local lnum = vim.fn.line(".")
    local line = vim.fn.getline(lnum)

    return {
        from = { line = lnum, col = ai_type == "i" and line:find("%S") or 1 },
        to = { line = lnum, col = #line },
    }
end

local function ai_buffer(ai_type)
    local start_line = 1
    local end_line = vim.fn.line("$")
    if ai_type == "i" then
        local first_nonblank = vim.fn.nextnonblank(start_line)
        local last_nonblank = vim.fn.prevnonblank(end_line)

        if first_nonblank == 0 or last_nonblank == 0 then
            return { from = { line = start_line, col = 1 } }
        end

        start_line = first_nonblank
        end_line = last_nonblank
    end

    local to_col = math.max(vim.fn.getline(end_line):len(), 1)

    return {
        from = { line = start_line, col = 1 },
        to = { line = end_line, col = to_col },
    }
end

local spec_treesitter = require("mini.ai").gen_spec.treesitter

require("mini.ai").setup({
    n_lines = 500,
    custom_textobjects = {
        g = ai_buffer,
        l = ai_line,
        F = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
        o = spec_treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
        }),
        c = spec_treesitter({ a = "@class.outer", i = "@class.inner" }),
        d = { "%f[%d]%d+" },
        e = {
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
        },
    },
    mappings = {
        around_next = "aj",
        inside_next = "ij",
        around_last = "ak",
        inside_last = "ik",
    },
})

-- Markdown Render
require("render-markdown").setup({
    preset = "obsidian",
    heading = { sign = false },
    code = { sign = false },
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

-- Markdown Preview
vim.g.mkdp_filetypes = { "markdown" }
vim.keymap.set("n", "<leader>mp", ":MarkdownPreviewToggle<CR>", { desc = "Toggle MarkdownPreview" })
