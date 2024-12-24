-- Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
        lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- Basic configs
vim.g.mapleader = " "

vim.opt.relativenumber = true
vim.opt.nu = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true


require("lazy").setup("plugins")

vim.cmd([[colorscheme gruvbox]])

-- KEYMAPS
-----------------------------------------------------------------------------------

-- local lazyterm = function() Util.terminal(nil, { cwd = Util.root() }) end

-- Which Key
require("which-key").add({
    {"<leader>k", "<cmd>Telescope keymaps<cr>", desc = "Keymaps"},
    {"<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Neotree"},
    {
        desc = "Quit",
        {"<leader>qw", "<cmd>wq<cr>", desc = "Save & Quit"},
        {"<leader>qq", "<cmd>quitall<cr>", desc = "Quit"},
        {"<leader>qd", "<cmd>quitall!<cr>", desc = "Ignore Changes & Quit"},
    },
    {"<leader>s", "<cmd>w<cr>", desc = "Save file"},
    {
        desc = "Files",
        {"<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope Files"},
    },
    {
        desc = "Git Files",
        {"<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Telescope Files"},
    },
    {
        desc = "Diagnostics",
        {"<leader>dt", function() require('trouble').toggle('diagnostics') end, desc = "Toggle diagnostics"},
        {"<leader>d[", function() require('trouble').previous({ 'diagnostics', skip_groups = true, jump = true }) end, desc = "Previous diagnostics"},
        {"<leader>d]", function() require('trouble').next({ 'diagnostics', skip_groups = true, jump = true }) end, desc = "Next diagnostics"},
    },
})

require("which-key").add({
    {
        desc = "Lazyterm",
        mode = {"n"},
        {"<A-i>", function() require('FTerm').toggle() end, desc = "Lazyterm"}
    },
    {
        desc = "Lazyterm",
        mode = {"t"},
        {"<A-i>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', desc = "Lazyterm"}
    }
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
            -- Enable completion triggered by <c-x><c-o>
            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
            require("which-key").add({
                {
                    desc = "Code",
                    {"<leader>cD", function() vim.lsp.buf.declaration() end, desc = "Go to declaration"},
                    {"<leader>cd", function() vim.lsp.buf.definition() end, desc = "Go to definition"},
                    {"<leader>ch", function() vim.lsp.buf.hover() end, desc = "Hover over code"},
                    {"<leader>ci", function() vim.lsp.buf.implementation() end, desc = "Go to implementation"},
                    {"<leader>ct", function() vim.lsp.buf.type_definition() end, desc = "Go to type definition"},
                    {"<leader>cr", function() vim.lsp.buf.rename() end, desc = "Rename"},
                    {"<leader>cF", function() vim.lsp.buf.format({ async = true }) end, desc = "Format code"},
                    {"<leader>cf", "<cmd>Telescope aerial<CR>", desc = "Format code"},
                    {"<leader>ca", function() vim.lsp.buf.code_action() end, desc = "Code action", mode = { "n", "v" }},
                }
            })
        end
})
--         require("which-key").register({
--             c = {
--                 name = "Code",
--                 D = { function() vim.lsp.buf.declaration() end, "Go to declaration" },
--                 d = { function() vim.lsp.buf.definition() end, "Go to definition" },
--                 h = { function() vim.lsp.buf.hover() end, "Hover over code" },
--                 i = { function() vim.lsp.buf.implementation() end, "Go to implementation" },
--                 t = { function() vim.lsp.buf.type_definition() end, "Go to type definition" },
--                 r = { function() vim.lsp.buf.rename() end, "Rename" },
--                 F = { function() vim.lsp.buf.format({ async = true }) end, "Format code" },
--                 f = { "<cmd>Telescope aerial<CR>", "Format code" },
--             },
--         }, {
--             prefix = "<leader>",
--             mode = { "n" }
--         })
-- 
--         require("which-key").register({
--             c = {
--                 name = "Code",
--                 a = { function() vim.lsp.buf.code_action() end, "Code action" },
--             }
--         }, {
--             prefix = "<leader>",
--             mode = { "n", "v" },
--         }) 

-- Toggle comments
require("mini.comment").setup({
    mappings = {
        comment_line = '<leader>cc',
        comment_visual = '<leader>cc',
    }
})

-- CMP
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local cmp = require("cmp")
local luasnip = require("luasnip")
cmp.setup({
    mapping = {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
                -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                -- that way you will only jump inside the snippet region
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else

                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }
})

-- LSP
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
-- vim.api.nvim_create_autocmd('LspAttach', {
--     group = vim.api.nvim_create_augroup('UserLspConfig', {}),
--     callback = function(ev)
--         -- Enable completion triggered by <c-x><c-o>
--         vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
--
--         -- Buffer local mappings.
--         -- See `:help vim.lsp.*` for documentation on any of the below functions
--         local opts = { buffer = ev.buf }
--         vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
--         vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
--         vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
--         vim.keymap.set('n', '<leader>wl', function()
--             print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--         end, opts)
--         vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
--     end,
-- })
-----------------------------------------------------------------------------------

vim.cmd "filetype plugin indent on"
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_view_general_viewer = 'okular'
vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
vim.g.vimtex_compile_method = "tectonic"
