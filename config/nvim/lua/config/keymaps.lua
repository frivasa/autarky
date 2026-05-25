local wk = require("which-key")
local fn = require("functions.helpers")
-- local icons = require("mini.icons")
local opts = { noremap = true, silent = true }
local nor = { mode = "n", opts }
-- local vis = { mode = "v", opts }
-- noremap = nor+vis+select+operator (allows "repeatability")

local slime_send_region_cmd = ":<C-u>call slime#send_op(visualmode(), 1)<CR>"
slime_send_region_cmd = vim.api.nvim_replace_termcodes(slime_send_region_cmd, true, false, true)
local function send_region()
	-- save location before sending the chunk
	local _, line, col, _ = unpack(vim.fn.getpos("."))

	-- if filetype is not quarto, just send_region
	if vim.bo.filetype ~= "quarto" or vim.b["quarto_is_r_mode"] == nil then
		-- vim.cmd("normal" .. slime_send_region_cmd)
		local _, start_row, _, _ = unpack(vim.fn.getpos("v"))
		local _, end_row, _, _ = unpack(vim.fn.getpos("."))
		start_line = math.min(start_row, end_row) - 1
		end_line = math.max(start_row, end_row)
		local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line + 1, false)
		vim.fn["slime#send"]('exec("""\n' .. table.concat(lines, "\n") .. '""")\n\r')
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
		-- vim.cmd("normal! <Esc>") does not fucking work!
		return
	end
	if vim.b["quarto_is_r_mode"] == true then
		vim.g.slime_python_ipython = 0
		local is_python = require("otter.tools.functions").is_otter_language_context("python")
		if is_python and not vim.b["reticulate_running"] then
			vim.fn["slime#send"]("reticulate::repl_python()" .. "\r")
			vim.b["reticulate_running"] = true
		end
		if not is_python and vim.b["reticulate_running"] then
			vim.fn["slime#send"]("exit" .. "\r")
			vim.b["reticulate_running"] = false
		end
		vim.cmd("normal" .. slime_send_region_cmd)
	end
end
-- command is really picky, put it close to the function so that it works
wk.add({
	{ "<CR>", fn.send_region, desc = "Run Code Region", mode = "v" },
	{ "<leader>iq", fn.QuoteAndCommaVisual, desc = "Quote lines", mode = "v" },
})

-- "local" keymaps
wk.add({
	{ "<C-q>", "<CMD>q<CR>", desc = "Quit File", nor },
	{ "<C-s>", "<CMD>w<CR>", desc = "Save File", nor },
	{ "<S-Tab>", "<CMD>bprevious<CR>", desc = "Prev Buffer", nor },
	{ "<Tab>", "<CMD>bnext<CR>", desc = "Next Buffer", nor },
	{ "<ESC>", "<CMD>nohlsearch<CR>", desc = "Clear Search Highlights", nor },
	{ "x", '"_x', desc = "Delete without copying", nor },
	{ "n", "nzzzv", desc = "center word search", nor },
	{ "N", "Nzzzv", desc = "center backwards word search", nor },
	{ "<C-d>", "<C-d>zz", desc = "scroll down and center", nor },
	{ "<C-u>", "<C-u>zz", desc = "scroll up and center", nor },
	{ "<C-LeftMouse>", "<CMD>lua vim.lsp.buf.definition()<CR>", desc = "Go to Definition", nor },
	{ "<", "<gv", desc = "indent repeatedly leftward", nor },
	{ ">", ">gv", desc = "indent repeatedly righward", nor },
	{ "<Up>", ":resize -2<CR>", desc = "nudge pane upwards", nor },
	{ "<Down>", ":resize +2<CR>", desc = "nudge pane downwards", nor },
	{ "<Left>", ":vertical resize -2<CR>", desc = "nudge pane leftwards", nor },
	{ "<Right>", ":vertical resize +2<CR>", desc = "nudge pane rightwards", nor },
})

