return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local opts = { noremap = true, silent = true }
        local on_attach = function(client, bufnr)
            opts.buffer = bufnr

            -- set keybinds
            opts.desc = "Show LSP references"
            vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

            opts.desc = "Go to declaration"
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

            opts.desc = "Show LSP definitions"
            vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

            opts.desc = "Show LSP implementations"
            vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

            opts.desc = "Show LSP type definitions"
            vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

            opts.desc = "See available code actions"
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

            opts.desc = "Smart rename"
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

            opts.desc = "Show buffer diagnostics"
            vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

            opts.desc = "Show line diagnostics"
            vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

            opts.desc = "Go to previous diagnostic"
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

            opts.desc = "Go to next diagnostic"
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

            opts.desc = "Show documentation for what is under cursor"
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

            opts.desc = "Restart LSP"
            vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

            opts.desc = "Function signature help"
            vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts) -- show function signature help
        end

        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- Change the Diagnostic symbols in the sign column (gutter)
        -- (not in youtube nvim video)
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        lspconfig["rust_analyzer"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })

        lspconfig["wgsl_analyzer"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })

        local file_path = vim.fn.stdpath("config") .. "/lua/plugins/lsp"
        lspconfig["clangd"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            cmd = {
                "clangd",
                "-compile-commands-dir=" .. file_path,
            },
        })

        lspconfig["cmake"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })

        lspconfig["pyright"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })

        lspconfig["html"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })

        lspconfig["cssls"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })

        lspconfig["tsserver"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })

        lspconfig["bashls"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })

        lspconfig["matlab_ls"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })

        lspconfig["typos_lsp"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            init_options = {
                diagnosticSeverity = "Warning",
            },
        })

        lspconfig["jsonls"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })

        lspconfig["dockerls"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })

        lspconfig["gopls"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })

        lspconfig["hls"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })

        lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = { -- custom settings for lua
                Lua = {
                    -- make the language server recognize "vim" global
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        -- make language server aware of runtime files
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                    },
                },
            },
        })

        lspconfig["ltex"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end,
}
