local vault_path = vim.fn.expand("~/12.vaults/al-amin")
local workspaces = {}

if vim.fn.isdirectory(vault_path) == 1 then
	table.insert(workspaces, {
		name = "al-amin",
		path = vault_path,
	})
end

return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = false, -- allow obsidian to be used by greeter
	ft = "markdown",

	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"hrsh7th/nvim-cmp",
		},
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter",
	},

	opts = {
		legacy_commands = false,

		checkbox = {
			order = { " ", "x", "" },
		},

		workspaces = workspaces,

		note_path_func = require("functions.helpers").note_path_func,
		note_id_func = function(title)
			if title ~= nil then
				return title
			end
			-- :ObsidianNew fallback
			return tostring(os.time())
		end,

		link = {
			format = "shortest",
			style = "wiki",
			auto_update = true,
		},

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

		search = {
			sort_by = "modified", -- path/accessed/created
			sort_reversed = true,
		},

		open_notes_in = "current",

		attachments = {
			folder = "_files/_img",
		},
	},
}
