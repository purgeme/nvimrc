return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/nvim-cmp",
        },
        config = function()
                    require("mason").setup()
                    require("mason-lspconfig").setup({
                        ensure_installed = {
                            "lua_ls",
                            "rust_analyzer",
                            "clangd",
                            "bashls",
                            "tsserver",
                        },
                        handlers = {
                            function(server_name)
                                require('lspconfig')[server_name].setup({});
                            end
                        }
                    })

                    -- require('lspconfig').rust_analyzer.setup({});

                    local cmp = require("cmp");
                    -- for _, source in ipairs(opts.sources) do
                    --     source.group_index = source.group_index or 1
                    -- end
                    require("cmp").setup({
                        snippet = {
                            expand = function(args)
                                require('luasnip').lsp_expand(args.body);
                            end,
                        },
                        window = {
                          completion = cmp.config.window.bordered(),
                          documentation = cmp.config.window.bordered(),
                        },
                        sources = cmp.config.sources({
                          { name = 'nvim_lsp' },
                          { name = 'luasnip' }, -- For luasnip users.
                        }, {
                          { name = 'buffer' },
                        })
                    })
                    -- Set configuration for specific filetype.
                    cmp.setup.filetype('gitcommit', {
                      sources = cmp.config.sources({
                        { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
                      }, {
                        { name = 'buffer' },
                      })
                    })

                    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
                    cmp.setup.cmdline({ '/', '?' }, {
                      mapping = cmp.mapping.preset.cmdline(),
                      sources = {
                        { name = 'buffer' }
                      }
                    })

                    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
                    cmp.setup.cmdline(':', {
                      mapping = cmp.mapping.preset.cmdline(),
                      sources = cmp.config.sources({
                        { name = 'path' }
                      }, {
                        { name = 'cmdline' }
                      })
                    })
                end
    },
    {
        "nvim-treesitter/nvim-treesitter",
    },
}
