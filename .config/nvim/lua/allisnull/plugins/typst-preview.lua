return {
	"chomosuke/typst-preview.nvim",
	ft = "typst",
	version = "1.*",
	config = function()
		require("typst-preview").setup()

		vim.keymap.set("n", "<leader>mp", ":TypstPreviewToggle", { desc = "Toggle TypstPreview" })
	end,
}
