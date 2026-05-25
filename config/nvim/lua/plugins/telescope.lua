return { -- Fuzzy Finder (files, lsp, etc)
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		local actions = require("telescope.actions")
		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-l>"] = actions.select_default, -- open file
						["<C-g>"] = function(prompt_bufnr)
							local selection = require("telescope.actions.state").get_selected_entry()
							actions.close(prompt_bufnr)
							if selection and selection.path then
								local dir = vim.fn.fnamemodify(selection.path, ":p:h")
								vim.cmd("cd " .. vim.fn.fnameescape(dir))
								vim.cmd("edit " .. selection.path)
								vim.cmd("echo 'cwd → " .. dir .. "'")
							end
						end,
					},
				},
			},
			pickers = {
				find_files = {
					find_command = {
						"rg",
						"--files",
						"--hidden", -- show hiden files
						"--smart-case",
						"--glob",
						"!**/.git/*",
						"--glob",
						"!**/.venv/*",
						"--glob",
						"!**/.pixi/*",
						"--glob",
						"!**/.themes/*",
						"--glob",
						"!**/.claude/*",
						"--glob",
						"!**/.cache/*",
						"--glob",
						"!**/.zen/*",
					},
					-- DO NOT USE file_ignore_patterns!
					-- slow as a MF bc it gets parsed by lua, not by rg itself
					-- rg waterboards telescope so it cannot keep up and show you what's happening
				},
				live_grep = { -- rg command without --files
					additional_args = function(_)
						return {
							"--hidden",
							"--no-binary",
							"--glob",
							"!**/.git/*",
							"--glob",
							"!**/.venv/*",
							"--glob",
							"!**/.claude/*",
							"--glob",
							"!**/.cargo/*",
							"--glob",
							"!**/.cache/*",
						}
					end,
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
		-- vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		-- vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
		vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
		vim.keymap.set("n", "<leader>sb", function()
			builtin.buffers({ show_all_buffers = true })
		end, { desc = "[ ] Find existing buffers (all)" })
		vim.keymap.set("n", "<leader>sl", function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })
		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[S]earch [/] in Open Files" })

		-- Shortcut for searching your Neovim configuration files
		vim.keymap.set("n", "<leader>sn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[S]earch [N]eovim files" })
	end,
}
