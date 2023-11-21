local Codeowners = require("codeowners.codeowners")

local M = {}

function M.reset()
	Codeowners.reset()
end

function M.get_owner(fullpath)
	return Codeowners.get_owner(fullpath)
end

function M.get_buf_owner()
	local fullpath = vim.fn.expand("%:p")
	return M.get_owner(fullpath)
end

function M.setup()
	vim.api.nvim_create_user_command("CodeownersReset", function()
		M.reset()
		vim.notify("Codeowners cache cleared", vim.log.levels.INFO)
	end, {})
end

return M
