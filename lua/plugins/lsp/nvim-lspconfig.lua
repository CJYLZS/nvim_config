-- lspconfig
return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lspconfig = require("lspconfig")
        local on_attach = function(client, bufnr)
            -- require("plugins.lsp.lsp_signature").on_attach(client, bufnr) -- Note: add in lsp client on-attach
        end
        if vim.fn.executable("pylsp") == 1 then
            -- python-lsp-server
            lspconfig.pylsp.setup({
                on_attach = on_attach,
                settings = {
                    pylsp = {
                        plugins = {
                            autopep8 = { enabled = false },
                            pycodestyle = {
                                enabled = false,
                                ignore = { "W391" },
                                maxLineLength = 100,
                            },
                            pylsp_mypy = { enabled = false },
                            pylint = { enabled = false },
                            pyflakes = { enabled = false },
                            flake8 = {
                                enabled = true,
                            },
                            jedi = {
                                -- extra analyze path
                                extra_paths = {},
                            },
                        },
                    },
                },
            })
        end
        if vim.fn.executable("lua-language-server") == 1 then
            -- lua-lsp-server
            lspconfig.lua_ls.setup({
                on_attach = on_attach,
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                            version = "LuaJIT",
                        },
                        diagnostics = {
                            enable = true,
                            -- Get the language server to recognize the `vim` global
                            globals = { "vim" },
                            disable = { "different-requires" },
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })
        end
        if vim.fn.executable("bash-language-server") == 1 then
            -- bash lsp server
            -- npm i -g bash-language-server
            lspconfig.bashls.setup({
                on_attach = on_attach,
            })
        end
        --Enable (broadcasting) snippet capability for completion
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        if vim.fn.executable("vscode-json-language-server") == 1 then
            -- vscode extract servers
            lspconfig.jsonls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end
        if vim.fn.executable("vscode-css-language-server") == 1 then
            lspconfig.cssls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end
        if vim.fn.executable("vscode-html-language-server") == 1 then
            lspconfig.html.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end
        if vim.fn.executable("vscode-eslint-language-server") == 1 then
            lspconfig.eslint.setup({
                on_attach = on_attach,
                --- ...
                -- on_attach = function(client, bufnr)
                --     vim.api.nvim_create_autocmd("BufWritePre", {
                --         buffer = bufnr,
                --         command = "EslintFixAll",
                --     })
                -- end,
            })
        end
        if vim.fn.executable("gopls") == 1 then
            lspconfig.gopls.setup({
                on_attach = on_attach,
            })
        end
    end,
}
