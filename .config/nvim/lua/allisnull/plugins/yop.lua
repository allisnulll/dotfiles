return {
    "zdcthomas/yop.nvim",
    config = function()
        local yop = require("yop")

        yop.op_map("n", "dS", function(selections, info)
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

                -- if row == cursor_row then
                --     vim.api.nvim_win_set_cursor(0, { row, out })
                -- end
            end
        end)

        local function single_line_comment()
            local row = vim.api.nvim_win_get_cursor(0)[1] - 1
            local line = vim.api.nvim_get_current_line()
            local _, col_start = string.find(line, "^%s*")

            if vim.api.nvim_buf_get_text(0, row, col_start, row, col_start+3, {})[1] == "/* "
               and vim.api.nvim_buf_get_text(0, row, #line-3, row, #line, {})[1] == " */" then
                vim.api.nvim_buf_set_text(0, row, col_start, row, col_start+3, {})
                vim.api.nvim_buf_set_text(0, row, #line-6, row, #line-3, {})
            else
                vim.api.nvim_buf_set_text(0, row, col_start, row, col_start, {"/* "})
                vim.api.nvim_buf_set_text(0, row, #line+3, row, #line+3, {" */"})
            end
        end

        yop.op_map({ "n", "v" }, "gC", function(selections, info)
            if #selections == 1 then
                single_line_comment()
                return
            end

            local col_start = math.huge
            local commented = false
            for i, _ in ipairs(selections) do
                local row = info["position"]["first"][1] + i - 2
                local _, line_col_start = string.find(vim.api.nvim_buf_get_lines(0, row, row+1, false)[1], "^%s*")
                col_start = math.min(col_start, line_col_start)

                if i == 1 and vim.api.nvim_buf_get_text(0, row, col_start, row, col_start+2, {})[1] == "/*" then
                    commented = true
                elseif commented then
                    if i == #selections then
                        commented = vim.api.nvim_buf_get_text(0, row, col_start, row, col_start+3, {})[1] == " */"
                    else
                        commented = vim.api.nvim_buf_get_text(0, row, col_start, row, col_start+3, {})[1] == " * "
                    end
                end
            end

            if commented then
                for i, _ in ipairs(selections) do
                    local row = info["position"]["first"][1] + i - 2

                    if i == 1 then
                        vim.api.nvim_buf_set_lines(0, row, row+1, false, {})
                    elseif i == #selections then
                        vim.api.nvim_buf_set_lines(0, row-1, row, false, {})
                    else
                        vim.api.nvim_buf_set_text(0, row-1, col_start, row-1, col_start+3, {})
                    end
                end
            else
                for i, _ in ipairs(selections) do
                    local row = info["position"]["first"][1] + i - 2

                    if i == 1 then
                        vim.api.nvim_buf_set_text(0, row, col_start, row, col_start, {"/*", string.rep(" ", col_start) .. " * "})
                    else
                        vim.cmd("undojoin")
                        vim.api.nvim_buf_set_text(0, row+1, col_start, row+1, col_start, {" * "})
                        if i == #selections then
                            vim.api.nvim_buf_set_lines(0, row+2, row+2, false, {string.rep(" ", col_start) .. " */"})
                        end
                    end
                end
            end
        end)

        vim.keymap.set("n", "gCC", single_line_comment, { desc = "C style multiline comment" })
    end,
}
