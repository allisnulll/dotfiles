return {
    "zdcthomas/yop.nvim",
    config = function()
        require("yop").op_map("n", "dS", function(selections, info)
            for i, line in ipairs(selections) do
                local row = info["position"]["first"][1] + i - 1
                local full_line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
                local col_start, col_end = string.find(full_line, line, 1, true)
                local _, indent = string.find(full_line, "^%s*")
                -- TODO: Figure out how to keep cursor in same character by getting the column position before the motion. Or, rewrite the operator without yop.
                -- if row == cursor_row then
                --     out = col_end + 1 - cursor_col
                --     print(out)
                -- end

                indent = math.min(indent, col_start-1)
                col_end = col_end - (col_start - (col_start == 1 and 2 or 1)) + indent

                vim.api.nvim_buf_set_text(0, row-1, indent, row-1, col_start-1, {})
                vim.api.nvim_buf_set_text(0, row-1, col_end, row-1, -1, {})

                -- if row == corsor_row then
                --     vim.api.nvim_win_set_cursor(0, { row, out })
                -- end
            end
        end)
    end,
}
