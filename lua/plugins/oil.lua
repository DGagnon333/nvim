return {
	'stevearc/oil.nvim',
	keys = {
		{ '-', "<CMD>Oil<CR>", { desc = "Open Oil file manager" } }
	},
	opts = {
		default_file_explorer = false,
		keymaps = {
			["q"] = "actions.close",
		},
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
