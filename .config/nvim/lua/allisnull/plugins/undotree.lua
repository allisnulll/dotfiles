return {
    "mbbill/undotree",
    config = function()
        vim.g["undotree_WindowLayout"] = 2
        vim.g["undotree_DiffpanelHeight"] = 8
        vim.g["undotree_DiffAutoOpen"] = 0
        vim.g["undotree_SetFocusWhenToggle"] = 1
        vim.g["undotree_HelpLine"] = 0
        -- TODO: Colorize this: vim.g["undotree_DiffCommand"] = "diff --color=always"
        vim.g["undotree_TreeNodeShape"] = ""
        vim.g["undotree_TreeVertShape"] = "│"
        vim.g["undotree_TreeSplitShape"] = "╱"
        vim.g["undotree_TreeReturnShape"] = "╲"

        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })
    end,
}
