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
-- Which Key
require("which-key").register({
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    e = { "<cmd>Neotree toggle<cr>", "Toggle Neotree" },
    q = {
        name = "Quit",
        w = { "<cmd>wq<cr>", "Save & Quit" },
        q = { "<cmd>quitall<cr>", "Quit" },
        d = { "<cmd>quitall!<cr>", "Ignore Changes & Quit" },
    },
    s = { "<cmd>w<cr>", "Save file" },
    f = {
        name = "Files",
        f = { "<cmd>Telescope find_files<cr>", "Telescope Files" }
    },
    g = {
        name = "Git",
        f = { "<cmd>Telescope git_files<cr>", "Telescope Files" }
    },
    d = {
        name = "Diagnostics",
        t = { function() require('trouble').toggle() end, "Toggle diagnostics" },
        ["["] = { function() require('trouble').next({ skip_groups = true, jump = true }) end, "Next diagnostic" },
        ["]"] = { function() require('trouble').previous({ skip_groups = true, jump = true }) end, "Previous diagnostic" },
    },
}, {
    prefix = "<leader>",
    mode = { "n" },
})


vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        require("which-key").register({
            c = {
                name = "Code",
                D = { function() vim.lsp.buf.declaration() end, "Go to declaration" },
                d = { function() vim.lsp.buf.definition() end, "Go to definition" },
                h = { function() vim.lsp.buf.hover() end, "Hover over code" },
                i = { function() vim.lsp.buf.implementation() end, "Go to implementation" },
                t = { function() vim.lsp.buf.type_definition() end, "Go to type definition" },
                r = { function() vim.lsp.buf.rename() end, "Rename" },
                f = { function() vim.lsp.buf.format({ async = true }) end, "Format code" },
            },
        }, {
            prefix = "<leader>",
            mode = { "n" }
        })

        require("which-key").register({
            c = {
                name = "Code",
                a = { function() vim.lsp.buf.code_action() end, "Code action" },
            }
        }, {
            prefix = "<leader>",
            mode = { "n", "v" },
        })
    end
})

-- Toggle comments
require("mini.comment").setup({
    mappings = {
        comment_line = '<leader>cc',
        comment_visual = '<leader>cc',
    }
})

-- CMP
local cmp = require("cmp")
cmp.setup({
    mapping = {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
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
