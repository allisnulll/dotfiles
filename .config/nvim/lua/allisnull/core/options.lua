vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.cursorline = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.backspace = "indent,eol,start"

vim.opt.nrformats = "unsigned,bin,hex"

vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vim.opt.undofile = true
vim.opt.undolevels = 5000

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

vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.fillchars = {
    eob = " ",
    fold = " ",
    foldopen = "",
    foldsep = " ",
    foldclose = "",
    foldinner = " ",
}

vim.g.netrw_browse_split = 0
vim.g.netrw_winsize = 25

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.g["conjure#highlight#enabled"] = true

if vim.g.neovide then
    vim.keymap.set({ "n", "v" }, "<C-p>", '"+p', { desc = "Paste" })
    -- vim.keymap.set({ "c", "i" }, "<C-p>", "<C-r>+", { desc = "Paste" }) -- TODO: Figure out how to map <C-p> in insert mode without being overriden by completions system
    vim.keymap.set("c", "<C-p>", "<C-r>+", { desc = "Paste" })

    vim.g.neovide_padding_top = 8
    vim.g.neovide_padding_bottom = 8
    vim.g.neovide_padding_right = 8
    vim.g.neovide_padding_left = 8
    vim.g.neovide_opacity = 0.75
    vim.o.guifont = "Maple Mono NF:h12"
    vim.g.neovide_refresh_rate = 144
    vim.g.neovide_cursor_animation_length = 0.04
    vim.g.neovide_cursor_trail_size = 0.7
    -- vim.g.neovide_cursor_vfx_mode = "sonicboom"
end
