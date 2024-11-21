-- File: ~/.dotfiles/nvim/lua/custom/markdown_formatter.lua

local M = {}

-- Helper function to escape Lua pattern special characters
local function escape_lua_pattern(s)
	return s:gsub("%%", "%%%%"):gsub("[%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%0")
end

-- Helper function to check if the text is already wrapped with the marker
local function is_wrapped(text, marker)
	local escaped_marker = escape_lua_pattern(marker)
	local pattern = "^" .. escaped_marker .. "(.-)" .. escaped_marker .. "$"
	return text:match(pattern)
end

-- Function to toggle formatting
function M.toggle_format(marker)
	local mode = vim.fn.mode()
	if mode ~= 'v' and mode ~= 'V' then
		print('Please select text in visual mode')
		return
	end

	local bufnr = 0
	local s_start = vim.api.nvim_buf_get_mark(bufnr, '<')
	local s_end = vim.api.nvim_buf_get_mark(bufnr, '>')

	local start_row = s_start[1] - 1
	local start_col = s_start[2]
	local end_row = s_end[1] - 1
	local end_col = s_end[2] + 1 -- make end_col exclusive

	-- Get the selected text
	local lines = vim.api.nvim_buf_get_text(bufnr, start_row, start_col, end_row, end_col, {})

	-- Combine lines into a single text
	local text = table.concat(lines, '\n')

	-- Check if text is already wrapped
	if is_wrapped(text, marker) then
		-- Remove formatting
		text = text:sub(#marker + 1, -(#marker + 1))
	else
		-- Add formatting
		text = marker .. text .. marker
	end

	-- Split text back into lines
	local new_lines = vim.split(text, '\n', true) -- 'true' to include empty lines

	-- Replace the text in buffer
	vim.api.nvim_buf_set_text(bufnr, start_row, start_col, end_row, end_col, new_lines)
end

return M

