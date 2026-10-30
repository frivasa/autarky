-- Adds git related signs to the gutter, as well as utilities for managing changes
return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			signs_staged = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{
		"sindrets/diffview.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-mini/mini.icons",
		},
		config = function()
			require("mini.icons").setup()
			MiniIcons.mock_nvim_web_devicons()
			local actions = require("diffview.actions")
			require("diffview").setup({
				enhanced_diff_hl = true,
				keymaps = {
					view = {
						["<leader>e"] = false,
						["<leader>b"] = false,
						{ "n", "<leader>ge", actions.focus_files },
						{ "n", "<leader>gb", actions.toggle_files },
						{ "n", "q", actions.close },
					},
					file_panel = {
						["<leader>e"] = false,
						["<leader>b"] = false,
						{ "n", "<leader>ge", actions.focus_files },
						{ "n", "<leader>gb", actions.toggle_files },
						{ "n", "q", "<CMD>DiffviewClose<CR>", { desc = "Close Diffview" } },
					},
				},
				enhanced_diff_hl = true,
				view = {
					default = {
						layout = "diff2_horizontal",
					},
					merge_tool = {
						layout = "diff3_mixed",
					},
					file_history = {
						layout = "diff2_horizontal",
					},
				},
			})
		end,
	},
}
