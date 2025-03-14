local function join_at_column()
    local col = vim.fn.col(".")
    vim.cmd("normal! J" .. col .. "|")
end

local function g_join_at_column()
    local col = vim.fn.col(".")
    vim.cmd("normal! gJ" .. col .. "|")
end

local function put_at_column()
    local col = vim.fn.col(".")
    vim.cmd("normal p" .. col .. "|")
end

local function duplicate_line()
    vim.cmd("normal yy")
    put_at_column()
end

local function to_fold_level()
    vim.api.nvim_echo({{"Fold Level: ", "Normal"}}, false, {})
    local char = vim.fn.getchar()
    local input = vim.fn.nr2char(char)
    local level = tonumber(input)

    if not level then
        vim.notify("Invalid input", vim.log.levels.INFO)
        return 0
    end

    vim.api.nvim_echo({{"", "Normal"}}, false, {})
    if level == 0 then
        level = 101
    end

    vim.opt.foldlevel = level - 1
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
            vim.api.nvim_command("normal X")
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
        vim.cmd "cclose"
        return
    end
    if not vim.tbl_isempty(vim.fn.getqflist()) then
        vim.cmd "copen"
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
        vim.cmd "lclose"
    else
        vim.cmd "lopen"
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
--     vim.cmd("normal gv=gv")
--
--     -- ":move '<-2<CR>gv=gv"
--     -- ":move '>+1<CR>gv=gv"
-- end
-- vim.keymap.set("v", "<leader>tl", function() to_line() end, { desc = "Move selection to line" })

vim.keymap.set("n", "<F15>", function()
    local line = vim.fn.line(".")
    local foldlevel = vim.fn.foldlevel(line)

    if foldlevel == 0 then
        vim.cmd("normal! <Enter>")
    else
        vim.cmd("normal! za")
    end
end, { desc = "Toggle fold" })

vim.keymap.set("n", "<leader>oc", ":nohl<CR>", { desc = "Clear search highlights" })
vim.keymap.set("v", "<leader>n", ":normal ", { desc = "Normal on selection" })

vim.keymap.set("n", "<leader>m", "", { desc = "Markup" })
vim.keymap.set("n", "<leader>ml", ":set list!<CR>", { desc = "Toggle listchars" })

vim.keymap.set("n", "zl", to_fold_level, { desc = "To fold level" })

vim.keymap.set("n", "<leader>o", "", { desc = "Options/Outline" })
vim.keymap.set("n", "<leader>ol", ":set list!<CR>", { desc = "Toggle listchars" })
vim.keymap.set("n", "<leader>ot", ":set expandtab!<CR>", { desc = "Toggle expandtab" })
vim.keymap.set("n", "<leader>or", ":set relativenumber!<CR>", { desc = "Toggle relativenumber" })
vim.keymap.set("n", "<leader>oh", ":set hlsearch!<CR>", { desc = "Toggle hlsearch" })
vim.keymap.set("n", "<leader>ow", ":set wrap!<CR>", { desc = "Toggle wrap" })

vim.keymap.set("n", "<leader>q", "", { desc = "QuickFix/Location List" })
vim.keymap.set("n", "<leader>qq", toggle_quickfix, { desc = "Toggle QuickFix List Window" })
vim.keymap.set("n", "<leader>ql", toggle_location, { desc = "Toggle Location List Window" })

vim.keymap.set("i", "<S-Space>", "\u{00A0}", { desc = "Insert nbsp" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Better n" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Better N" })

vim.keymap.set("n", "<C-w><", "5<C-w>>")
vim.keymap.set("n", "<C-w>>", "5<C-w><")
vim.keymap.set("n", "<C-w>+", "2<C-w>+")
vim.keymap.set("n", "<C-w>-", "2<C-w>-")

vim.keymap.set("n", "<leader>j", ":cnext<CR>zz", { desc = "QuickFix next" })
vim.keymap.set("n", "<leader>k", ":cprev<CR>zz", { desc = "QuickFix prev" })
vim.keymap.set("n", "<leader><C-j>", ":lnext<CR>zz", { desc = "Current Window Location List next" })
vim.keymap.set("n", "<leader><C-k>", ":lprev<CR>zz", { desc = "Current Window Location List prev" })

vim.keymap.set("n", "Y", "y$", { desc = "Yank to eol" })
vim.keymap.set("n", "<leader>y", "\"+y", { desc = "Yank to clipboard" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "Yank to clipboard" })
vim.keymap.set("n", "<leader>Y", "\"+y$", { desc = "Yank eol to clipboard" })

vim.keymap.set("x", "<leader>p", "\"_dp", { desc = "Put to void" })
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d", { desc = "Delete to void" })
vim.keymap.set("n", "<leader>D", "\"_D", { desc = "Delete eol to void" })

vim.keymap.set("n", "<leader>p", put_at_column, { desc = "Put at column" })
vim.keymap.set("n", "<C-q>", duplicate_line, { desc = "Duplicate Line" })

vim.keymap.set("n", "J", join_at_column, { desc = "Join at Column" })
vim.keymap.set("n", "gJ", g_join_at_column, { desc = "Join at Column without space" })

vim.keymap.set("n", "<leader>t", "", { desc = "To" })
vim.keymap.set("n", "<leader>tc", to_column, { desc = "Move chars at cursor to column" })

-- vim.keymap.set("v", "<C-j>", ":move '>+1<CR>gv=gv", { desc = "Move selection down" })
-- vim.keymap.set("v", "<C-k>", ":move '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set({ "n", "v" }, "<C-s>", ":s/\\(\\w.*\\)/", { desc = "Multiline reuse text" })
vim.keymap.set("n", "<leader>s", ":%s/<C-r><C-w>//g<Left><Left>", { desc = "Substitute current word" })
vim.keymap.set("n", "<leader>g", ":g/<C-r><C-w>/norm! ", { desc = "Global current word" })
-- TODO: <leader>s for visual mode
-- keymap.set("v", "<leader>s", function()
--     local selected_text = vim.fn.getreg('"')
--     vim.cmd(":\b\b\b\b\b%s/" .. selected_text .. "/g<Left><Left>")
-- end, { desc = "Substitute current word" })

vim.keymap.set("n", "<C-z>", "")
vim.keymap.set("i", "<C-z>", "")
vim.keymap.set("v", "<C-z>", "")

-- Lazy
vim.keymap.set("n", "<leader>z", "", { desc = "Lazy/Zen" })
vim.keymap.set("n", "<leader>zz", ":Lazy<CR>", { desc = "Lazy" })
vim.keymap.set("n", "<leader>zu", function()
    vim.cmd("Lazy update")
    vim.fn.jobstart("~/.dotfiles/scripts/lazy_update_commit.sh", { detach = true })
end, { desc = "Lazy Update Plugins" })
vim.keymap.set("n", "<leader>zr", ":Lazy reload ", { desc = "Lazy Update Plugins" })
vim.keymap.set("n", "<leader>zc", ":Lazy clean<CR>", { desc = "Lazy Clean Plugins" })
