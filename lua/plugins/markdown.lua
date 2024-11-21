-- File: /plugins/markdown.lua

return {
	-- Obsidian.nvim plugin configuration
	{
		"epwalsh/obsidian.nvim",
		lazy = false,
		config = function()
			local obsidian = require("obsidian")
			obsidian.setup({
				dir = "~/vaults", -- Replace with your Obsidian vault path
				completion = {
					nvim_cmp = true, -- Enable completion with nvim-cmp
				},
				ui = {
					-- Enable additional UI features
					enable = true,
				},
				-- Configure how URLs are opened
				follow_url_func = function(url)
					-- For macOS
					vim.fn.jobstart({ "open", url }, { detach = true })

					-- For Linux (uncomment the following line and comment out the macOS line)
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

			-- Open Obsidian Quick Switcher
			vim.keymap.set("n", "<leader>oo", ":ObsidianQuickSwitch<CR>", opts)

			-- Create a new note
			vim.keymap.set("n", "<leader>on", ":ObsidianNew<CR>", opts)

			-- Open Obsidian Search
			vim.keymap.set("n", "<leader>os", ":ObsidianSearch<CR>", opts)

			-- Follow link under cursor
			vim.keymap.set("n", "gf", function()
				if obsidian.util.cursor_on_markdown_link() then
					return obsidian.follow_link()
				else
					return "gf"
				end
			end, { noremap = false, expr = true })

			-- Open Obsidian in the default browser
			vim.keymap.set("n", "<leader>ob", function()
				-- For macOS
				vim.fn.jobstart({ "open", obsidian.config.dir }, { detach = true })

				-- For Linux (uncomment the following line and comment out the macOS line)
				-- vim.fn.jobstart({ "xdg-open", obsidian.config.dir }, { detach = true })
			end, opts)

			-- Search in Obsidian vault
			vim.keymap.set("n", "<leader>og", ":ObsidianSearch<CR>", opts)

			-- Open today's daily note
			vim.keymap.set("n", "<leader>od", ":ObsidianToday<CR>", opts)

			-- Open yesterday's daily note
			vim.keymap.set("n", "<leader>oy", ":ObsidianYesterday<CR>", opts)
		end,
	},

	-- Plugin to enhance the appearance of Markdown headers and quotes
	{
		"lukas-reineke/headlines.nvim",
		ft = "markdown",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("headlines").setup()
		end,
	},

	-- Markdown Preview plugin for live previewing your Markdown files
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		ft = { "markdown" },
		config = function()
			vim.g.mkdp_auto_start = 1
		end,
	},

	-- Colorizer for highlighting color codes in Markdown
	{
		"norcalli/nvim-colorizer.lua",
		ft = { "markdown" },
		config = function()
			require("colorizer").setup({ "*" }, { mode = "foreground" })
		end,
	},
}

