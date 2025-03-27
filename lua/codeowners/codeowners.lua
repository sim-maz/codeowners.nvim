local M = {}

local codeownersFilePath = "./CODEOWNERS"
local codeownersFileEntries = {}
local loaded = false
local bufferOwnerCache = {}

local parseCodeownersFile = function()
	if vim.fn.filereadable(codeownersFilePath) == 0 then
		return
	end

	codeownersFileEntries = {}

	local content = vim.fn.readfile(codeownersFilePath)

	for _, line in pairs(content) do
		if line ~= "" and line:sub(1, 1) ~= "#" then
			local path, usernames = line:match("^(%S+)%s(.+)$")

			-- Prepend to list
			table.insert(codeownersFileEntries, 1, {
				path = path,
				usernames = usernames:gsub(".+/", ""),
			})
		end
	end
end

function M.reset()
	parseCodeownersFile()
	bufferOwnerCache = {}
end

function M.get_owner(fullpath)
	if bufferOwnerCache[fullpath] ~= nil then
		return bufferOwnerCache[fullpath]
	end

	if not loaded then
		parseCodeownersFile()
		loaded = true
	end

	if #codeownersFileEntries == 0 then
		return ""
	end

	local cwd = vim.loop.cwd()
	local path = fullpath:sub(#cwd + 1)

	for _, entry in pairs(codeownersFileEntries) do
		if path:match("^" .. entry.path) then
			bufferOwnerCache[fullpath] = entry.usernames
			return entry.usernames
		end
	end

	return ""
end

return M
