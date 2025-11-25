require("config.options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- colorschemes are inherited from kitty via pywal
require("lazy").setup({
	require("plugins.colorscheme-pywal"), -- pywal colorscheme integration
	require("plugins.treesitter"), -- reference finding ("open file with var/function")
	require("plugins.telescope"), -- file search and grep
	require("plugins.gitsigns"), -- git symbols along gutter (change-add-delete symbols)
	require("plugins.oil"), -- git symbols along gutter (change-add-delete symbols)
	require("plugins.vim-tmux-navigator"), -- move around nvim+tmux splits
	require("plugins.lualine"), -- bottom bar config/colors
	require("plugins.harpoon"), -- buffer tabbing
	require("plugins.greeter"), -- add ascii poster and recent files on startup
	-- require("plugins.bufferline"), -- top bar configuration ("show tabs")
	require("plugins.lsp"), -- language-specific hints and structures
	require("plugins.autocompletion"), -- lsp companion, fills in if-elses, for-loops, etc
	require("plugins.formatting"), -- fix spacing/indents on a per-lang basis
	-- require("plugins.obsidian"), -- obsidian manager
	require("plugins.quarto"), -- quarto document/webpage dev
	require("plugins.snacks"), -- group of QoL plugins
	require("plugins.mini"), -- shitload of plugins
	require("plugins.other"), -- any other few-line plugins
	require("plugins.auto-session"), -- draw diagrams
})

require("config.keymaps")
require("config.commands")
require("config.autocommands")
require("config.highlights").setup()
