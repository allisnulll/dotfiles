-- Functions
local function swap_win(direction)
    local cur_win = vim.api.nvim_get_current_win()
    local cur_buf = vim.api.nvim_win_get_buf(cur_win)
    local cur_cursor = vim.api.nvim_win_get_cursor(cur_win)

    vim.cmd("wincmd " .. direction)

    local target_win = vim.api.nvim_get_current_win()
    if target_win == cur_win then return end
    local target_buf = vim.api.nvim_win_get_buf(target_win)
    local target_cursor = vim.api.nvim_win_get_cursor(target_win)

    vim.api.nvim_win_set_buf(cur_win, target_buf)
    vim.api.nvim_win_set_buf(target_win, cur_buf)

    vim.api.nvim_win_set_cursor(cur_win, target_cursor)
    vim.api.nvim_win_set_cursor(target_win, cur_cursor)
end

local function join_at_column()
    local col = vim.fn.col(".")
    vim.cmd("norm! J" .. col .. "|")
end

local function g_join_at_column()
    local col = vim.fn.col(".")
    vim.cmd("norm! gJ" .. col .. "|")
end

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

    vim.cmd("norm! zR")
    for lnum = 1, vim.fn.line("$") do
        local line = vim.fn.getline(lnum)
        if line:match(pattern) then
            vim.api.nvim_win_set_cursor(0, { lnum, 0 })
            vim.cmd("norm! za")
        end
    end

    vim.fn.setpos(".", curpos)
end

local function to_column()
    local input = vim.fn.input("{+|-}Column: ")
    local sign, num = input:match("([+-]?)(%d+)")

    if not num then
        return vim.notify("Invalid input", vim.log.levels.INFO)
    end

    local current_col = vim.fn.col(".")
    local target_col = tonumber(num)
    local spaces_needed

    if sign == "+" then
        spaces_needed = target_col
    elseif sign == "-" then
        spaces_needed = -target_col
    else
        spaces_needed = target_col - current_col
    end

    if spaces_needed > 0 then
        vim.api.nvim_put({string.rep(" ", spaces_needed)}, "c", false, true)
    elseif spaces_needed < 0 then
        for _ = 1, -spaces_needed do
            vim.api.nvim_command("norm X")
        end
    end
end

local function toggle_quickfix()
    local qf_exists = false
    for _, win in pairs(vim.fn.getwininfo()) do
        if win["quickfix"] == 1 then
            qf_exists = true
        end
    end
    if qf_exists == true then
        vim.cmd("cclose")
        return
    end
    if not vim.tbl_isempty(vim.fn.getqflist()) then
        vim.cmd("copen")
    end
end

local function toggle_location()
    local qf_exists = false
    for _, win in pairs(vim.fn.getwininfo()) do
        if win["loclist"] == 1 then
            qf_exists = true
        end
    end
    if qf_exists == true then
        vim.cmd("lclose")
    else
        vim.cmd("lopen")
    end
end

local function toggle_virtualedit()
    local ve = vim.opt.virtualedit:get()

    if vim.tbl_contains(ve, "all") then
        vim.opt.virtualedit = ""
    else
        vim.opt.virtualedit = "all"
    end
end

-- TODO: Make toggle_alpha toggle only alpha
local function toggle_nrformats_alpha()
    local nf = vim.opt.nrformats:get()

    if vim.tbl_contains(nf, "alpha") then
        vim.opt.nrformats = "bin,hex"
    else
        vim.opt.nrformats = "bin,hex,alpha"
    end
end

local function toggle_fold()
    local line = vim.fn.line(".")
    local foldlevel = vim.fn.foldlevel(line)

    if foldlevel == 0 then
        vim.cmd("norm! <CR>")
    else
        vim.cmd("norm! za")
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

local function reuse_text()
    vim.api.nvim_echo({{ "Delimiter: ", "Normal" }}, false, {})
    local d = vim.fn.nr2char(vim.fn.getchar())

    vim.fn.feedkeys(":s/\\v([^" .. d .. "]+)" .. string.rep("%(" .. d .. "+([^" .. d .. "]+))?", 8) .. "/")
end

