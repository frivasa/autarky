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

require("lazy").setup({
	require("plugins.treesitter"), -- syntax parser (coding context generator)
	require("plugins.telescope"), -- file search and grep
	require("plugins.gitsigns"), -- git symbols along gutter (change-add-delete symbols)
	require("plugins.oil"), -- text-block file manager
	require("plugins.vim-tmux-navigator"), -- move around nvim+tmux splits
	require("plugins.lualine"), -- bottom bar config/colors
	require("plugins.greeter"), -- add ascii poster and recent files on startup
	require("plugins.lsp"), -- language-specific hints and structures
	require("plugins.formatting"), -- fix spacing/indents on a per-lang basis
	require("plugins.autocompletion"), -- lsp companion, fills in if-elses, for-loops, etc
	require("plugins.quarto"), -- quarto document/webpage dev
	require("plugins.mini"), -- QoL plugin-package
	require("plugins.other"), -- any other QoL plugins
	require("plugins.obsidian"), -- obsidian manager
	require("plugins.auto-session"), -- save opened buffers for restarts
	require("plugins.harpoon"), -- buffer tabbing
})

require("config.keymaps")
require("config.commands")
require("config.autocommands")
require("colorscheme.colorscheme").setup()
