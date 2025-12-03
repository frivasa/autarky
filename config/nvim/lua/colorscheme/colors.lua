local M = {}

function M.get_colors()
	-- vim.cmd([[ source $HOME/.cache/wal/colors-wal.vim ]])
	local read = pcall(function()
		vim.cmd([[ source $HOME/.config/autarky/current/theme/nvim.vim"]])
	end)

	if read then
		return {
			background = vim.g.background,
			foreground = vim.g.foreground,
			cursor = vim.g.cursor,
			color0 = vim.g.color0,
			color1 = vim.g.color1,
			color2 = vim.g.color2,
			color3 = vim.g.color3,
			color4 = vim.g.color4,
			color5 = vim.g.color5,
			color6 = vim.g.color6,
			color7 = vim.g.color7,
			color8 = vim.g.color8,
			color9 = vim.g.color9,
			color10 = vim.g.color10,
			color11 = vim.g.color11,
			color12 = vim.g.color12,
			color13 = vim.g.color13,
			color14 = vim.g.color14,
			color15 = vim.g.color15,
		}
	else
		return {
			background = "#1a2724",
			foreground = "#c5c9c8",
			cursor = "#c5c9c8",
			color0 = "#1a2724",
			color1 = "#85c4b8",
			color2 = "#a8a9c5",
			color3 = "#706cab",
			color4 = "#bdbcc4",
			color5 = "#8780ab",
			color6 = "#9f92aa",
			color7 = "#c5c9c8",
			color8 = "#535d5a",
			color9 = "#85c4b8",
			color10 = "#a8a9c5",
			color11 = "#706cab",
			color12 = "#bdbcc4",
			color13 = "#8780ab",
			color14 = "#9f92aa",
			color15 = "#c5c9c8",
		}
	end
end

return M