local function swap_words()
    local w1 = vim.fn.input({ prompt = "Word #1: " })
    local w2 = vim.fn.input({ prompt = "Word #2: " })
    local w1_e = vim.fn.escape(w1, '"')
    local w2_e = vim.fn.escape(w2, '"')

    vim.fn.feedkeys(":s/\\v" .. w1 .. "|" .. w2 .. '\\C/\\=submatch(0)=="' .. w1_e .. '"?"' .. w2_e .. '":"' .. w1_e .. '\"/g\r')
end

-- Preferences
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })
vim.keymap.set("n", "n", "nzzzv", { desc = 'Repeat the latest "/" or "?"' })
vim.keymap.set("n", "N", "Nzzzv", { desc = 'Repeat the latest "/" or "?" in reverse' })

vim.keymap.set("n", "<C-w><C-h>", function() swap_win("h") end, { desc = "Move current window left" })
vim.keymap.set("n", "<C-w><C-j>", function() swap_win("j") end, { desc = "Move current window down" })
vim.keymap.set("n", "<C-w><C-k>", function() swap_win("k") end, { desc = "Move current window up" })
vim.keymap.set("n", "<C-w><C-l>", function() swap_win("l") end, { desc = "Move current window right" })

vim.keymap.set("n", "<C-w><", "5<C-w><")
vim.keymap.set("n", "<C-w>>", "5<C-w>>")
vim.keymap.set("n", "<C-w>+", "2<C-w>+")
vim.keymap.set("n", "<C-w>-", "2<C-w>-")

vim.keymap.set({ "n", "v" }, "/", "/\\v", { desc = "Search very magic" })
vim.keymap.set({ "n", "v" }, "?", "?\\v", { desc = "Reverse Search very magic" })
vim.keymap.set({ "n", "v" }, "<M-/>", "/\\V", { desc = "Search very nomagic" })
vim.keymap.set({ "n", "v" }, "<M-?>", "?\\V", { desc = "Reverse Search very nomagic" })

vim.keymap.set({ "n", "v" }, "*", "/\\v<<C-r><C-w>><CR>", { desc = "Search current word" })
vim.keymap.set({ "n", "v" }, "g*", "/\\v<C-r><C-w><CR>", { desc = "Search current word with no word bound" })
vim.keymap.set({ "n", "v" }, "#", "?\\v<<C-r><C-w>><CR>", { desc = "Search current word backward" })
vim.keymap.set({ "n", "v" }, "g#", "?\\v<C-r><C-w><CR>", { desc = "Search current word backward with no word bound" })

vim.keymap.set("n", "&", ":%&&<CR><C-o>", { desc = "Repeat last substitute on all lines" })
vim.keymap.set("n", "g&", ":&&<CR>", { desc = "Repeat last substitute" })
vim.keymap.set("v", "&", ":'<,'>&&<CR>", { desc = "Repeat last substitute on selection" })

vim.keymap.set({ "n", "v" }, "<M-;>", ",", { desc = "Repeat latest f, t, F, or T in opposite direction" })

vim.keymap.set("n", "J", join_at_column, { desc = "Join at Column" })
vim.keymap.set("n", "gJ", g_join_at_column, { desc = "Join at Column without space" })

-- Folds
vim.keymap.set("n", "<Tab>", toggle_fold, { desc = "Toggle fold" })
vim.keymap.set("n", "zm", fold_more, { desc = "Fold more"})
vim.keymap.set("n", "zl", to_fold_level, { desc = "To fold level" })

-- Custom Shortcuts
vim.keymap.set("i", "<S-Space>", "\u{00A0}", { desc = "Insert nbsp" })

vim.keymap.set("n", "<C-q>", ":t.<CR>", { desc = "Duplicate Line" })

vim.keymap.set("n", "Y", "y$", { desc = "Yank to eol" })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set("n", "<leader>Y", '"+y$', { desc = "Yank eol to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete to void" })
vim.keymap.set("n", "<leader>D", '"_D', { desc = "Delete eol to void" })

vim.keymap.set("n", "<leader>s", ":%s/\\v<<C-r><C-w>>//g<Left><Left>", { desc = "Substitute current word" })
vim.keymap.set("n", "<leader>S", ":%s/\\v<<C-r><C-a>>//g<Left><Left>", { desc = "Substitute current WORD" })
vim.keymap.set("n", "<leader>g", ":g/\\v<<C-r><C-w>>/norm! ", { desc = "Global current word" })
vim.keymap.set("n", "<leader>G", ":g/\\v<<C-r><C-a>>/norm! ", { desc = "Global current WORD" })

