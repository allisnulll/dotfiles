local title

return {
    "obsidian-nvim/obsidian.nvim",
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
            legacy_commands = false,
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

        vim.api.nvim_create_autocmd("User", {
            pattern = "ObsidianNoteEnter",
            callback = function(ev)
                vim.keymap.del("n", "<CR>", { buffer = ev.buf })
            end,
        })

        vim.keymap.set("n", "<localleader>", "", { desc = "Notes/Obsidian" })
        vim.keymap.set("n", "<localleader>h", ":36vs +set\\ nowrap ~/Vault/main-hub.md<CR>", { desc = "Obsidian Main Hub" })
        vim.keymap.set("n", "<localleader>n", ":Obsidian new<CR>", { desc = "Obsidian New Note" })
        vim.keymap.set("n", "<localleader>w", function()
            title = vim.fn.input("Enter title or path: ")
            if title ~= "" then
                vim.cmd("Obsidian new_from_template " .. vim.fn.shellescape(title))
            else
                vim.notify("No title provided. Note creation canceled.")
            end
        end, { desc = "Obsidian New Note From Template" })
        vim.keymap.set("n", "<localleader><localleader>", ":Obsidian quick_switch<CR>", { desc = "Obsidian Quick Switch" })
        vim.keymap.set("n", "<localleader>b", ":Obsidian backlinks<CR>", { desc = "Obsidian Backlinks" })
        vim.keymap.set("n", "<localleader>t", ":Obsidian tags<CR>", { desc = "Obsidian Find Tags" })
        vim.keymap.set("n", "<localleader>d", ":Obsidian today<CR>", { desc = "Obsidian Today" })
        vim.keymap.set("n", "<localleader>m", ":Obsidian today +1<CR>", { desc = "Obsidian Tomorrow" })
        vim.keymap.set("n", "<localleader>y", ":Obsidian today -1<CR>", { desc = "Obsidian Yesterday" })
        vim.keymap.set("n", "<localleader>fd", ":Obsidian dailies<CR>", { desc = "Obsidian Find Dailies" })
        vim.keymap.set("n", "<localleader>ft", ":Obsidian template<CR>", { desc = "Obsidian Template" })
        vim.keymap.set("n", "<localleader>ff", ":Obsidian search<CR>", { desc = "Obsidian Find" })
        vim.keymap.set("v", "<localleader>l", ":Obsidian link<CR>", { desc = "Obsidian Link" })
        vim.keymap.set("v", "<localleader>w", ":Obsidian linkNew<CR>", { desc = "Obsidian Link New" })
        vim.keymap.set("n", "<localleader>fl", ":Obsidian links<CR>", { desc = "Obsidian Find Links" })
        vim.keymap.set("v", "<localleader>e", ":Obsidian extract_note<CR>", { desc = "Obsidian Extract Note" })
        vim.keymap.set("n", "<localleader>r", ":Obsidian rename<CR>", { desc = "Obsidian Rename" })
        vim.keymap.set("n", "<localleader>c", ":Obsidian toc<CR>", { desc = "Obsidian ToC" })

        vim.keymap.set("n", "<CR>", ":Obsidian follow_link<CR>", { desc = "Obsidian Follow Link", silent = true })
        vim.keymap.set("n", "<leader>mb", ":Obsidian toggle_checkbox<CR>", { desc = "Obsidian Toggle Checkbox", silent = true })
    end,
}
