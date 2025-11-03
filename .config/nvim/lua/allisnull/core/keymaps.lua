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

local function duplicate_line()
    local col = vim.fn.col(".")
    vim.cmd("yank | norm p" .. col .. "|")
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

-- TODO: Finish to_line()
-- function to_line()
--     local input = vim.fn.input("Line{j|k}: ")
--     local num, sign = input:match("(%d+)([jk]?)")
--
--     num = tonumber(num)
--     if not num then
--         vim.notify("Invalid input", vim.log.levels.INFO)
--     end
--
--     local line1 = vim.fn.line("'<")
--     local selection_size = vim.fn.line("'>") - line1
--
--     if sign == "j" then
--         vim.cmd(":'<,'>move +" .. selection_size + num .. "<CR>")
--     elseif sign == "k" then
--         vim.cmd(":'<,'>move -" .. selection_size + num .. "<CR>")
--     else
--         vim.cmd(":'<,'>move " .. num .. "<CR>")
--     end
--     vim.cmd("norm gv=gv")
--
--     -- ":move '<-2<CR>gv=gv"
--     -- ":move '>+1<CR>gv=gv"
-- end

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

-- Preferences
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })
vim.keymap.set("n", "n", "nzzzv", { desc = 'Repeat the latest "/" or "?"' })
vim.keymap.set("n", "N", "Nzzzv", { desc = 'Repeat the latest "/" or "?" in reverse' })

vim.keymap.set("n", "<C-w>H", function() swap_win("h") end, { desc = "Move current window left" })
vim.keymap.set("n", "<C-w>J", function() swap_win("j") end, { desc = "Move current window down" })
vim.keymap.set("n", "<C-w>K", function() swap_win("k") end, { desc = "Move current window up" })
vim.keymap.set("n", "<C-w>L", function() swap_win("l") end, { desc = "Move current window right" })

vim.keymap.set("n", "<C-w><", "5<C-w><")
vim.keymap.set("n", "<C-w>>", "5<C-w>>")
vim.keymap.set("n", "<C-w>+", "2<C-w>+")
vim.keymap.set("n", "<C-w>-", "2<C-w>-")

vim.keymap.set({ "n", "v" }, "/", "/\\v", { desc = "Search very magic" })
vim.keymap.set({ "n", "v" }, "?", "?\\v", { desc = "Reverse Search very magic" })
vim.keymap.set({ "n", "v" }, "<M-/>", "/\\V", { desc = "Search very nomagic" })
vim.keymap.set({ "n", "v" }, "<M-?>", "?\\V", { desc = "Reverse Search very nomagic" })

vim.keymap.set({ "n", "v" }, "<M-;>", ",", { desc = "Repeat latest f, t, F, or T in opposite direction" })

vim.keymap.set("n", "J", join_at_column, { desc = "Join at Column" })
vim.keymap.set("n", "gJ", g_join_at_column, { desc = "Join at Column without space" })

-- Folds
vim.keymap.set("n", "<Tab>", toggle_fold, { desc = "Toggle fold" })
vim.keymap.set("n", "zm", fold_more, { desc = "Fold more"})
vim.keymap.set("n", "zl", to_fold_level, { desc = "To fold level" })

-- Custom Shortcuts
vim.keymap.set("i", "<S-Space>", "\u{00A0}", { desc = "Insert nbsp" })

vim.keymap.set("n", "<C-q>", duplicate_line, { desc = "Duplicate Line" })

vim.keymap.set("n", "Y", "y$", { desc = "Yank to eol" })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set("n", "<leader>Y", '"+y$', { desc = "Yank eol to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete to void" })
vim.keymap.set("n", "<leader>D", '"_D', { desc = "Delete eol to void" })

vim.keymap.set("n", "<leader>s", ":%s/\\v<<C-r><C-w>>//g<Left><Left>", { desc = "Substitute current word" })
vim.keymap.set("n", "<leader>S", ":%s/\\v<<C-r><C-a>>//g<Left><Left>", { desc = "Substitute current WORD" })
vim.keymap.set("n", "<leader>g", ":g/\\v<<C-r><C-w>>/norm! ", { desc = "Global current word" })
vim.keymap.set("n", "<leader>G", ":g/\\v<<C-r><C-a>>/norm! ", { desc = "Global current WORD" })

vim.keymap.set("n", "<C-b>", "@:", { desc = "Repeat last command" })
vim.keymap.set("n", "<M-b>", ":.w !sh<CR>", { desc = "Run line as external command" })

