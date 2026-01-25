return {
	{
		"nvim-lspconfig",
		lazy = false,

		after = function()
			local lspconfig = require("lspconfig")

			-- Enable inlay hints when supported
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client and client.supports_method("textDocument/inlayHint") then
						vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
					end
				end,
			})

			-- Lua
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
						hint = { enable = true },
					},
				},
			})

			-- TypeScript / JavaScript
			lspconfig.ts_ls.setup({
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
						},
					},
				},
			})
			lspconfig.svelte.setup({
				settings = {
					svelte = {
						plugin = {
							typescript = {
								diagnostics = { enable = true },
								hover = { enable = true },
								completions = { enable = true },
							},
						},
					},
				},
			})

			-- Nix
			lspconfig.nixd.setup({
				settings = {
					nixd = {
						formatting = { command = { "nixfmt" } },
						options = {
							nixos = {
								expr = "(import <nixpkgs/nixos> { configuration = /etc/nixos/configuration.nix; })",
							},
							home_manager = {
								expr = "(import <home-manager/modules> { config = {}; pkgs = import <nixpkgs> {}; })",
							},
							nixpkgs = {
								expr = "(import <nixpkgs> {})",
							},
						},
					},
				},
			})

			-- Other servers
			for _, server in ipairs({
				"html",
				"cssls",
				"jsonls",
				"bashls",
				"jdtls",
				"qmlls",
				"pyright",
				"clangd",
			}) do
				lspconfig[server].setup({})
			end
		end,
	},

	{
		"none-ls.nvim",
		lazy = false,

		dependencies = {
			"nvim-lspconfig",
		},

		after = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				diagnostics_format = "[#{m}] #{s} (#{c})",
				debounce = 250,
				default_timeout = 5000,
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.code_actions.statix,
					null_ls.builtins.diagnostics.deadnix,
				},
			})

			-- Diagnostics UI (global, correct place)
			vim.diagnostic.config({
				update_in_insert = true,
				virtual_text = false,
				virtual_lines = { enable = true, current_line = true },
				underline = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.INFO] = "",
						[vim.diagnostic.severity.HINT] = "",
					},
				},
			})
		end,

		wk = {
			{ "<leader>l", group = "LSP" },
			{ "<leader>lg", group = "Goto" },
			{ "<leader>lw", group = "Workspace" },
		},

		keys = AddKeyOpts({
			{ "<leader>lgd", vim.lsp.buf.definition, desc = "Definition" },
			{ "<leader>lgD", vim.lsp.buf.declaration, desc = "Declaration" },
			{ "<leader>lgt", vim.lsp.buf.type_definition, desc = "Type definition" },
			{
				"<leader>lgn",
				function()
					vim.diagnostic.jump({ count = 1 })
				end,
				desc = "Next diagnostic",
			},
			{
				"<leader>lgp",
				function()
					vim.diagnostic.jump({ count = -1 })
				end,
				desc = "Prev diagnostic",
			},
			{ "<leader>lh", vim.lsp.buf.hover, desc = "Hover" },
			{ "<leader>ls", vim.lsp.buf.signature_help, desc = "Signature" },
			{ "<leader>ln", vim.lsp.buf.rename, desc = "Rename" },
			{
				"<leader>lf",
				function()
					vim.lsp.buf.format({ async = true })
				end,
				desc = "Format",
			},
		}, { silent = true }),
	},
}
