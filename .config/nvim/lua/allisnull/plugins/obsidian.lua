local title

return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    event = {
        "BufReadPre " .. vim.fn.expand("~") .. "/Vault/*.md",
        "BufNewFile " .. vim.fn.expand("~") .. "/Vault/*.md",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
        "nvim-telescope/telescope.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        local obsidian = require("obsidian")

        obsidian.setup({
            ui = { enable = false },
            attachments = { img_folder = "assets/images" },
            workspaces = {{
                name = "Vault",
                path = "~/Vault",
            }},
            templates = {
                folder = "templates",
                date_format = "%Y-%m-%d-%a %H:%M:%S",
                substitutions = {
                    title = function()
                        return title
                    end,
                    title_lower = function()
                        return title:lower()
                    end,
                },
            },
            mappings = {
                ["gf"] = {
                    action = function()
                        return obsidian.util.gf_passthrough()
                    end,
                    opts = { noremap = false, expr = true, buffer = true },
                },
                ["<leader>cb"] = {
                    action = function()
                        return obsidian.util.toggle_checkbox()
                    end,
                    opts = { buffer = true, desc = "Toggle checkbox" },
                },
                ["<CR>"] = {
                    action = function()
                        return obsidian.util.smart_action()
                    end,
                    opts = { buffer = true, expr = true },
                },
            },
            daily_notes = { folder = "dailies", default_tags = { "daily" } },

            note_id_func = function(title)
                local suffix = ""
                if title ~= nil then
                    suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
                else
                    for _ = 1, 4 do
                        suffix = suffix .. string.char(math.random(65, 90))
                    end
                end
                return tostring(os.time()) .. "-" .. suffix
            end,

            note_frontmatter_func = function(note)
                if note.title then
                    note:add_alias(note.title)
                    note:add_alias(note.title:lower())
                end

                local out = {
                    id = note.id,
                    aliases = note.aliases,
                    tags = note.tags,
                    title = note.title,
                    created = os.date("%Y-%m-%d-%a %H:%M:%S"),
                }

                local has_source = false
                if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                    for k, v in pairs(note.metadata) do
                        if k == "source" or k == "sources" then
                            has_source = true
                        end
                        out[k] = v
                    end

                    if not has_source then
                        out["sources"] = { [1] = "[[1741211268-me|Me]]" }
                    end
                end

                return out
            end,
        })

        vim.keymap.set("n", "<localleader>", "", { desc = "Notes/Obsidian" })
        vim.keymap.set("n", "<localleader>h", ":36vs +set\\ nowrap ~/Vault/1741211101-main-hub.md<CR>", { desc = "Obsidian Main Hub" })
        vim.keymap.set("n", "<localleader>n", ":ObsidianNew<CR>", { desc = "Obsidian New Note" })
        vim.keymap.set("n", "<localleader>w", function()
            title = vim.fn.input("Enter title or path: ")
            if title ~= "" then
                vim.cmd("ObsidianNewFromTemplate " .. vim.fn.shellescape(title))
            else
                vim.notify("No title provided. Note creation canceled.")
            end
        end, { desc = "Obsidian New Note From Template" })
        vim.keymap.set("n", "<localleader><localleader>", ":ObsidianQuickSwitch<CR>", { desc = "Obsidian Quick Switch" })
        vim.keymap.set("n", "<localleader>b", ":ObsidianBacklinks<CR>", { desc = "Obsidian Backlinks" })
        vim.keymap.set("n", "<localleader>t", ":ObsidianTags<CR>", { desc = "Obsidian Find Tags" })
        vim.keymap.set("n", "<localleader>d", ":ObsidianToday<CR>", { desc = "Obsidian Today" })
        vim.keymap.set("n", "<localleader>m", ":ObsidianToday +1<CR>", { desc = "Obsidian Tomorrow" })
        vim.keymap.set("n", "<localleader>y", ":ObsidianToday -1<CR>", { desc = "Obsidian Yesterday" })
        vim.keymap.set("n", "<localleader>fd", ":ObsidianDailies<CR>", { desc = "Obsidian Find Dailies" })
        vim.keymap.set("n", "<localleader>ft", ":ObsidianTemplate<CR>", { desc = "Obsidian Template" })
        vim.keymap.set("n", "<localleader>ff", ":ObsidianSearch<CR>", { desc = "Obsidian Find" })
        vim.keymap.set("v", "<localleader>ol", ":ObsidianLink<CR>", { desc = "Obsidian Link" })
        vim.keymap.set("v", "<localleader>ow", ":ObsidianLinkNew<CR>", { desc = "Obsidian Link New" })
        vim.keymap.set("n", "<localleader>fl", ":ObsidianLinks<CR>", { desc = "Obsidian Find Links" })
        vim.keymap.set("v", "<localleader>e", ":ObsidianExtractNote<CR>", { desc = "Obsidian Extract Note" })
        vim.keymap.set("n", "<localleader>r", ":ObsidianRename<CR>", { desc = "Obsidian Rename" })
        vim.keymap.set("n", "<localleader>c", ":ObsidianToc<CR>", { desc = "Obsidian ToC" })
    end,
}
