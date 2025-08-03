function ColorMyPencils(color)
	-- color = color or "gruvbox-material"
	-- vim.cmd.colorscheme(color)
    -- require('gruvbox-material').setup({
    --     italics = true,             -- enable italics in general
    --     contrast = "medium",        -- set contrast, can be any of "hard", "medium", "soft"
    --     comments = {
    --         italics = true,           -- enable italic comments
    --     },
    --     background = {
    --         transparent = false,      -- set the background to transparent
    --     },
    --     float = {
    --         force_background = false, -- force background on floats even when background.transparent is set
    --         background_color = nil,   -- set color for float backgrounds. If nil, uses the default color set
    --         -- by the color scheme
    --     },
    --     signs = {
    --         highlight = true,         -- whether to highlight signs
    --     },
    --     customize = nil,            -- customize the theme in any way you desire, see below what this
    --     -- configuration accepts
    -- })

    -- require('onedark').setup {
    --     style = 'deep',
    --     transparent = true,
    --     lualine = {
    --         transparent = true, -- lualine center bar transparency
    --     },
    -- }
    -- require('onedark').load()

    -- require('nightfox').setup({
    --     options = {
    --         transparent = false,
    --     },
    -- })
    -- vim.cmd("colorscheme Terafox")
    -- vim.cmd("colorscheme Dawnfox")
    -- require("rose-pine").setup({
    --     variant = "moon"
    -- })
    -- vim.cmd("colorscheme rose-pine")
    require('kanagawa').setup()
    vim.cmd('colorscheme kanagawa-wave')

	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
end

ColorMyPencils()
