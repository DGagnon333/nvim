-- File: ~/.dotfiles/nvim/lua/custom/quick_todo.lua

-- Path to your todo file
local todo_file = "~/todo.md" -- Change this to your preferred location

-- Function to open the todo file
local function open_todo()
	vim.cmd("e " .. todo_file)
end

-- Function to add a new todo
local function add_todo()
	local todo = vim.fn.input("New TODO: ")
	if todo ~= "" then
		local file = io.open(vim.fn.expand(todo_file), "a")
		file:write("- [ ] " .. todo .. "\n")
		file:close()
		print("TODO added: " .. todo)
	else
		print("No TODO added.")
	end
end

-- Function to toggle todo status
local function toggle_todo()
	local line = vim.fn.getline(".")
	if line:match("%- %[%s%]") then
		-- Mark as done
		line = line:gsub("%- %[%s%]", "- [x]")
		vim.fn.setline(".", line)
		print("TODO marked as done")
	elseif line:match("%- %[x%]") then
		-- Mark as not done
		line = line:gsub("%- %[x%]", "- [ ]")
		vim.fn.setline(".", line)
		print("TODO marked as not done")
	else
		print("No TODO item on current line")
	end
end

-- Keymaps
vim.keymap.set("n", "<leader>tt", open_todo, { noremap = true, silent = true, desc = "Open TODO file" })
vim.keymap.set("n", "<leader>ta", add_todo, { noremap = true, silent = true, desc = "Add new TODO" })
vim.keymap.set("n", "<leader>tx", toggle_todo, { noremap = true, silent = true, desc = "Toggle TODO status" })

-- Autocommand to set filetype for the todo file
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = vim.fn.expand(todo_file),
	callback = function()
		vim.bo.filetype = "markdown"
	end,
})

