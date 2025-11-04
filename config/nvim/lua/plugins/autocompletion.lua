return { -- Autocompletion
	"saghen/blink.cmp",
	version = "1.*",
	dependencies = {
		{ "L3MON4D3/LuaSnip", version = "v2.*" },
		"rafamadriz/friendly-snippets", -- ton of snippets, default for blink
	},
	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "markdown" },
			callback = function()
				vim.b.completion = false
			end,
		})
	end,
	opts = {
		sources = {
			default = { "lsp", "snippets", "path", "buffer" },
		},
		signature = { -- CTRL+K (show inlay hints for function signature)
			window = { border = "rounded" },
			enabled = true,
		},
		fuzzy = { implementation = "prefer_rust_with_warning" }, -- use rust, else lua but warn
		keymap = { preset = "default" },
		completion = {
			keyword = { range = "prefix" }, -- only match to what's before the cursor (default: full)
			accept = {
				auto_brackets = {
					enabled = true, -- auto-insert brackets
				},
			},
			documentation = { -- CTRL+SPACE (show docstring)
				window = { border = "rounded" },
				auto_show_delay_ms = 300,
			},
			ghost_text = { enabled = true }, -- show stencils of what you would accept
			menu = {
				border = "none",
				direction_priority = function() -- move the blob around ghost_text to not cover it
					local ctx = require("blink.cmp").get_context()
					local item = require("blink.cmp").get_selected_item()
					if ctx == nil or item == nil then
						return { "s", "n" }
					end
					local item_text = item.textEdit ~= nil and item.textEdit.newText or item.insertText or item.label
					local is_multi_line = item_text:find("\n") ~= nil
					-- after showing the menu upwards, we want to maintain that direction
					-- until we re-open the menu, so store the context id in a global variable
					if is_multi_line or vim.g.blink_cmp_upwards_ctx_id == ctx.id then
						vim.g.blink_cmp_upwards_ctx_id = ctx.id
						return { "n", "s" }
					end
					return { "s", "n" }
				end,
				draw = {
					padding = { 1, 1 },
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind" },
						{ "source_id" },
					},
				},
			},
		},
	},
}