vim.keymap.set({ "n", "v" }, "<C-b>", "@:", { desc = "Repeat last command" })
vim.keymap.set("n", "<M-b>", ":.w !sh<CR>", { desc = "Run line as external command" })

vim.keymap.set({ "n", "v" }, "g/", "/\\v^((.**)@!.)*$" .. string.rep("<Left>", 8), { desc = "Inverse Search" })
vim.keymap.set("v", "<leader>s", "y/\\V<C-r>=substitute(escape(@\", '\\/'), '\\n', '\\\\n', 'g')<CR><CR><CR>", { desc = "Search for current selection" })
vim.keymap.set("v", "<leader>S", "y?\\V<C-r>=substitute(escape(@\", '\\/'), '\\n', '\\\\n', 'g')<CR><CR><CR>", { desc = "Search for current selection" })

vim.keymap.set({ "n", "v" }, "<C-s>", reuse_text, { desc = "Multiline reuse text" })
vim.keymap.set({ "n", "v" }, "<M-s>", swap_words, { desc = "Swap words" })

vim.keymap.set("v", "<leader>n", ":norm ", { desc = "Normal on selection" })

-- Macro
vim.keymap.set("v", "<leader>q", "", { desc = "Macro" })
vim.keymap.set("v", "<leader>qa", ":norm @a<CR>", { desc = "@a" })
vim.keymap.set("v", "<leader>qb", ":norm @b<CR>", { desc = "@b" })
vim.keymap.set("v", "<leader>qc", ":norm @c<CR>", { desc = "@c" })
vim.keymap.set("v", "<leader>qd", ":norm @d<CR>", { desc = "@d" })
vim.keymap.set("v", "<leader>qe", ":norm @e<CR>", { desc = "@e" })
vim.keymap.set("v", "<leader>qf", ":norm @f<CR>", { desc = "@f" })
vim.keymap.set("v", "<leader>qg", ":norm @g<CR>", { desc = "@g" })
vim.keymap.set("v", "<leader>qh", ":norm @h<CR>", { desc = "@h" })
vim.keymap.set("v", "<leader>qi", ":norm @i<CR>", { desc = "@i" })
vim.keymap.set("v", "<leader>qj", ":norm @j<CR>", { desc = "@j" })
vim.keymap.set("v", "<leader>qk", ":norm @k<CR>", { desc = "@k" })
vim.keymap.set("v", "<leader>ql", ":norm @l<CR>", { desc = "@l" })
vim.keymap.set("v", "<leader>qm", ":norm @m<CR>", { desc = "@m" })
vim.keymap.set("v", "<leader>qn", ":norm @n<CR>", { desc = "@n" })
vim.keymap.set("v", "<leader>qo", ":norm @o<CR>", { desc = "@o" })
vim.keymap.set("v", "<leader>qp", ":norm @p<CR>", { desc = "@p" })
vim.keymap.set("v", "<leader>qq", ":norm @q<CR>", { desc = "@q" })
vim.keymap.set("v", "<leader>qr", ":norm @r<CR>", { desc = "@r" })
vim.keymap.set("v", "<leader>qs", ":norm @s<CR>", { desc = "@s" })
vim.keymap.set("v", "<leader>qt", ":norm @t<CR>", { desc = "@t" })
vim.keymap.set("v", "<leader>qu", ":norm @u<CR>", { desc = "@u" })
vim.keymap.set("v", "<leader>qv", ":norm @v<CR>", { desc = "@v" })
vim.keymap.set("v", "<leader>qw", ":norm @w<CR>", { desc = "@w" })
vim.keymap.set("v", "<leader>qx", ":norm @x<CR>", { desc = "@x" })
vim.keymap.set("v", "<leader>qy", ":norm @y<CR>", { desc = "@y" })
vim.keymap.set("v", "<leader>qz", ":norm @z<CR>", { desc = "@z" })

-- To
vim.keymap.set("n", "<leader>t", "", { desc = "To" })
vim.keymap.set("n", "<leader>tc", to_column, { desc = "Move chars at cursor to column" })

-- Tabs
vim.keymap.set("n", "<C-S-PageUp>", ":tabm +<CR>", { desc = "Move tab left" })
vim.keymap.set("n", "<C-S-PageDown>", ":tabm -<CR>", { desc = "Move tab right" })
vim.keymap.set("n", "<C-w><C-x>", ":tabc<CR>", { desc = "Close current tab" })
vim.keymap.set("n", "<C-w><C-o>", ":tabo<CR>", { desc = "Close all other tabs" })

