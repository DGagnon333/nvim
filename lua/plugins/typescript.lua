-- File: /plugins/typescript.lua

return {
	{
		"jose-elias-alvarez/typescript.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("typescript").setup({
				disable_commands = false,
				debug = false,
				server = {
					name = "ts_ls",  -- Explicitly set the server name to 'ts_ls'
					capabilities = require("cmp_nvim_lsp").default_capabilities(),
					on_attach = function(client, bufnr)
						-- Keymaps specific to TypeScript files
						local opts = { noremap = true, silent = true, buffer = bufnr }

						-- Go to definition
						vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

						-- Hover
						vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

						-- Rename symbol
						vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

						-- Format document
						vim.keymap.set("n", "<leader>fm", function()
							vim.lsp.buf.format({ async = true })
						end, opts)

						-- Organize imports
						vim.keymap.set("n", "<leader>oi", "<cmd>TypescriptOrganizeImports<CR>", opts)

						-- Remove unused variables
						vim.keymap.set("n", "<leader>ru", "<cmd>TypescriptRemoveUnused<CR>", opts)

						-- Add missing imports
						vim.keymap.set("n", "<leader>ai", "<cmd>TypescriptAddMissingImports<CR>", opts)

						-- Fix all issues
						vim.keymap.set("n", "<leader>fa", "<cmd>TypescriptFixAll<CR>", opts)

						-- Go to source definition
						vim.keymap.set("n", "<leader>gs", "<cmd>TypescriptGoToSourceDefinition<CR>", opts)
					end,
					settings = {
						-- Add any tsserver-specific settings here
					},
				},
			})
		end,
	},
}

