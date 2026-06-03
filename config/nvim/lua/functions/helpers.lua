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

	vim.bo.buftype = ""
	vim.bo.bufhidden = ""
	vim.bo.swapfile = true

	vim.cmd("file " .. vim.fn.fnameescape(path))
	vim.cmd("write")

	print("Saved to " .. path)
end

--- Returns { lang, start_line (1-based), end_line (1-based) } or nil.
function M.quarto_code_block_at_cursor()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local cursor = vim.fn.line(".")

	local open_line, lang
	for i = cursor, 1, -1 do
		local l = lines[i - 1]
		local s, _, name = l:find("^```%s*{([^}]+)}")
		if s then
			open_line = i - 1
			lang = name
			break
		end
		if l:match("^```%s*$") and i < cursor then
			break
		end
	end
	if not open_line then
		return nil
	end

	local close_line
	for i = open_line + 1, #lines do
		if lines[i - 1]:find("^```%s*$") then
			close_line = i - 1
			break
		end
	end
	if not close_line then
		return nil
	end

	return { lang = lang, start_line = open_line + 1, end_line = close_line - 1 }
end

function M.quarto_all_code_blocks()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local blocks = {}
	local in_block, block_lang, block_start = false, nil, nil

	for i, line in ipairs(lines) do
		local s, _, name = line:find("^```%s*{(%w+)")
		if s then
			in_block = true
			block_lang = name
			block_start = i + 1
		elseif line:find("^```%s*$") then
			if in_block and block_start then
				table.insert(blocks, {
					lang = block_lang,
					start_line = block_start,
					end_line = i - 1,
				})
			end

			in_block = false
			block_lang = nil
			block_start = nil
		end
	end

	return blocks
end

function M.quarto_current_block_index()
	local cursor = vim.fn.line(".")
	local blocks = M.quarto_all_code_blocks()

	for i, b in ipairs(blocks) do
		if cursor >= b.start_line and cursor <= b.end_line then
			return i, blocks
		end
	end

	return nil, blocks
end

function M.quarto_prev_cell()
	local cursor = vim.fn.line(".")
	local idx, blocks = M.quarto_current_block_index()

	if #blocks == 0 then
		return
	end

	if idx then
		local target = blocks[idx - 1]
		if target then
			vim.api.nvim_win_set_cursor(0, { target.start_line, 0 })
			return
		end
	end

	for i = #blocks, -1, 1 do
		local b = blocks[i]
		if b.start_line < cursor then
			vim.api.nvim_win_set_cursor(0, { b.start_line, 0 })
			return
		end
	end

	vim.api.nvim_win_set_cursor(0, { blocks[#blocks].start_line, 0 })
end

function M.quarto_next_cell()
	local cursor = vim.fn.line(".")
	local idx, blocks = M.quarto_current_block_index()

	if #blocks == 0 then
		return
	end

	if idx then
		local target = blocks[idx + 1]
		if target then
			vim.api.nvim_win_set_cursor(0, { target.start_line, 0 })
			return
		end
	end

	for _, b in ipairs(blocks) do
		if b.start_line > cursor then
			vim.api.nvim_win_set_cursor(0, { b.start_line, 0 })
			return
		end
	end

	vim.api.nvim_win_set_cursor(0, { blocks[1].start_line, 0 })
end

function M.quarto_format_code(text, lang)
	if lang ~= "python" then
		return text
	end

	local lines = vim.split(text, "\n", { plain = true })
	local min_indent = math.huge
	for _, line in ipairs(lines) do
		local pos = line:find("%S")
		if pos then
			min_indent = math.min(min_indent, pos - 1)
		end
	end

	if min_indent == math.huge or min_indent == 0 then
		return text
	end

	local out = {}
	for _, line in ipairs(lines) do
		table.insert(out, (#line >= min_indent) and line:sub(min_indent + 1) or line)
	end
	return table.concat(out, "\n")
end

function M.quarto_run_up_to_cell()
	local idx, blocks = M.quarto_current_block_index()
	if not idx then
		return
	end

	for i = 1, idx do
		M.send_block(blocks[i])
	end
end

function M.quarto_send_cell()
	local block = M.quarto_code_block_at_cursor()
	if not block then
		print("Not inside a code cell")
		return
	end

	M.send_block(block)
	-- local lines = vim.api.nvim_buf_get_lines(0, block.start_line - 1, block.end_line, false)
	-- local text = M.quarto_format_code(table.concat(lines, "\n"), block.lang)
	-- vim.fn["slime#send"](text .. "\n")
end

function M.send_block(block)
	local lines = vim.api.nvim_buf_get_lines(0, block.start_line - 1, block.end_line, false)
	local text = M.quarto_format_code(table.concat(lines, "\n"), block.lang)
	vim.fn["slime#send"](text .. "\n")
end

function M.send_region()
	local is_quarto = vim.bo.filetype == "quarto"
	local block = is_quarto and M.quarto_code_block_at_cursor()

	local _, start_row = unpack(vim.fn.getpos("v"))
	local _, end_row = unpack(vim.fn.getpos("."))
	local s = math.min(start_row, end_row) - 1
	local e = math.max(start_row, end_row)
	local lines = vim.api.nvim_buf_get_lines(0, s, e, false)
	local text = table.concat(lines, "\n")

	if block then
		text = M.quarto_format_code(text, block.lang)
	end
	vim.fn["slime#send"](text .. "\n")
end

function M.quarto_open_repl(lang)
	return function()
		local origin_win = vim.api.nvim_get_current_win()
		local origin_buf = vim.api.nvim_get_current_buf()

		M.new_terminal(lang)()
		local job_id = vim.b.terminal_job_id

		vim.api.nvim_set_current_win(origin_win)
		vim.api.nvim_set_current_buf(origin_buf)
		vim.b.slime_config = { jobid = job_id }
		vim.notify("REPL ready — <CR> in visual mode or <leader> qc to run")
	end
end

return M
