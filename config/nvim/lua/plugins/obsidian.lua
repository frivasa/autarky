local vault_path = "/home/fdo/12.vaults/al-amin/"
return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = false,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- someday this wont be necesary, the plugin maintainer wants to setup an LSP
		{
			"hrsh7th/nvim-cmp",
		},
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter",
	},
	opts = {
		legacy_commands = false,
		checkbox = {
			order = { " ", "x" },
		},
		workspaces = {
			{
				name = "al-amin",
				path = vault_path,
			},
		},
		notes_subdir = "_nvim-temps",
		new_notes_location = "notes_subdir",
		-- mappings = {
		-- 	-- Smart action depending on context, either follow link or toggle checkbox.
		-- 	["<cr>"] = {
		-- 		action = function()
		-- 			return require("obsidian").util.smart_action()
		-- 		end,
		-- 		opts = { buffer = true, expr = true },
		-- 	},
		-- },
		preferred_link_style = "wiki",
		wiki_link_func = "prepend_note_path",
		frontmatter = {
			enabled = false,
		},
		picker = {
			name = "telescope.nvim",
			note_mappings = {
				new = "<C-x>", -- make a new note from query (?)
				insert_link = "<C-l>", -- insert link to highlighted note
			},
			tag_mappings = {
				tag_note = "<C-x>",
				insert_tag = "<C-l>",
			},
		},
		completion = {
			nvim_cmp = true,
			blink = true,
			min_chars = 2,
		},
		search = {
			sort_by = "modified", -- path/accessed/created
			sort_reversed = true,
		},
		open_notes_in = "current",
		attachments = { img_folder = "_files/_img" },
	},
}
