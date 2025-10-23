return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"saghen/blink.cmp",
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end
				map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
				map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
				map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
				map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
				map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
				map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")
				local function client_supports_method(client, method, bufnr)
					if vim.fn.has("nvim-0.11") == 1 then
						return client:supports_method(method, bufnr)
					else
						return client.supports_method(method, { bufnr = bufnr })
					end
				end
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if
					client
					and client_supports_method(
						client,
						vim.lsp.protocol.Methods.textDocument_documentHighlight,
						event.buf
					)
				then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end
				if
					client
					and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
				then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})
		vim.diagnostic.config({
			severity_sort = true,
			float = { border = "rounded", source = "if_many" },
			underline = { severity = vim.diagnostic.severity.ERROR },
			signs = vim.g.have_nerd_font and {
				text = {
					[vim.diagnostic.severity.ERROR] = "󰅚 ",
					[vim.diagnostic.severity.WARN] = "󰀪 ",
					[vim.diagnostic.severity.INFO] = "󰋽 ",
					[vim.diagnostic.severity.HINT] = "󰌶 ",
				},
			} or {},
			virtual_text = {
				source = "if_many",
				spacing = 2,
				format = function(diagnostic)
					local diagnostic_message = {
						[vim.diagnostic.severity.ERROR] = diagnostic.message,
						[vim.diagnostic.severity.WARN] = diagnostic.message,
						[vim.diagnostic.severity.INFO] = diagnostic.message,
						[vim.diagnostic.severity.HINT] = diagnostic.message,
					}
					return diagnostic_message[diagnostic.severity]
				end,
			},
		})
		require("mason-tool-installer").setup({
			ensure_installed = {
				"stylua",
				"lua_ls",
				"pylsp",
				"pyright",
				"jsonls",
				"black",
				"ruff",
				"isort",
				"prettier",
				"cpplint",
				"clangd",
				"clang-format",
			},
		})

		-- Get enhanced completion capabilities from blink.cmp
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- Define each server configuration
		vim.lsp.config.lua_ls = {
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					diagnostics = {
						globals = { "vim", "require" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
					},
					telemetry = { enable = false },
				},
			},
		}

		vim.lsp.config.pyright = {
			settings = {
				pyright = {
					python = {
						analysis = { typeCheckingMode = "basic" },
					},
				},
			},
		}

		vim.lsp.config.ruff_lsp = {
			on_attach = function(client, _)
				client.server_capabilities.hoverProvider = false
			end,
		}

		vim.lsp.config.clangd = {
			capabilities = capabilities,
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--completion-style=detailed",
				"--pch-storage=memory",
				"--cross-file-rename",
				"--header-insertion=iwyu",
			},
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr })
						end,
					})
				end
			end,
		}

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "lua", "python", "c", "cpp" },
			callback = function()
				local ft = vim.bo.filetype
				local config = vim.lsp.config[ft == "cpp" and "clangd" or ft .. "_ls"] or vim.lsp.config[ft]
				if config then
					vim.lsp.start(config)
				end
			end,
		})
		-- local capabilities = require("blink.cmp").get_lsp_capabilities()
		-- local lspconfig = require("lspconfig")
		--
		-- lspconfig.lua_ls.setup({
		-- 	capabilities = capabilities,
		-- 	settings = {
		-- 		Lua = {
		-- 			runtime = {
		-- 				version = "LuaJIT",
		-- 			},
		-- 			diagnostics = {
		-- 				-- Get the language server to recognize the `vim` global
		-- 				globals = {
		-- 					"vim",
		-- 					"require",
		-- 				},
		-- 			},
		-- 			workspace = {
		-- 				-- Make the server aware of Neovim runtime files
		-- 				library = vim.api.nvim_get_runtime_file("", true),
		-- 			},
		-- 			telemetry = {
		-- 				enable = false,
		-- 			},
		-- 		},
		-- 	},
		-- })
		--
		-- lspconfig.pyright.setup({
		-- 	settings = {
		-- 		pyright = {
		-- 			python = {
		-- 				analysis = { typeCheckingMode = "basic" },
		-- 			},
		-- 		},
		-- 	},
		-- })
		--
		-- lspconfig.ruff_lsp = {
		-- 	on_attach = function(client, _)
		-- 		-- Optional: turn off hover/docs from Ruff
		-- 		client.server_capabilities.hoverProvider = false
		-- 	end,
		-- }
		-- lspconfig.clangd.setup({
		-- 	capabilities = capabilities,
		-- 	on_attach = function(client, bufnr)
		-- 		if client.supports_method("textDocument/formatting") then
		-- 			vim.api.nvim_create_autocmd("BufWritePre", {
		-- 				buffer = bufnr,
		-- 				callback = function()
		-- 					vim.lsp.buf.format({ bufnr = bufnr })
		-- 				end,
		-- 			})
		-- 		end
		-- 	end,
		-- 	cmd = {
		-- 		"clangd",
		-- 		"--background-index",
		-- 		"--clang-tidy",
		-- 		"--completion-style=detailed",
		-- 		"--pch-storage=memory",
		-- 		"--cross-file-rename",
		-- 		"--header-insertion=iwyu",
		-- 	},
		-- })
	end,
}
