local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

ls.add_snippets("all", {
    s("hex2rgb", {
        t("#"),
        i(1, "ffffff"),
        t(" -> "),
        f(function(args)
            local hex = args[1][1]:gsub("#", "")
            local r = tonumber(hex:sub(1, 2), 16)
            local g = tonumber(hex:sub(3, 4), 16)
            local b = tonumber(hex:sub(5, 6), 16)

            return string.format("%d, %d, %d", r, g, b)
        end, { 1 }),
    }),
})
