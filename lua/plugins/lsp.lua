return {
	{
		"williamboman/mason.nvim",
		lazy = true,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = true,
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = {
			automatic_installation = true, -- Automatically install language servers
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"omnisharp",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			-- Removed "jose-elias-alvarez/typescript.nvim" as it's configured separately
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			-- Lua language server setup
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			-- Omnisharp (C#) setup
			lspconfig.omnisharp.setup({
				capabilities = capabilities,
				enable_roslyn_analyzers = true,
				enable_import_completion = true,
				organize_imports_on_format = true,
				enable_decompilation_support = true,
				filetypes = { "cs", "vb", "csproj", "sln", "slnx", "props", "csx", "targets" },
			})

			-- Add other LSP server configurations as needed

			-- General LSP keymaps
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
		end,
	},
	-- Moved TypeScript configuration to typescript.lua
}

