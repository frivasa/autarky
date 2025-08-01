return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		image = { enabled = true }, -- render images,pdfs,md,and others
		bigfile = { enabled = true }, -- disable lsp when opening a big file
		indent = { enabled = true }, -- draw indents
		notify = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
	},
}
