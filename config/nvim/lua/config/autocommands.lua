-- term-neovim comms for quarto-repl interaction
local function set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
	pattern = { "*" },
	command = "checktime",
})

-- vim.api.nvim_create_autocmd({ "TermOpen" }, {
-- 	pattern = { "*" },
-- 	callback = function(_)
-- 		vim.cmd.setlocal("nonumber")
-- 		vim.wo.signcolumn = "no"
-- 		set_terminal_keymaps()
-- 	end,
-- })

vim.api.nvim_create_autocmd({ "TermOpen" }, {
	pattern = { "*" },
	callback = function(args)
		vim.cmd.setlocal("nonumber")
		vim.wo.signcolumn = "no"
		set_terminal_keymaps()
		local buf = args.buf
		local name = vim.api.nvim_buf_get_name(buf)

		if name:match("quarto") and name:match("preview") then
			vim.api.nvim_buf_set_name(buf, "Quarto Preview")
		end
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
