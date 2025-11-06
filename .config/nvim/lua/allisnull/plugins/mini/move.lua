return {
    "echasnovski/mini.move",
    config = function()
        require("mini.move").setup()

        vim.keymap.set("n", "<M-Up>", function() MiniMove.move_line("up") end)
        vim.keymap.set("n", "<M-Down>", function() MiniMove.move_line("down") end)

        vim.keymap.set("v", "<M-Up>", function() MiniMove.move_selection("up") end)
        vim.keymap.set("v", "<M-Down>", function() MiniMove.move_selection("down") end)
        vim.keymap.set("v", "<M-Left>", function() MiniMove.move_selection("left") end)
        vim.keymap.set("v", "<M-Right>", function() MiniMove.move_selection("right") end)
    end,
}
