local export_types = { "pdf", "png", "svg", "html" }
local function typst_export(format)
    if vim.tbl_contains(export_types, format) then
        local command = { "typst", "compile", vim.api.nvim_buf_get_name(0), "--format", format }
        if format == "html" then
            table.insert(command, 4, "--features")
            table.insert(command, 5, "html")
        end

        vim.notify("Compiling Typst to: " .. format, vim.log.levels.INFO)
        vim.fn.jobstart(command, {
            on_exit = function(_, code)
                if code == 0 then
                    vim.notify("Compiled successfully to " .. format, vim.log.levels.INFO)
                else
                    vim.notify("Compilation failed", vim.log.levels.ERROR)
                end
            end,
        })

        return true
    end

    local actions = require("telescope.actions")
    local pickers = require("telescope.pickers")
    local themes = require("telescope.themes")
    local finders = require("telescope.finders")
    local config = require("telescope.config")
    local actions_state = require("telescope.actions.state")

    pickers.new(themes.get_dropdown(), {
        prompt_title = "Typst Export Format",
        finder = finders.new_table({ results = export_types }),
        sorter = config.values.generic_sorter(),
        attach_mappings = function(bufnr, map)
            actions.select_default:replace(function()
                actions.close(bufnr)
                -- TODO: Figure out how to accept multiple selections
                local selections = actions_state.get_selected_entry()

                for _, selection in ipairs(selections) do
                    typst_export(selection)
                end
            end)

            return true
        end,
    }):find()
end

vim.api.nvim_create_user_command("TypstExport", function(opts)
    typst_export(opts.args)
end, {
    nargs = "?",
    complete = function()
        return export_types
    end,
})

return {
	"chomosuke/typst-preview.nvim",
	ft = "typst",
	version = "1.*",
	config = function()
		require("typst-preview").setup()

		vim.keymap.set("n", "<leader>mp", ":TypstPreviewToggle<CR>", { desc = "Toggle TypstPreview" })
		vim.keymap.set("n", "<leader>me", ":TypstExport<CR>", { desc = "Export Typst" })
	end,
}
