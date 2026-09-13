local M = {}

local OFFSET_LINES = 2
local FILENAME_SIZE = 60
local overlay

local modes = {
	n = "NOR",
	i = "INS",
	v = "VCHAR",
	V = "VLINE",
	["\22"] = "VBLOC", -- CTRL-V
	c = "COMM",
	R = "REPLACE",
	s = "SELCHAR",
	S = "SELLINE",
	t = "TERM",
}

local function close()
	if overlay and vim.api.nvim_win_is_valid(overlay) then
		vim.api.nvim_win_close(overlay, true)
	end
	overlay = nil
end

local function format_filename(filename)
	if vim.fn.strdisplaywidth(filename) <= FILENAME_SIZE then
		return filename
	end

	local len = vim.fn.strcharlen(filename)

	return "..." .. vim.fn.strcharpart(filename, len - FILENAME_SIZE, FILENAME_SIZE)
end

local function update()
	close()

	local win = vim.api.nvim_get_current_win()
	local buf = vim.api.nvim_win_get_buf(win)
	local mode = vim.api.nvim_get_mode().mode
	local symbol = modes[mode:sub(1, 1)]

	-- if not symbol or vim.bo[buf].buftype ~= "" then
	-- 	return
	-- end
	local buftype = vim.bo[buf].buftype

	if not symbol or (buftype ~= "" and buftype ~= "terminal") then
		return
	end

	local cursor = vim.api.nvim_win_get_cursor(win)
	local row, col = cursor[1], cursor[2]
	local total = vim.api.nvim_buf_line_count(buf)
	local perc = row / total * 100

	local filename
	if buftype == "terminal" then
		filename = "[TERM]"
	else
		filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")

		if filename == "" then
			filename = "[No Name]"
		else
			filename = format_filename(filename)
		end
	end

	local text = string.format("[ %d:%d:%d%% %s %s ]", row, col, perc, symbol, filename)
	local width = vim.fn.strdisplaywidth(text)

	-- geolocation
	local screen = vim.fn.screenpos(win, row, col + 1)

	if screen.row == 0 then
		return
	end

	local win_pos = vim.api.nvim_win_get_position(win)
	local win_width = vim.api.nvim_win_get_width(win)

	-- screen is 1-based, floating windows are 0-based
	local target_row = screen.row - 1 + OFFSET_LINES
	local win_height = vim.api.nvim_win_get_height(win)

	local split_top = win_pos[1]
	local split_bot = split_top + win_height - 1

	target_row = math.max(split_top, math.min(target_row, split_bot))

	local target_col = win_pos[2] + win_width - width - 1

	overlay = vim.api.nvim_open_win(vim.api.nvim_create_buf(false, true), false, {
		relative = "editor",
		row = target_row,
		col = math.max(win_pos[2], target_col),
		width = width,
		height = 1,
		style = "minimal",
		focusable = false,
		zindex = 50,
	})

	local overlay_buf = vim.api.nvim_win_get_buf(overlay)

	vim.api.nvim_buf_set_lines(overlay_buf, 0, -1, false, { text })

	vim.wo[overlay].winhl = "Normal:String"
end

local group = vim.api.nvim_create_augroup("LineOverlay", { clear = true })

vim.api.nvim_create_autocmd({
	"CursorMoved",
	"CursorMovedI",
	"ModeChanged",
	"BufEnter",
	"WinEnter",
	"WinScrolled",
	"VimResized",
}, {
	group = group,
	callback = vim.schedule_wrap(update),
})

vim.api.nvim_create_autocmd({
	"WinLeave",
	"BufLeave",
	"VimLeavePre",
}, {
	group = group,
	callback = close,
})

M.update = update
M.close = close

return M
