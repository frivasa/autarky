local M = {}
local core = require("colorscheme.colors")

function M.setup()
	local colors = core.get_colors()
	vim.opt.termguicolors = true
	local highlights = require("colorscheme.highlights").highlights(colors)
	for group, properties in pairs(highlights) do
		vim.api.nvim_set_hl(0, group, properties)
	end
	require("colorscheme.secondary").setup()
end

return M
