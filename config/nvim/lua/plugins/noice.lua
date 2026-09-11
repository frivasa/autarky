return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify", -- optional, for nicer message popups
	},
	opts = {
		cmdline = {
			view = "cmdline",
		},
		-- or use "cmdline" (classic bottom line) if you just want messages popup-ified
		messages = {
			enabled = true,
			view = "notify",
		},
		popupmenu = {
			enabled = true, -- wildmenu/completion popup
		},
	},
}
