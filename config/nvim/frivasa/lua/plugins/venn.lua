return {
	"jbyuki/venn.nvim",
	keys = {
		{ "<leader>tv", "<cmd>lua Toggle_venn()<CR>", desc = "Toggle Venn" },
	},
	config = function()
		function _G.Toggle_venn()
			local venn_enabled = vim.inspect(vim.b.venn_enabled)
			if venn_enabled == "nil" then
				vim.b.venn_enabled = true
				vim.cmd([[setlocal ve=all]])
				-- Enable keymappings for drawing
				vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
				vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
				vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
				vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
			else
				vim.cmd([[setlocal ve=]])
				vim.b.venn_enabled = nil
			end
		end
		vim.api.nvim_set_keymap("x", "<leader>b", ":VBox<CR>", { noremap = true, silent = true })
	end,
}
