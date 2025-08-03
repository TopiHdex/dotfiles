-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
	    'nvim-telescope/telescope.nvim', tag = '0.1.8',
	    -- or                            , branch = '0.1.x',
	    requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- use({
    --     'sainnhe/gruvbox-material',
    --     config = function()
    --   	  vim.cmd('colorscheme gruvbox-material')
    --     end
    -- })
    -- use({'f4z3r/gruvbox-material.nvim'})
    -- use('navarasu/onedark.nvim')
    use('EdenEast/nightfox.nvim')
    use('rebelot/kanagawa.nvim')
    use('windwp/nvim-ts-autotag')
    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

    use({'neovim/nvim-lspconfig'})
    use({'hrsh7th/nvim-cmp'})
    use({'hrsh7th/cmp-nvim-lsp'})
    use({'lewis6991/gitsigns.nvim'})
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use('theprimeagen/harpoon')
    use('nvimtools/none-ls.nvim')
    use('kylechui/nvim-surround')
    use('nvim-tree/nvim-tree.lua')
    use('nvim-tree/nvim-web-devicons')
    use('williamboman/mason.nvim')
    use('williamboman/mason-lspconfig.nvim')
end) 
