return {
	"echasnovski/mini.nvim",
	config = function()
		-- oil-capable, yazi-like file browser overlay
		require("mini.files").setup({
			init = function() end,
		})
		-- gS to split/join argument groups into one-per-line or all in a single one
		require("mini.splitjoin").setup()
		-- pick bracketed stuff, delete/add brackets
		require("mini.surround").setup()
		-- show current indent
		require("mini.indentscope").setup({
			symbol = "|",
			options = {
				n_lines = 3000,
			},
		})
	end,
}
