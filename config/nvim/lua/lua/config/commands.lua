vim.api.nvim_create_user_command("SaveHighlightPalette", function()
	local groups = {
		"Normal",
		"NormalFloat",
		"CursorLine",
		"Visual",
		"Comment",
		"Function",
		"String",
		"Type",
		"ErrorMsg",
		"DiagnosticError",
		"DiagnosticHint",
		"LineNr",
		"StatusLine",
		"TabLine",
		"WinSeparator",
		"Title",
	}

	local function hex(c)
		return c and string.format("#%06x", c) or nil
	end

	local palette = {}
	for _, group in ipairs(groups) do
		local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group })
		if ok then
			palette[group] = {
				fg = hex(hl.fg),
				bg = hex(hl.bg),
				sp = hex(hl.sp),
			}
		end
	end

	local file = io.open("palette.json", "w")
	file:write(vim.fn.json_encode(palette))
	file:close()

	print("Saved palette to palette.json")
end, { desc = "Dump most highlight groups to a JSON file" })
