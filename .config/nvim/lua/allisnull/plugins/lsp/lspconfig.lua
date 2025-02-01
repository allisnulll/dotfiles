return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "folke/neodev.nvim", opts = {} },
    },
    config = function()
        local lspconfig = require("lspconfig")

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local opts = { buffer = ev.buf, silent = true }

                opts.desc = "LSP"
                vim.keymap.set("n", "<leader>c", "", opts)

                opts.desc = "Find LSP references"
                vim.keymap.set("n", "gr", ":Telescope lsp_references<CR>", opts)

                opts.desc = "Show LSP references"
                vim.keymap.set("n", "gR", vim.lsp.buf.references, opts)

                opts.desc = "Goto declaration"
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

                opts.desc = "Show LSP definitions"
                vim.keymap.set("n", "gd", ":Telescope lsp_definitions<CR>", opts)

                opts.desc = "Show LSP implementations"
                vim.keymap.set("n", "gi", ":Telescope lsp_implementations<CR>", opts)

                opts.desc = "Show LSP type definitions"
                vim.keymap.set("n", "gt", ":Telescope lsp_type_definitions<CR>", opts)

                opts.desc = "See available code actions"
                vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

                opts.desc = "Show buffer diagnostics"
                vim.keymap.set("n", "<leader>cf", ":Telescope diagnostics bufnr=0<CR>", opts)

                opts.desc = "Show line diagnostics"
                vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, opts)

                opts.desc = "Hide line diagnostics"
                vim.keymap.set("n", "<leader>ch", function()
                    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
                end, opts)

                opts.desc = "Go to previous diagnostic"
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

                opts.desc = "Go to next diagnostic"
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

                opts.desc = "LSP"
                vim.keymap.set("n", "<leader>r", "", opts)

                opts.desc = "Smart rename"
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

                opts.desc = "Restart LSP"
                vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

                opts.desc = "LSP Info"
                vim.keymap.set("n", "<leader>ri", ":LspInfo<CR>", opts)

                opts.desc = "Show documentation for what is under cursor"
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            end,
        })
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- capabilities.textDocument.foldingRange = {
        --     dynamicRegistration = false,
        --     lineFoldingOnly = true,
        -- }
        -- local language_servers = lspconfig.util.available_servers()
        -- for _, ls in ipairs(language_servers) do
        --     lspconfig[ls].setup({
        --         capabilities = capabilities,
        --     }),
        -- end
        -- require("ufo").setup()

        require("mason-lspconfig").setup_handlers({
            function(server_name)
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                })
            end,

            ["lua_ls"] = function()
                lspconfig["lua_ls"].setup({
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                            },
                            completion = { callSnippet = "Replace" },
                        },
                    },
                })
            end,
            -- ["dartls"] = function()
            --     lspconfig["dartls"].setup({
            --         capabilities = capabilities,
            --         dart = {
            --
            --         }
            --     })
            -- end,
        })

        lspconfig.pyright.setup({
            settings = {
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                    },
                },
            },
        })

        lspconfig.ltex.setup({
            capabilities = capabilities,
            on_attach = function(_, bufnr)
                require("ltex-utils").on_attach(bufnr)
            end,

            flags = { debounce_text_changes = 300 },
            settings = {
                ltex = {
                    language = "en",
                    enabledRules = { "grammar", "spell" },
                    additionalRules = {
                        languageModel = "~/Documents/ngrams/",
                    },
                },
            },
        })
    end,
}
