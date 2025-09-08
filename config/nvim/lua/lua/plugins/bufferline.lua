return {
	"akinsho/bufferline.nvim",
	dependencies = {
		"moll/vim-bbye",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local function get_color(group, attr)
			local hl = vim.api.nvim_get_hl(0, { name = group })
			if hl[attr] then
				return string.format("#%06x", hl[attr])
			end
			return nil
		end

		local bfline = require("bufferline")
		bfline.setup({
			options = {
				mode = "buffers", -- set to "tabs" to only show tabpages instead
				themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
				numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
				close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
				buffer_close_icon = " ",
				close_icon = " ",
				path_components = 1, -- Show only the file name without the directory
				modified_icon = "●",
				left_trunc_marker = "",
				right_trunc_marker = "",
				max_name_length = 30,
				max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
				tab_size = 20,
				diagnostics = false,
				diagnostics_update_in_insert = false,
				color_icons = false,
				show_buffer_icons = false,
				show_buffer_close_icons = true,
				show_close_icon = true,
				persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
				separator_style = { "", "" }, -- { "", "" }, -- | "thick" | "thin" | { 'any', 'any' },
				enforce_regular_tabs = true,
				always_show_bufferline = true,
				show_tab_indicators = true,
				indicator = {
					style = "none", -- Options: 'icon', 'underline', 'none'
					-- icon = "", -- this should be omitted if indicator style is not 'icon'
				},
				icon_pinned = "󰐃",
				minimum_padding = 1,
				maximum_padding = 5,
				maximum_length = 15,
				sort_by = "insert_at_end",
				style_preset = bfline.style_preset.no_italic,
			},
			highlights = {
				fill = { fg = get_color("Normal", "fg"), bg = get_color("Normal", "bg") },
				background = { fg = get_color("Visual", "bg"), bg = get_color("Normal", "bg") },
				buffer_visible = { fg = get_color("Visual", "bg"), bg = get_color("Normal", "bg") },
				close_button_visible = { fg = get_color("Visual", "bg"), bg = get_color("Normal", "bg") },
				close_button = { fg = get_color("Visual", "bg"), bg = get_color("Normal", "bg") },
				buffer_selected = { fg = get_color("String", "fg"), bg = get_color("Normal", "bg") },
				close_button_selected = { fg = get_color("String", "fg"), bg = get_color("Normal", "bg") },
				modified = { bg = get_color("Normal", "bg") },
				tab = { fg = get_color("Visual", "bg"), bg = get_color("Normal", "bg") },
				tab_selected = { fg = get_color("String", "fg"), bg = get_color("Normal", "bg") },
				tab_close = { fg = get_color("Visual", "bg"), bg = get_color("Normal", "bg") },
				indicator_selected = { fg = get_color("Normal", "fg"), bg = get_color("Normal", "bg") },
				indicator_visible = { fg = get_color("Normal", "fg"), bg = get_color("Normal", "bg") },
			},
		})
	end,
}
