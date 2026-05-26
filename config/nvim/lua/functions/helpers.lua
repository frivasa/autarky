local M = {}

function M.toggle_gutter()
	local number = vim.wo.number
	local signcolumn = vim.wo.signcolumn

	if number then
		vim.wo.number = false
	else
		vim.wo.number = true
	end

	if signcolumn == "no" then
		vim.wo.signcolumn = "yes"
	else
		vim.wo.signcolumn = "no"
	end
end

function M.go_up()
	local prev = vim.fn.getcwd()
	vim.cmd("cd ..")
	print(prev .. " → " .. vim.fn.getcwd())
end

function M.toggle_autocomplete()
	if vim.b.completion == nil then
		vim.b.completion = true
	end
	if vim.b.completion then
		vim.b.completion = false
	else
		vim.b.completion = true
	end
end

local function trim(s)
	return s:match("^%s*(.-)%s*$")
end
-- convert a column of values to a quoted list
function M.QuoteAndCommaVisual()
	-- '<,'> picks the last visual start and end
	-- this does not work when used before the visual marks are set!
	local mode = vim.fn.mode()
	local start_line, end_line

	if mode == "v" or mode == "V" then
		local _, start_row, _, _ = unpack(vim.fn.getpos("v"))
		local _, end_row, _, _ = unpack(vim.fn.getpos("."))
		start_line = math.min(start_row, end_row) - 1
		end_line = math.max(start_row, end_row)
	else
		start_line = vim.fn.line("'<") - 1
		end_line = vim.fn.line("'>")
	end
	local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)

	for i, line in ipairs(lines) do
		local trimmed = trim(line)
		lines[i] = '"' .. trimmed .. '",'
	end
	vim.api.nvim_buf_set_lines(0, start_line, end_line, false, lines)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
end

function M.new_terminal(lang)
	return function()
		local cwd = vim.loop.cwd()
		vim.cmd("enew")
		vim.cmd("lcd " .. cwd)
		if lang and #lang > 0 then
			vim.cmd("terminal " .. lang)
		else
			vim.cmd("terminal bash")
			lang = "bash"
		end

		local buf = vim.api.nvim_get_current_buf()
		vim.api.nvim_buf_set_name(buf, "term://" .. lang)
	end
end

function M.save_scratch_to_dl()
	vim.cmd("stopinsert")
	local name = vim.fn.input("Filename: ")

	if name == nil or name == "" then
		print("Cancelled")
		return
	end

	local path = vim.fn.expand("$HOME/Downloads/" .. name)

	-- turn scratch buffer into a normal buffer
	vim.bo.buftype = ""
	vim.bo.bufhidden = ""
	vim.bo.swapfile = true

	-- set filename + write
	vim.cmd("file " .. vim.fn.fnameescape(path))
	vim.cmd("write")

	print("Saved to " .. path)
end

-- BOTSPEAK START ---
--------------------------------------------------
-- A: visual range helper
--------------------------------------------------
local function get_visual_range()
	local _, start_row, _, _ = unpack(vim.fn.getpos("v"))
	local _, end_row, _, _ = unpack(vim.fn.getpos("."))

	local s = math.min(start_row, end_row) - 1
	local e = math.max(start_row, end_row) - 1

	return s, e
end

--------------------------------------------------
-- B: plain SLIME sender
--------------------------------------------------
local function send_plain_region()
	local start_line, end_line = get_visual_range()

	local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line + 1, false)

	local payload = 'exec("""\n' .. table.concat(lines, "\n") .. '\n""")\n\r'

	vim.fn["slime#send"](payload)

	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
end

--------------------------------------------------
-- C: quarto / R mode handler
--------------------------------------------------
local function handle_quarto_r_mode()
	vim.g.slime_python_ipython = 0

	local is_python = require("otter.tools.functions").is_otter_language_context("python")

	if is_python and not vim.b.reticulated_running then
		vim.fn["slime#send"]("reticulate::repl_python()\r")
		vim.b.reticulated_running = true
	elseif not is_python and vim.b.reticulated_running then
		vim.fn["slime#send"]("exit\r")
		vim.b.reticulated_running = false
	end

	local cmd = vim.api.nvim_replace_termcodes(":<C-u>call slime#send_op(visualmode(), 1)<CR>", true, false, true)

	vim.cmd("normal" .. cmd)
end

--------------------------------------------------
-- D: public entry point
--------------------------------------------------
function M.send_region()
	local is_quarto = vim.bo.filetype == "quarto"
	local is_r_mode = vim.b["quarto_is_r_mode"] == true

	if not is_quarto or not is_r_mode then
		send_plain_region()
		return
	end

	handle_quarto_r_mode()
end

-- BOTSPEAK END ---

return M