-- Switch Windows with Arrow Keys
vim.keymap.set("n", "<C-Left>", "<C-w>h")
vim.keymap.set("n", "<C-Down>", "<C-w>j")
vim.keymap.set("n", "<C-Up>", "<C-w>k")
vim.keymap.set("n", "<C-Right>", "<C-w>l")
vim.keymap.set("n", "<C-w><S-Left>", "<C-w>H", { desc = "Move current window left" })
vim.keymap.set("n", "<C-w><S-Down>", "<C-w>J", { desc = "Move current window down" })
vim.keymap.set("n", "<C-w><S-Up>", "<C-w>K", { desc = "Move current window up" })
vim.keymap.set("n", "<C-w><S-Right>", "<C-w>L", { desc = "Move current window right" })
vim.keymap.set("n", "<C-w><C-Left>", function() swap_win("h") end, { desc = "Move current window left" })
vim.keymap.set("n", "<C-w><C-Down>", function() swap_win("j") end, { desc = "Move current window down" })
vim.keymap.set("n", "<C-w><C-Up>", function() swap_win("k") end, { desc = "Move current window up" })
vim.keymap.set("n", "<C-w><C-Right>", function() swap_win("l") end, { desc = "Move current window right" })

-- Options
vim.keymap.set("n", "<leader>o", "", { desc = "Options/Outline" })
vim.keymap.set("n", "<leader>oh", ":nohl<CR>", { desc = "Clear search highlights" })
vim.keymap.set("n", "<leader>ol", ":set list!<CR>", { desc = "Toggle listchars" })
vim.keymap.set("n", "<leader>ot", ":set expandtab!<CR>", { desc = "Toggle expandtab" })
vim.keymap.set("n", "<leader>or", ":set relativenumber!<CR>", { desc = "Toggle relativenumber" })
vim.keymap.set("n", "<leader>ow", ":set wrap!<CR>", { desc = "Toggle wrap" })
vim.keymap.set("n", "<leader>ov", toggle_virtualedit, { desc = "Toggle virtualedit" })
vim.keymap.set("n", "<leader>oa", toggle_nrformats_alpha, { desc = "Toggle alpha nrformats" })

-- QuickFix/Location List
vim.keymap.set("n", "<leader>q", "", { desc = "QuickFix/Location List" })
vim.keymap.set("n", "<leader>qq", toggle_quickfix, { desc = "Toggle QuickFix List Window" })
vim.keymap.set("n", "<leader>ql", toggle_location, { desc = "Toggle Location List Window" })

-- Markup
vim.keymap.set("n", "<leader>m", "", { desc = "Markup" })
vim.keymap.set("n", "<leader>mh", to_heading_level, { desc = "Fold Header Level" })

-- Lazy
vim.keymap.set("n", "<leader>z", "", { desc = "Lazy/Zen" })
vim.keymap.set("n", "<leader>zz", ":Lazy<CR>", { desc = "Lazy" })
vim.keymap.set("n", "<leader>zu", function()
    vim.cmd("Lazy update")
    vim.fn.jobstart("~/.dotfiles/scripts/lazy_update_commit.sh", { detach = true })
end, { desc = "Lazy Update Plugins" })
vim.keymap.set("n", "<leader>zr", ":Lazy reload ", { desc = "Lazy Reload Plugin" })
vim.keymap.set("n", "<leader>zc", ":Lazy clean<CR>", { desc = "Lazy Clean Plugins" })

-- Fix keys lost by Tmux
vim.keymap.set("n", "<F15>", "<C-i>", { desc = "Goto [count] newer cursor position in the jump list" })
vim.keymap.set("n", "<F16>", fold_more, { desc = "+ Fold level"})
vim.keymap.set("n", "<F17>", "zr", { desc = "- Fold level" })
vim.keymap.set("n", "<F18>", "<C-PageUp>", { desc = "Previous Tab" })
vim.keymap.set("n", "<F19>", "<C-PageDown>", { desc = "Next Tab" })
vim.keymap.set("n", "<F20>", ":tabm -<CR>", { desc = "Move Tab Left" })
vim.keymap.set("n", "<F21>", ":tabm +<CR>", { desc = "Move Tab Right" })
