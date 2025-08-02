return { -- Autocompletion
	"saghen/blink.cmp",
	dependencies = {
		"Kaiser-Yang/blink-cmp-avante",
		{ "L3MON4D3/LuaSnip", version = "v2.*" },
		"rafamadriz/friendly-snippets", -- has a lot of pre-made snippets
		"folke/lazydev.nvim",
	},
	version = "v1.*",
	opts = {
		keymap = { preset = "default" },

		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
		},
		sources = {
			default = { "avante", "lsp", "path", "snippets", "lazydev" },
			providers = {
				lazydev = {
					module = "lazydev.integrations.blink",
					name = "lz-dev",
					score_offset = 100,
				},
				avante = { module = "blink-cmp-avante", name = "Avante" },
			},
		},

		signature = { enabled = true },
	},
	-- 	completion = {
	-- 		-- By default, you may press `<c-space>` to show the documentation.
	-- 		documentation = {
	-- 			auto_show = true,
	-- 			auto_show_delay_ms = 500,
	-- 			treesitter_highlighting = true,
	-- 		},
	-- 	},
	-- 	sources = {
	-- 		default = { "avante", "lsp", "path", "snippets", "lazydev" },
	-- 		providers = {
	-- 			lazydev = {
	-- 				module = "lazydev.integrations.blink",
	-- 				name = "lz-dev",
	-- 				score_offset = 100,
	-- 			},
	-- 			avante = { module = "blink-cmp-avante", name = "Avante" },
	-- 		},
	-- 	},
	-- 	snippets = { preset = "luasnip" },
	-- 	-- the rust implementation via `'prefer_rust_with_warning'`
	-- 	fuzzy = { implementation = "prefer_rust_with_warning" },
	-- 	-- Shows a signature help window while you type arguments for a function
	-- 	-- signature = { enabled = true },
	-- },
	-- opts_extend = { "sources.default" },
}
