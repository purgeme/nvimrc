return {
    { 'echasnovski/mini.pairs',
        version = '*' ,
        config = function()
                    require("mini.pairs").setup()
                end
    },
    {
      "echasnovski/mini.comment",
      -- event = "VeryLazy",
      opts = {
        options = {
          custom_commentstring = function()
            return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
          end,
        },
      },
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
    },
    { 
        "rafamadriz/friendly-snippets",
        config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                end
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true,
        opts = {
          enable_autocmd = false,
        },
    },
	{
	    "folke/trouble.nvim",
        config = function()
            require("trouble").setup()

        end
	},
}
-- 	{
-- 	  "echasnovski/mini.pairs",
-- 	  event = "VeryLazy",
-- 	  opts = {},
-- 	  keys = {
-- 	    {
-- 	      "<leader>up",
-- 	      function()
-- 	        local Util = require("lazy.core.util")
-- 	        vim.g.minipairs_disable = not vim.g.minipairs_disable
-- 	        if vim.g.minipairs_disable then
-- 	          Util.warn("Disabled auto pairs", { title = "Option" })
-- 	        else
-- 	          Util.info("Enabled auto pairs", { title = "Option" })
-- 	        end
-- 	      end,
-- 	      desc = "Toggle auto pairs",
-- 	    },
-- 	  },
-- 	},
-- 	{
--   		"echasnovski/mini.surround",
--   		keys = function(_, keys)
--   		  -- Populate the keys based on the user's options
--   		  local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
--   		  local opts = require("lazy.core.plugin").values(plugin, "opts", false)
--   		  local mappings = {
--   		    { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
--   		    { opts.mappings.delete, desc = "Delete surrounding" },
--   		    { opts.mappings.find, desc = "Find right surrounding" },
--   		    { opts.mappings.find_left, desc = "Find left surrounding" },
--   		    { opts.mappings.highlight, desc = "Highlight surrounding" },
--   		    { opts.mappings.replace, desc = "Replace surrounding" },
--   		    { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
--   		  }
--   		  mappings = vim.tbl_filter(function(m)
--   		    return m[1] and #m[1] > 0
--   		  end, mappings)
--   		  return vim.list_extend(mappings, keys)
--   		end,
--   		opts = {
--   		  mappings = {
--   		    add = "gsa", -- Add surrounding in Normal and Visual modes
--   		    delete = "gsd", -- Delete surrounding
--   		    find = "gsf", -- Find surrounding (to the right)
--   		    find_left = "gsF", -- Find surrounding (to the left)
--   		    highlight = "gsh", -- Highlight surrounding
--   		    replace = "gsr", -- Replace surrounding
--   		    update_n_lines = "gsn", -- Update `n_lines`
--   		  },
--   		},
-- 	},
-- 	{
-- 		"echasnovski/mini.animate",
-- 		event = "VeryLazy",
-- 		opts = function()
-- 		  -- don't use animate when scrolling with the mouse
-- 		  local mouse_scrolled = false
-- 		  for _, scroll in ipairs({ "Up", "Down" }) do
-- 		    local key = "<ScrollWheel" .. scroll .. ">"
-- 		    vim.keymap.set({ "", "i" }, key, function()
-- 		      mouse_scrolled = true
-- 		      return key
-- 		    end, { expr = true })
-- 		  end
-- 		
-- 		  local animate = require("mini.animate")
-- 		  return {
-- 		    resize = {
-- 		      timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
-- 		    },
-- 		    scroll = {
-- 		      timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
-- 		      subscroll = animate.gen_subscroll.equal({
-- 		        predicate = function(total_scroll)
-- 		          if mouse_scrolled then
-- 		            mouse_scrolled = false
-- 		            return false
-- 		          end
-- 		          return total_scroll > 1
-- 		        end,
-- 		      }),
-- 		    },
-- 		  }
-- 		end,
-- 	},
-- 	{
-- 		"hrsh7th/nvim-cmp",
-- 		version = false, -- last release is way too old
-- 		event = "InsertEnter",
-- 		dependencies = {
-- 		  "hrsh7th/cmp-nvim-lsp",
-- 		  "hrsh7th/cmp-buffer",
-- 		  "hrsh7th/cmp-path",
-- 		},
-- 		opts = function()
-- 		  vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
-- 		  local cmp = require("cmp")
-- 		  local defaults = require("cmp.config.default")()
-- 		  return {
-- 		    completion = {
-- 		      completeopt = "menu,menuone,noinsert",
-- 		    },
-- 		    mapping = cmp.mapping.preset.insert({
-- 		      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
-- 		      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
-- 		      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
-- 		      ["<C-f>"] = cmp.mapping.scroll_docs(4),
-- 		      ["<C-Space>"] = cmp.mapping.complete(),
-- 		      ["<C-e>"] = cmp.mapping.abort(),
-- 		      ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
-- 		      ["<S-CR>"] = cmp.mapping.confirm({
-- 		        behavior = cmp.ConfirmBehavior.Replace,
-- 		        select = true,
-- 		      }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
-- 		      ["<C-CR>"] = function(fallback)
-- 		        cmp.abort()
-- 		        fallback()
-- 		      end,
-- 		    }),
-- 		    sources = cmp.config.sources({
-- 		      { name = "nvim_lsp" },
-- 		      { name = "path" },
-- 		    }, {
-- 		      { name = "buffer" },
-- 		    }),
-- 		    formatting = {
-- 		      format = function(_, item)
-- 		        local icons = require("lazyvim.config").icons.kinds
-- 		        if icons[item.kind] then
-- 		          item.kind = icons[item.kind] .. item.kind
-- 		        end
-- 		        return item
-- 		      end,
-- 		    },
-- 		    experimental = {
-- 		      ghost_text = {
-- 		        hl_group = "CmpGhostText",
-- 		      },
-- 		    },
-- 		    sorting = defaults.sorting,
-- 		  }
-- 		end,
-- 		---@param opts cmp.ConfigSchema
-- 		config = function(_, opts)
-- 		  for _, source in ipairs(opts.sources) do
-- 		    source.group_index = source.group_index or 1
-- 		  end
-- 		  require("cmp").setup(opts)
-- 		end,
-- 	},
-- 	{
--   "nvim-cmp",
--   dependencies = {
--     "saadparwaiz1/cmp_luasnip",
--   },
--   opts = function(_, opts)
--     opts.snippet = {
--       expand = function(args)
--         require("luasnip").lsp_expand(args.body)
--       end,
--     }
--     table.insert(opts.sources, { name = "luasnip" })
--   end,
-- },
-- }