wk.add({
	{ "<Space>", "<NOP>", mode = { "n", "v" }, opts },
	{ "<leader>h", group = "Help", icon = { icon = "󰰀 ", color = "purple" } },
	{ "<leader>hm", "<CMD>messages<CR>", desc = "Show Message History", nor },
	{ "<leader>a", group = "Bots", icon = { icon = " ", color = "purple" } },
	{ "<leader>r", group = "Replace", icon = { icon = "󰰞 ", color = "purple" } },
	{
		"<leader>rn",
		function()
			return ":IncRename " .. vim.fn.expand("<cword>")
		end,
		desc = "Rename word under cursor",
		expr = true,
		nor,
	},
	{ "<leader>i", group = "Insert", icon = { icon = "󰰃 ", color = "purple" } },
	{ "<leader>iz", "<CMD>Telescope spell_suggest<CR>", desc = "Spell Suggestions", nor },
	{ "<leader>is", group = "Snippets", icon = { icon = "󰅩 ", color = "yellow" } },
	{ "<leader>isl", "<ESC>i```{lua}<cr>```<ESC>O", desc = "Lua", nor },
	{ "<leader>isp", "<ESC>i```{python,python.reticulate=FALSE}<cr>```<ESC>O", desc = "Python", nor },
	{ "<leader>isr", "<ESC>i```{r}<cr>```<ESC>O", desc = "R", nor },
	{ "<leader>d", group = "Debug", icon = { icon = "󰨰 ", color = "purple" } },
	{ "<leader>dqq", vim.diagnostic.setloclist, desc = "Diagnostics List", nor },
	{ "<leader>dqf", vim.diagnostic.open_float, desc = "Diagnostics List (float)", nor },
	{ "<leader>e", group = "Harpoon", icon = { icon = "󰛢", color = "purple" } },
	{ "<leader>q", group = "Quarto", icon = { icon = "󱡓 ", color = "purple" } },
	{ "<leader>qp", "<CMD>QuartoPreview --no-clean<CR>", desc = "[P]review", nor },
	{ "<leader>qa", "<CMD>QuartoSendAbove<CR>", desc = "Run [A]bove", nor },
	{ "<leader>qc", "<CMD>QuartoSend<CR>", desc = "Run [C]ell", nor },
	{ "<leader>qe", require("otter").export, desc = "[E]xport code to file", nor },
	{ "<leader>g", group = "Guardar", icon = { icon = " ", color = "purple" } },
	{ "<leader>gn", "<CMD>noautocmd w<CR>", desc = "Save w/o Formatting", nor },
	{ "<leader>gg", fn.save_scratch_to_dl, desc = "Save Scratch to Downloads", nor },
	{ "<leader>s", group = "Search (Telescope)", icon = { icon = " ", color = "purple" } },
	{ "<leader>so", "<CMD>Obsidian quick_switch<CR>", desc = "Search Vault Pages (Obsidian)", nor },
	{ "<leader>sv", "<CMD>Obsidian search<CR>", desc = "Grep Vault (Obsidian)", nor },
	{ "<leader>m", group = "Mvmt", icon = { icon = "󰜎 ", color = "purple" } },
	{ "<leader>ml", "<CMD>Obsidian follow_link vsplit<CR>", desc = "Obsidian Follow Link", nor },
	{ "<leader>mu", fn.go_up, desc = "Move up in :pwd", nor },
	{ "<leader>o", group = "Open/Splits", icon = { icon = "󰠜 ", color = "purple" } },
	{ "<leader>on", "<CMD>Obsidian new<CR>", desc = "Open a New Page (Obsidian)", nor },
	{ "<leader>ob", "<CMD>enew<CR>", desc = "New Scratch Buffer", nor },
	-- { "<leader>ot", "<CMD>tabnew<CR>", desc = "New Tab", nor },
	{ "<leader>ov", "<C-w>v", desc = "Vertical Split", nor },
	{ "<leader>oh", "<C-w>s", desc = "Horizontal Split", nor },
	{ "<leader>op", fn.new_terminal("python"), desc = "new [p]ython terminal", nor },
	{ "<leader>or", fn.new_terminal("R"), desc = "new [r]-code terminal", nor },
	{ "<leader>oi", fn.new_terminal("ipython"), desc = "new [i]python", nor },
	{ "<leader>of", ":lua MiniFiles.open()<CR>", desc = "File Browser (MiniFiles)", nor },
	{ "<leader>x", group = "Close", icon = { icon = "󰰰 ", color = "purple" } },
	{ "<leader>xt", "<CMD>tabclose<CR>", desc = "Close Tab", nor },
	{ "<leader>xx", "<CMD>bdelete!<CR>", desc = "Close Buffer", nor },
	{ "<leader>xs", "<CMD>close<CR>", desc = "Close Split", nor },
	{ "<leader>t", group = "Toggles", icon = { icon = "󰨚 ", color = "purple" } },
	{ "<leader>ta", fn.toggle_autocomplete, desc = "Toggle Autocomplete", nor },
	{ "<leader>tg", fn.toggle_gutter, desc = "Toggle Gutter (line numbers, git symbols, etc)", nor },
	{ "<leader>tc", "<CMD>Obsidian toggle_checkbox<CR>", desc = "Obsidian Toggle Checkbox", nor },
	{ "<leader>te", "<C-w>=", desc = "Equalize Splits", nor },
	{ "<leader>tp", "<CMD>BufferLineTogglePin <CR>", desc = "Toggle Pinned", mode = { "n", "v" }, opts },
	{ "<leader>tw", "<CMD>set wrap!<CR>", desc = "Toggle Wrap", nor },
	{ "<leader>tz", "<CMD>setlocal spell!<CR>", desc = "Toggle Spellcheck", nor },
	{ "<leader>w", group = "Sessions", icon = { icon = " ", color = "purple" } },
	{ "<leader>wr", "<CMD>AutoSession search<CR>", desc = "Session search", nor },
	{ "<leader>ws", "<CMD>AutoSession save<CR>", desc = "Save session", nor },
	{ "<leader>wa", "<CMD>AutoSession toggle<CR>", desc = "Toggle autosave", nor },
})
