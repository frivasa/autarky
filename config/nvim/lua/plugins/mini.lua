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

		local function glyph_map(filetypes, glyph, hl)
			local result = {}

			for _, ft in ipairs(filetypes) do
				result[ft] = { glyph = glyph }

				if hl then
					result[ft].hl = hl
				end
			end

			return result
		end

		local extension = {}
		extension = vim.tbl_extend(
			"force",
			extension,
			glyph_map({ "mp4", "mkv", "webm", "avi", "mov", "m4v", "mpeg", "mpg", "wmv" }, "", "MiniIconsGreen")
		)
		extension = vim.tbl_extend(
			"force",
			extension,
			glyph_map({ "mp3", "flac", "ogg", "wav", "m4a", "aac", "wma" }, "", "MiniIconsOrange")
		)
		extension = vim.tbl_extend(
			"force",
			extension,
			glyph_map({ "arw", "raw", "jpeg", "jpg", "png", "webp" }, "", "MiniIconsPurple")
		)
		extension = vim.tbl_extend(
			"force",
			extension,
			glyph_map({ "pdf", "epub", "txt", "readme", "lua" }, "󰭤", "MiniIconsAzure")
		)
		extension = vim.tbl_extend(
			"force",
			extension,
			glyph_map(
				{ "md", "epub", "readme", "lua", "toml", "json", "yml", "css", "config", "html", "ini" },
				"",
				"MiniIconsAzure"
			)
		)
		extension = vim.tbl_extend(
			"force",
			extension,
			glyph_map({ "py", "rs", "qmd", "css", "c", "tex" }, "", "MiniIconsYellow")
		)

		require("mini.icons").setup({
			directory = {
				hl = "MiniIconsAzure",
				Downloads = {
					hl = "MiniIconsAzure",
				},
				Pictures = {
					hl = "MiniIconsAzure",
				},
			},

			extension = extension,
			file = {
				["README.md"] = { glyph = "" },
				["Readme.md"] = { glyph = "" },
				["readme.md"] = { glyph = "" },
			},
		})
	end,
}