vim.keymap.set("v", "<leader>n", ":norm ", { desc = "Normal on selection" })

vim.keymap.set({ "n", "v" }, "<C-s>", ":s/\\v" .. string.rep("(\\S+)\\s=", 8) .. "(\\S+)/", { desc = "Multiline reuse text" })
vim.keymap.set({ "n", "v" }, "g/", "/\\v^((.**)@!.)*$" .. string.rep("<Left>", 8), { desc = "Inverse Search" })
-- TODO: <leader>s for visual mode
-- keymap.set("v", "<leader>s", function()
--     local selected_text = vim.fn.getreg('"')
--     vim.cmd(":\b\b\b\b\b%s/" .. selected_text .. "/g<Left><Left>")
-- end, { desc = "Substitute current word" })

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
-- TODO: Finish To-Line
-- vim.keymap.set("v", "<leader>tl", function() to_line() end, { desc = "Move selection to line" })

-- Tabs
vim.keymap.set("n", "<C-w><C-x>", ":tabc<CR>", { desc = "Close current tab" })
vim.keymap.set("n", "<C-w><C-o>", ":tabo<CR>", { desc = "Close all other tabs" })

-- Switch Windows with Arrow Keys
vim.keymap.set("n", "<C-Down>", "<C-w>j")
vim.keymap.set("n", "<C-Up>", "<C-w>k")
vim.keymap.set("n", "<C-Left>", "<C-w>h")
vim.keymap.set("n", "<C-Right>", "<C-w>l")
vim.keymap.set("n", "<C-S-Down>", "<C-w>J")
vim.keymap.set("n", "<C-S-Up>", "<C-w>K")
vim.keymap.set("n", "<C-S-Left>", "<C-w>H")
vim.keymap.set("n", "<C-S-Right>", "<C-w>L")

-- Options
vim.keymap.set("n", "<leader>o", "", { desc = "Options/Outline" })
vim.keymap.set("n", "<leader>oc", ":nohl<CR>", { desc = "Clear search highlights" })
vim.keymap.set("n", "<leader>ol", ":set list!<CR>", { desc = "Toggle listchars" })
vim.keymap.set("n", "<leader>ot", ":set expandtab!<CR>", { desc = "Toggle expandtab" })
vim.keymap.set("n", "<leader>or", ":set relativenumber!<CR>", { desc = "Toggle relativenumber" })
vim.keymap.set("n", "<leader>oh", ":set hlsearch!<CR>", { desc = "Toggle hlsearch" })
vim.keymap.set("n", "<leader>ow", ":set wrap!<CR>", { desc = "Toggle wrap" })
vim.keymap.set("n", "<leader>ov", toggle_virtualedit, { desc = "Toggle virtualedit" })
vim.keymap.set("n", "<leader>oa", toggle_nrformats_alpha, { desc = "Toggle alpha nrformats" })

-- QuickFix/Location List
vim.keymap.set("n", "<leader>q", "", { desc = "QuickFix/Location List" })
vim.keymap.set("n", "<leader>qq", toggle_quickfix, { desc = "Toggle QuickFix List Window" })
vim.keymap.set("n", "<leader>ql", toggle_location, { desc = "Toggle Location List Window" })
vim.keymap.set("n", "<leader>j", ":cnext<CR>zz", { desc = "QuickFix next" })
vim.keymap.set("n", "<leader>k", ":cprev<CR>zz", { desc = "QuickFix prev" })
vim.keymap.set("n", "<leader><Down>", ":cnext<CR>zz", { desc = "QuickFix next" })
vim.keymap.set("n", "<leader><Up>", ":cprev<CR>zz", { desc = "QuickFix prev" })
vim.keymap.set("n", "<leader><C-j>", ":lnext<CR>zz", { desc = "Current Window Location List next" })
vim.keymap.set("n", "<leader><C-k>", ":lprev<CR>zz", { desc = "Current Window Location List prev" })
vim.keymap.set("n", "<leader><C-Down>", ":lnext<CR>zz", { desc = "Current Window Location List next" })
vim.keymap.set("n", "<leader><C-Up>", ":lprev<CR>zz", { desc = "Current Window Location List prev" })

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
vim.keymap.set("n", "<F19>", "<C-PageUp>", { desc = "Previous Tab" })
vim.keymap.set("n", "<F20>", "<C-PageDown>", { desc = "Next Tab" })
vim.keymap.set("n", "<F16>", fold_more, { desc = "+ Fold level"})
vim.keymap.set("n", "<F17>", "zr", { desc = "- Fold level" })
