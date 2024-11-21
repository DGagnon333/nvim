-- File: ~/.dotfiles/nvim/lua/custom/markdown_formatter.lua

local M = {}

-- Helper function to check if the text is already wrapped with the marker
local function is_wrapped(text, marker)
	local escaped_marker = marker:gsub("%p", "%%%1")
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

	-- Get the start and end positions of the selection
	local s_start = vim.api.nvim_buf_get_mark(0, '<')
	local s_end = vim.api.nvim_buf_get_mark(0, '>')

	-- Adjust indices for Lua (1-based indexing)
	local line_start = s_start[1]
	local col_start = s_start[2] + 1
	local line_end = s_end[1]
	local col_end = s_end[2] + 1

	-- Get the lines in the selection
	local lines = vim.api.nvim_buf_get_lines(0, line_start - 1, line_end, false)

	-- Handle single-line and multi-line selections
	if #lines == 1 then
		local text = lines[1]:sub(col_start, col_end)
		if is_wrapped(text, marker) then
			-- Remove formatting
			text = text:sub(#marker + 1, -(#marker + 1))
		else
			-- Add formatting
			text = marker .. text .. marker
		end
		lines[1] = lines[1]:sub(1, col_start - 1) .. text .. lines[1]:sub(col_end + 1)
	else
		-- Multi-line selection
		-- Get selected text from first and last lines
		local first_line = lines[1]
		local last_line = lines[#lines]

		local first_text = first_line:sub(col_start)
		local last_text = last_line:sub(1, col_end)

		-- Combine the selected text
		lines[1] = first_text
		lines[#lines] = last_text

		local text = table.concat(lines, '\n')

		if is_wrapped(text, marker) then
			-- Remove formatting
			text = text:sub(#marker + 1, -(#marker + 1))
		else
			-- Add formatting
			text = marker .. text .. marker
		end

		-- Split the text back into lines
		local new_lines = {}
		for line in text:gmatch("([^\n]*)\n?") do
			table.insert(new_lines, line)
		end

		-- Replace the lines in the buffer
		vim.api.nvim_buf_set_lines(0, line_start - 1, line_end, false, new_lines)
		return
	end

	-- Replace the lines in the buffer
	vim.api.nvim_buf_set_lines(0, line_start - 1, line_end, false, lines)
end

return M

