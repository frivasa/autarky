return {
	"echasnovski/mini.nvim",
	config = function()
		-- oil-capable, yazi-like file browser overlay
		require("mini.files").setup({
			init = function() end,
		})
		-- gS to split/join argument groups into one-per-line or all in a single one
		require("mini.splitjoin").setup()
		require("mini.surround").setup() -- pick bracketed stuff, delete/add brackets
		-- <leader>ENTER to jump by chars to position hints (nice)
		-- require("mini.jump2d") -- char code mvmt, superseeded by flash.nvim
		-- require("mini.ai").setup() -- textobject mvmt, superseeded by flash.nvim
		-- require("mini.diff").setup({
		-- 	source = require("mini.diff").gen_source.none(),
		-- })
		-- might use in the future: these allow saving sessions and
		-- previously visited files/buffers
		-- require("mini.sessions")
		-- require("mini.visits")
	end,
}
