return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify", -- optional, for nicer message popups
	},
	opts = {
		cmdline = {
			view = "cmdline_popup", -- floating popup instead of bottom line
		},
		messages = {
			enabled = true,
			view = "notify",
		},
		popupmenu = {
			enabled = true, -- wildmenu/completion popup
		},
	},
}
