local function ai_line(ai_type)
    local lnum = vim.fn.line(".")
    local line = vim.fn.getline(lnum)

    return {
        from = { line = lnum, col = ai_type == "i" and line:find("%S") or 1 },
        to = { line = lnum, col = #line },
    }
end

local function ai_buffer(ai_type)
    local start_line = 1
    local end_line = vim.fn.line("$")
    if ai_type == "i" then
        local first_nonblank = vim.fn.nextnonblank(start_line)
        local last_nonblank = vim.fn.prevnonblank(end_line)

        if first_nonblank == 0 or last_nonblank == 0 then
            return { from = { line = start_line, col = 1 } }
        end

        start_line = first_nonblank
        end_line = last_nonblank
    end

    local to_col = math.max(vim.fn.getline(end_line):len(), 1)

    return {
        from = { line = start_line, col = 1 },
        to = { line = end_line, col = to_col },
    }
end

return {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = function()
        local spec_treesitter = require("mini.ai").gen_spec.treesitter

        return {
            n_lines = 500,
            custom_textobjects = {
                g = ai_buffer,
                l = ai_line,
                F = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
                o = spec_treesitter({
                    a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                    i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                }),
                c = spec_treesitter({ a = "@class.outer", i = "@class.inner" }),
                d = { "%f[%d]%d+" },
                e = {
                    { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
                    "^().*()$",
                },
            },
            mappings = {
                around_next = "aj",
                inside_next = "ij",
                around_last = "ak",
                inside_last = "ik",
            },
        }
    end,
}
