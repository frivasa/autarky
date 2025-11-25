return { -- Standalone plugins other than snacks or mini
	{ -- keybind hints
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "modern",
			icons = { colors = true, group = "", separator = "", rules = false },
		},
		keys = {
			{
				"<leader>hl",
				function()
					require("which-key").show({ global = false, loop = true })
				end,
				desc = "Buffer Local Keymaps",
			},
			{
				"<leader>hg",
				function()
					require("which-key").show({ global = true, loop = true })
				end,
				desc = "Buffer Global Keymaps",
			},
		},
	},
	{ -- autoclose brackets
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {
			rgb_fn = true,
			mode = "foreground",
		},
	},
	{ -- color highlighter
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{ -- see your undo/redos like a git (diff and history).
		"mbbill/undotree",
		lazy = false,
		config = function()
			vim.g.undotree_WindowLayout = 2
			vim.keymap.set("n", "<leader>tu", "<CMD>UndotreeToggle <CR>", {
				desc = "Toggle undo tree",
			})
		end,
	},
	{ -- drag starting indent lines with pane (like always see the definition of a function)
		"nvim-treesitter/nvim-treesitter-context",
		opts = {},
	},
	{ -- flash (jump cursor)
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			label = {
				rainbow = {
					enabled = false,
					shade = 8,
				},
			},
		},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
		},
	},
}
