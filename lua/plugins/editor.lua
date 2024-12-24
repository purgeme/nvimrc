return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        opts = {
            close_if_last_window = true,
            popup_border_style = "rounded",
            enable_git_status = true,
            enable_diagnostics = true,
            open_files_do_not_replace_types = { "terminal", "trouble", "qf"},
            filesystem = {
                hijack_netrw_behavior = "open_current",
            },
            mappings = {
                ["<space>"] = {
                    "none",
                }
            }
        },
        config = function(_, opts)
            require('neo-tree').setup(opts)
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('telescope').setup({
                defaults = {
                    path_display = {
                        "smart"
                    }
                }
            })
            local builtin = require('telescope.builtin')
            require('telescope').load_extension("aerial")
        end
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            defaults = {
            }
        },
        config = function(_, opts)
            require("which-key").setup(opts)
        end
    },
    {
        "laytan/cloak.nvim",
        opts = {
            enabled = true,
            cloak_character = '*',
            -- The applied highlight group (colors) on the cloaking, see `:h highlight`.
            highlight_group = 'Comment',
            -- Applies the length of the replacement characters for all matched
            -- patterns, defaults to the length of the matched pattern.
            cloak_length = nil, -- Provide a number if you want to hide the true length of the value.
            -- Whether it should try every pattern to find the best fit or stop after the first.
            try_all_patterns = true,
            -- Set to true to cloak Telescope preview buffers. (Required feature not in 0.1.x)
            cloak_telescope = true,
            patterns = {
                {
                    -- Match any file starting with '.env'.
                    -- This can be a table to match multiple file patterns.
                    file_pattern = '.env*',
                    -- Match an equals sign and any character after it.
                    -- This can also be a table of patterns to cloak,
                    -- example: cloak_pattern = { ':.+', '-.+' } for yaml files.
                    cloak_pattern = '=.+',
                    -- A function, table or string to generate the replacement.
                    -- The actual replacement will contain the 'cloak_character'
                    -- where it doesn't cover the original text.
                    -- If left empty the legacy behavior of keeping the first character is retained.
                    replace = nil,
                },
            },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs                        = {
                add          = { text = '│' },
                change       = { text = '│' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
            signcolumn                   = true, -- Toggle with `:Gitsigns toggle_signs`
            numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
            linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir                 = {
                follow_files = true
            },
            auto_attach                  = true,
            attach_to_untracked          = false,
            current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts      = {
                virt_text = true,
                virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
                virt_text_priority = 100,
            },
            current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
            sign_priority                = 6,
            update_debounce              = 100,
            status_formatter             = nil, -- Use default
            max_file_length              = 40000, -- Disable if file is longer than this (in lines)
            preview_config               = {
                -- Options passed to nvim_open_win
                border = 'single',
                style = 'minimal',
                relative = 'cursor',
                row = 0,
                col = 1
            },
            -- yadm                         = {
            --     enable = false
            -- },
        },
        config = function(_, opts)
            require("gitsigns").setup(opts)
        end
    },
    {
        "mbbill/undotree",
    },
    {
        "j-hui/fidget.nvim",
    },
    {
        "echasnovski/mini.indentscope",
        opts = {
            -- symbol = "▏",
            symbol = "│",
            options = { try_as_border = true },
        }
    },
    {
        "goolord/alpha-nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function ()
            require'alpha'.setup(require'alpha.themes.startify'.config)
        end
    },
    {
        "numToStr/FTerm.nvim",
        opts = {
            border = 'single',
            dimensions = {
                height = 0.8,
                width = 0.8,
            },
        },
        config = function(opts)
            require('FTerm').setup(opts)
        end
    },
    {
      'stevearc/aerial.nvim',
      opts = {},
      -- Optional dependencies
      dependencies = {
         "nvim-treesitter/nvim-treesitter",
         "nvim-tree/nvim-web-devicons"
      },
    },
    {
      "lervag/vimtex",
      init = function()
        -- Use init for configuration, don't use the more common "config".
      end
    },
    {
      "ibhagwan/fzf-lua",
      -- optional for icon support
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").setup({})
      end
    }
}
