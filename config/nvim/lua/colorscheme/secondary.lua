local M = {}

function M.setup()
	-- autocompletion (blink)
	vim.api.nvim_set_hl(0, "BlinkCmpKind", { link = "Comment" })
	vim.api.nvim_set_hl(0, "BlinkCmpSource", { link = "Debug" })
	vim.api.nvim_set_hl(0, "BlinkCmpGhostText", { link = "DiffDelete" })
	vim.api.nvim_set_hl(0, "BlinkCmpKindText", { link = "DiffAdd" })
	vim.api.nvim_set_hl(0, "BlinkCmpKindFunction", { link = "DiffChange" })
	-- undotree.nvim
	vim.api.nvim_set_hl(0, ".undotree_HighlightSyntaxAdd", { link = "Normal" })
	vim.api.nvim_set_hl(0, ".undotree_HighlightSyntaxChange", { link = "Normal" })
	vim.api.nvim_set_hl(0, ".undotree_HighlightSyntaxDel", { link = "Normal" })
	vim.api.nvim_set_hl(0, ".undotree_HighlightChangedWithSign", { link = "Normal" })
	vim.api.nvim_set_hl(0, ".undotree_HighlightChangedText", { link = "Normal" })
	-- plugins.other.flash
	vim.api.nvim_set_hl(0, "FlashBackdrop", { link = "Comment" })
	vim.api.nvim_set_hl(0, "FlashMatch", { link = "Comment" })
	vim.api.nvim_set_hl(0, "FlashCurrent", { link = "Comment" })
	vim.api.nvim_set_hl(0, "FlashLabel", { link = "DiffChange" })
	vim.api.nvim_set_hl(0, "FlashPrompt", { link = "CurSearch" })
	vim.api.nvim_set_hl(0, "FlashPromptIcon", { link = "CurSearch" })
	-- vim.api.nvim_set_hl(0, "FlashCursor", { link = "Comment" })

	vim.api.nvim_set_hl(0, "ObsidianRefText", { link = "Todo" })
	vim.api.nvim_set_hl(0, "ObsidianTodo", { link = "Todo" })
	vim.api.nvim_set_hl(0, "ObsidianDone", { link = "Normal" })
	vim.api.nvim_set_hl(0, "ObsidianBullet", { link = "NonText" })
end

-- guifg=#c9c8c8 guibg=#c7b7b5

return M
