return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	event = "VeryLazy",
	dependencies = {
		'nvim-treesitter/nvim-treesitter-textobjects',
	},
	opts = {
		ensure_installed = {
			"markdown",
			"markdown_inline",
			"typescript",
			"c_sharp",
			"python"
		},
		auto_install = true,
		sync_install = false,
		highlight = {
			enable = true,
			indent = { enable = true },
			-- additional_vim_regex_highlighting = false
		},
		textobjects = {
			move = {
				ehnable = true,
				set_jumps = true,
				goto_next_start = {
					["]m"] = "@function.outer",
					["]c"] = "@class.outer",
				},
				-- goto next end
				goto_next_end = {
					["]M"] = "@function.outer",
					["]C"] = "@class.outer",
				},
			},
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["am"] = "@function.outer",
					["im"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
					["ib"] = "@block.inner",
					["ab"] = "@block.outer",
					["iP"] = "@parameter.inner",
					["aP"] = "@parameter.outer",
				}
			}
		}
	},
	config = function(_, opts)
		local config = require('nvim-treesitter.configs')
		config.setup(opts)
	end
}
