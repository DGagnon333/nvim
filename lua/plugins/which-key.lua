-- File: /plugins/whichkey.lua

return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500 -- Adjust this value if needed

		require("which-key").setup({
			plugins = {
				marks = true, -- shows a list of your marks on ' and `
				registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
				spelling = {
					enabled = true, -- shows WhichKey when pressing z= to select spelling suggestions
					suggestions = 20, -- how many suggestions should be shown in the list?
				},
				presets = {
					operators = false, -- adds help for operators like d, y, ...
					motions = false, -- adds help for motions
					text_objects = false, -- help for text objects after entering an operator
					windows = true, -- default bindings on <c-w>
					nav = true, -- misc bindings to work with windows
					z = true,   -- bindings for folds, spelling, and others prefixed with z
					g = true,   -- bindings prefixed with g
				},
			},
			replace = {
				-- override the label used to display some keys. It doesn't affect WhichKey in any other way.
				-- For example:
				-- ["<space>"] = "SPC",
				-- ["<cr>"] = "RET",
				-- ["<tab>"] = "TAB",
			},
			icons = {
				breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
				separator = "➜", -- symbol used between a key and its label
				group = "+", -- symbol prepended to a group
			},
			layout = {
				height = { min = 4, max = 25 }, -- min and max height of the columns
				width = { min = 20, max = 50 }, -- min and max width of the columns
				spacing = 3,            -- spacing between columns
				align = "left",         -- align columns left, center, or right
			},
			filters = {
				boilerplate = false,
			},
			show_help = true, -- show help message on the command line when the popup is visible
		})
	end,
}
