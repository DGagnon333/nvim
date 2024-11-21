-- File: /plugins/markdown.lua

return {
	-- Obsidian.nvim plugin configuration
	{
		"epwalsh/obsidian.nvim",
		lazy = false,
		config = function()
			local obsidian = require("obsidian")
			obsidian.setup({
				dir = "~/vaults", -- Set your Obsidian vault path
				use_current_dir = false, -- Allows using Obsidian commands outside the vault
				completion = {
					nvim_cmp = true, -- Enable completion with nvim-cmp
				},
				ui = {
					enable = true,
				},
				follow_url_func = function(url)
					-- For macOS
					vim.fn.jobstart({ "open", url }, { detach = true })
					-- For Linux:
					-- vim.fn.jobstart({ "xdg-open", url }, { detach = true })
				end,
			})

			-- Set 'conceallevel' to 2 for Markdown files
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function()
					vim.opt.conceallevel = 2
				end,
			})

			-- Keymaps for Obsidian commands
			local opts = { noremap = true, silent = true }

			vim.keymap.set("n", "<leader>oo", ":ObsidianQuickSwitch<CR>", opts)
			vim.keymap.set("n", "<leader>on", ":ObsidianNew<CR>", opts)
			vim.keymap.set("n", "<leader>os", ":ObsidianSearch<CR>", opts)
			vim.keymap.set("n", "<leader>od", ":ObsidianToday<CR>", opts)
			vim.keymap.set("n", "<leader>oy", ":ObsidianYesterday<CR>", opts)
			vim.keymap.set("n", "<leader>ob", function()
				vim.fn.jobstart({ "open", obsidian.config.dir }, { detach = true })
				-- For Linux:
				-- vim.fn.jobstart({ "xdg-open", obsidian.config.dir }, { detach = true })
			end, opts)
			vim.keymap.set("n", "gf", function()
				if obsidian.util.cursor_on_markdown_link() then
					return obsidian.follow_link()
				else
					return "gf"
				end
			end, { noremap = false, expr = true })

			-- **Markdown Formatting Keymaps Using Custom Plugin**

			-- Require the custom formatter module
			local formatter = require("custom.markdown_formatter")

			-- Keymap to toggle bold formatting
			vim.keymap.set('v', '<leader>b', function()
				formatter.toggle_format('**')
			end, { noremap = true, silent = true, desc = 'Toggle Bold' })

			-- Keymap to toggle italic formatting
			vim.keymap.set('v', '<leader>i', function()
				formatter.toggle_format('*')
			end, { noremap = true, silent = true, desc = 'Toggle Italic' })

			-- Keymap to toggle strikethrough formatting
			vim.keymap.set('v', '<leader>s', function()
				formatter.toggle_format('~~')
			end, { noremap = true, silent = true, desc = 'Toggle Strikethrough' })
		end,
	},

	-- Plugin to enhance the appearance of Markdown headers and bullet points
	{
		"lukas-reineke/headlines.nvim",
		ft = "markdown",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			-- Define highlight groups for headlines and lists using your colors
			vim.api.nvim_set_hl(0, "Headline1", { bg = "#DEAA79", fg = "#000000" })
			vim.api.nvim_set_hl(0, "Headline2", { bg = "#FFE6A9", fg = "#000000" })
			vim.api.nvim_set_hl(0, "Headline3", { bg = "#B1C29E", fg = "#000000" })
			vim.api.nvim_set_hl(0, "Headline4", { bg = "#659287", fg = "#FFFFFF" })
			vim.api.nvim_set_hl(0, "Headline5", { bg = "#DEAA79", fg = "#000000" })
			vim.api.nvim_set_hl(0, "Headline6", { bg = "#FFE6A9", fg = "#000000" })
			vim.api.nvim_set_hl(0, "ListMarker", { bg = "#659287", fg = "#FFFFFF" })

			require("headlines").setup({
				markdown = {
					headline_highlights = {
						"Headline1",
						"Headline2",
						"Headline3",
						"Headline4",
						"Headline5",
						"Headline6",
					},
					list_highlight = "ListMarker",
				},
			})
		end,
	},

	-- Other plugin configurations...
}

