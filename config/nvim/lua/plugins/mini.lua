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
		-- require("mini.surround").setup({
		-- 	mappings = {
		-- 		add = "sa", -- Add surrounding (normal + visual)
		-- 		delete = "sd", -- Delete surrounding
		-- 		replace = "sr", -- Replace surrounding (normal + visual)
		-- 		find = "sf", -- Find right surrounding
		-- 		find_left = "sF", -- Find left surrounding
		-- 		highlight = "sh", -- Highlight surrounding
		-- 		update = "su", -- Update highlight
		-- 		switch = "sn", -- Switch to next surrounding
		-- 		switch_left = "sN", -- Switch to left surrounding
		-- 	},
		-- })
		-- show current indent
		require("mini.indentscope").setup({
			symbol = "|",
			options = {
				n_lines = 3000,
			},
		})
	end,
}
