return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"rcarriga/nvim-dap-ui",
			"mfussenegger/nvim-dap-python",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			local dap_python = require("dap-python")

			require("dapui").setup({})
			require("nvim-dap-virtual-text").setup({
				commented = true, -- Show virtual text alongside comment
			})

			dap_python.setup("python3")

			vim.fn.sign_define("DapBreakpoint", {
				text = "",
				texthl = "DiagnosticSignError",
				linehl = "",
				numhl = "",
			})

			vim.fn.sign_define("DapBreakpointRejected", {
				text = "", -- or "❌"
				texthl = "DiagnosticSignError",
				linehl = "",
				numhl = "",
			})

			vim.fn.sign_define("DapStopped", {
				text = "", -- or "→"
				texthl = "DiagnosticSignWarn",
				linehl = "Visual",
				numhl = "DiagnosticSignWarn",
			})

			-- Automatically open/close DAP UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end

			local opts = { noremap = true, silent = true }

			-- Toggle breakpoint
			vim.keymap.set("n", "<leader>db", function()
				dap.toggle_breakpoint()
			end, { desc = "Toggle Breakpoint" }, opts)

			-- Continue / Start
			vim.keymap.set("n", "<leader>dc", function()
				dap.continue()
			end, { desc = "Start/Continue" }, opts)

			-- Step Over
			vim.keymap.set("n", "<leader>do", function()
				dap.step_over()
			end, { desc = "Step Over" }, opts)

			-- Step Into
			vim.keymap.set("n", "<leader>di", function()
				dap.step_into()
			end, { desc = "Step Into" }, opts)

			-- Step Out
			vim.keymap.set("n", "<leader>dO", function()
				dap.step_out()
			end, { desc = "Step Out" }, opts)

			-- Keymap to terminate debugging
			vim.keymap.set("n", "<leader>dq", function()
				require("dap").terminate()
			end, { desc = "Stop" }, opts)

			-- Toggle DAP UI
			vim.keymap.set("n", "<leader>td", function()
				dapui.toggle()
			end, { desc = "Toggle debug UI" }, opts)
		end,
	},
}
