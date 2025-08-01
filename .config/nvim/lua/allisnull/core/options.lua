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
-- vim.opt.scrolloff = 4

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.backspace = "indent,eol,start"

vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vim.opt.undofile = true

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

vim.g.netrw_browse_split = 0
vim.g.netrw_winsize = 25

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.g["conjure#highlight#enabled"] = true
