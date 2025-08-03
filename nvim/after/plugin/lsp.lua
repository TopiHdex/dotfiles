-- NOTE: to make any of this work you need a language server.
-- If you don't know what that is, watch this 5 min video:
-- https://www.youtube.com/watch?v=LaS32vctfOY

-- Reserve a space in the gutter
vim.opt.signcolumn = 'yes'

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { "pyright", "ts_ls", "eslint", "emmet_language_server" },
})

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lspconfig_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = {buffer = event.buf}

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({'n', 'x'}, '<leader>fmt', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        vim.keymap.set('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)

        vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
            pattern = "*.module.scss",
            callback = function()
                vim.bo.tabstop = 4
                vim.bo.shiftwidth = 4
                vim.bo.expandtab = true  -- if you want spaces instead of tabs
            end
        })

        -- vim.api.nvim_create_autocmd("BufWritePost", {
        --     pattern = "*.js,*.ts,*.jsx,*.tsx,*.css,*.scss,*.html,*.json,*.md",
        --     callback = function()
        --         vim.fn.system("prettier --write " .. vim.fn.shellescape(vim.fn.expand("%:p")))
        --     end
        -- })

        -- vim.api.nvim_create_autocmd('BufWritePre', {
        --     buffer = event.buf,
        --     callback = function()
        --         vim.lsp.buf.format {async = false}
        --     end
        -- })
    end,
})

-- You'll find a list of language servers here:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
-- These are example language servers. 
require('lspconfig').ts_ls.setup({})
require('lspconfig').eslint.setup({})
require('lspconfig').pyright.setup({})
require('lspconfig').somesass_ls.setup({})
require('lspconfig').cssls.setup({})
require('lspconfig').cssmodules_ls.setup({})
require('lspconfig').emmet_language_server.setup({})
require('lspconfig').astro.setup({
    init_options = {
        typescript = {
            tsdk = 'node_modules/typescript/lib'
        }
    },
})

local cmp = require('cmp')

cmp.setup({
    sources = {
        {name = 'nvim_lsp'},
    },
    snippet = {
        expand = function(args)
            -- You need Neovim v0.10 to use vim.snippet
            vim.snippet.expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({select = true}),
    }),
    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
})
