return {
	"lukas-reineke/indent-blankline.nvim",
	ft = { "dart" },
	main = "ibl",
    config = function()
        require("ibl").setup({
            indent = { char = "┊" },
        })

        vim.keymap.set("n", "<leader>ml", ":IBLToggle<CR><BAR>:set list!<CR>",
            { desc = "Toggle listchars & Indent Blanklines" })
    end,
    keys = {
		{ "<leader>oi", ":IBLToggle<CR>",  desc = "Toggle Indent Blanklines" },
	},
}
