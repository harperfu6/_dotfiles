local M = {}

local api = vim.api

local function open_todo_window()
	vim.cmd('30vs')
	local win = vim.api.nvim_get_current_win()
	local buf = vim.api.nvim_create_buf(true, true)
	vim.api.nvim_win_set_buf(win, buf)
end

function M.setup()
	api.nvim_create_user_command("OpenTODO", open_todo_window, {})
end

return M
