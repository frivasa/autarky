return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} }, -- need this to check deps before loading anything else
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"saghen/blink.cmp",
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				local buf = event.buf
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				vim.api.nvim_set_option_value("updatetime", 300, {})

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

				-- for some reason obsidian-ls breaks with docHighlight but supports the method x.x
				-- this is a belt-and-suspenders function to avoid the obs plugin from constantly warning
				local function safe_document_highlight()
					local clients = vim.lsp.get_clients({ bufnr = buf })
					for _, c in pairs(clients) do
						if c.server_capabilities.documentHighlightProvider then
							vim.lsp.buf.document_highlight()
							return
						end
					end
				end

				if client and client.supports_method("textDocument_documentHighlight", buf) then
					local hl_group = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, { -- hl all refs when static
						buffer = buf,
						group = hl_group,
						callback = safe_document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, { -- clear hl on move
						buffer = buf,
						group = hl_group,
						callback = vim.lsp.buf.clear_references,
					})
					vim.api.nvim_create_autocmd("LspDetach", { -- clear hl on detatch
						group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
						callback = function(ev)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = ev.buf })
						end,
					})
				end
				if client and client.supports_method("textDocument_inlayHint", buf) then
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
				"rust_analyzer",
				-- "rustfmt", install with rustup component add rustfmt
				-- "clippy", install with rustup component add clippy
			},
		})
		-- Get enhanced completion capabilities from blink.cmp
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		-- Define each server configuration
		vim.lsp.config.rust_analyzer = {
			capabilities = capabilities,
			settings = {
				["rust-analyzer"] = {
					cargo = {
						allFeatures = true, -- enables all cargo features
						loadOutDirsFromCheck = true,
					},
					check = {
						command = "clippy", -- use clippy for linting
					},
					diagnostics = {
						enable = true,
						experimental = { enable = true },
					},
					procMacro = {
						enable = true, -- enable procedural macros
					},
					inlayHints = {
						enable = true,
						typeHints = true,
						parameterHints = true,
						chainingHints = true,
					},
					workspace = {
						symbol = { search = { kind = "all_symbols" } },
					},
				},
			},
		}

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

		local lsp_lookup = {
			lua = vim.lsp.config.lua_ls,
			python = vim.lsp.config.pyright,
			rust = vim.lsp.config.rust_analyzer,
		}
		vim.api.nvim_create_autocmd("FileType", {
			pattern = vim.tbl_keys(lsp_lookup),
			callback = function()
				local ft = vim.bo.filetype
				local config = lsp_lookup[ft]
				if config then
					vim.lsp.start(config)
				end
			end,
		})

		vim.api.nvim_create_user_command("CheckInlayHints", function()
			local buf = vim.api.nvim_get_current_buf()
			local clients = vim.lsp.get_clients({ bufnr = buf })

			if #clients == 0 then
				print("No LSP attached to this buffer")
				return
			end

			for _, client in ipairs(clients) do
				local inlay = vim.lsp.inlay_hint.is_enabled({ bufnr = buf })
				print(string.format("LSP: %s | Inlay hints: %s", client.name, inlay and "ENABLED" or "DISABLED"))
			end
		end, { desc = "Check if LSP and inlay hints are active for current buffer" })
	end,
}
