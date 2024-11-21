-- File: /plugins/markdown.lua

return {
	-- Obsidian.nvim plugin configuration
	{
		"epwalsh/obsidian.nvim",
		lazy = false,
		config = function()
			local obsidian = require("obsidian")

			-- Obsidian setup
			obsidian.setup({
				dir = "~/vaults", -- Set your Obsidian vault path
				use_current_dir = false, -- Allows using Obsidian commands outside the vault
				completion = { nvim_cmp = true },
				ui = { enable = true },
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
			local obsidian_keymaps = {
				{ key = "<leader>oo", cmd = ":ObsidianQuickSwitch<CR>", desc = "Obsidian Quick Switch" },
				{ key = "<leader>on", cmd = ":ObsidianNew<CR>", desc = "Create New Obsidian Note" },
				{ key = "<leader>os", cmd = ":ObsidianSearch<CR>", desc = "Search Obsidian Vault" },
				{ key = "<leader>od", cmd = ":ObsidianToday<CR>", desc = "Open Today's Note" },
				{ key = "<leader>oy", cmd = ":ObsidianYesterday<CR>", desc = "Open Yesterday's Note" },
			}

			for _, map in ipairs(obsidian_keymaps) do
				vim.keymap.set("n", map.key, map.cmd, { noremap = true, silent = true, desc = map.desc })
			end

			-- Keymap to open Obsidian vault in the default file explorer
			vim.keymap.set("n", "<leader>ob", function()
				-- For macOS
				vim.fn.jobstart({ "open", obsidian.config.dir }, { detach = true })
				-- For Linux:
				-- vim.fn.jobstart({ "xdg-open", obsidian.config.dir }, { detach = true })
			end, { noremap = true, silent = true, desc = "Open Obsidian Vault in File Explorer" })

			-- Keymap to follow link under cursor
			vim.keymap.set("n", "gf", function()
				if obsidian.util.cursor_on_markdown_link() then
					return obsidian.follow_link()
				else
					return "gf"
				end
			end, { noremap = false, expr = true, desc = "Follow link under cursor" })

			-- Markdown Formatting Keymaps Using Custom Plugin
			local formatter = require("custom.markdown_formatter")

			local formatting_keymaps = {
				{ key = "<leader>b", marker = "**", desc = "Toggle Bold" },
				{ key = "<leader>i", marker = "*", desc = "Toggle Italic" },
				{ key = "<leader>s", marker = "~~", desc = "Toggle Strikethrough" },
			}

			for _, map in ipairs(formatting_keymaps) do
				vim.keymap.set("v", map.key, function()
					formatter.toggle_format(map.marker)
				end, { noremap = true, silent = true, desc = map.desc })
			end
		end,
	},

	-- Plugin to enhance the appearance of Markdown headers and bullet points
	{
		"lukas-reineke/headlines.nvim",
		ft = "markdown",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			-- Define highlight groups for headlines and lists using your colors
			local highlights = {
				{ group = "Headline1", bg = "#DEAA79", fg = "#000000" },
				{ group = "Headline2", bg = "#FFE6A9", fg = "#000000" },
				{ group = "Headline3", bg = "#B1C29E", fg = "#000000" },
				{ group = "Headline4", bg = "#659287", fg = "#FFFFFF" },
				{ group = "Headline5", bg = "#DEAA79", fg = "#000000" },
				{ group = "Headline6", bg = "#FFE6A9", fg = "#000000" },
				{ group = "ListMarker", bg = "#659287", fg = "#FFFFFF" },
			}

			for _, hl in ipairs(highlights) do
				vim.api.nvim_set_hl(0, hl.group, { bg = hl.bg, fg = hl.fg })
			end

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

