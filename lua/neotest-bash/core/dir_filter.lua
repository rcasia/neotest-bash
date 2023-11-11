local context_manager = require("plenary.context_manager")
local with = context_manager.with
local open = context_manager.open

DirFilter = {}

-- @param path string
-- @return table<string, string>
local function read_env_file(path)
	local lines = {}
	with(open(path, "r"), function(reader)
		lines = reader:read("*a")
	end)

	lines = vim.split(lines, "\n")
	local env_properties = {}
	for _, line in ipairs(lines) do
		local key, value = line:match("^([^=]+)=(.*)$")
		if key ~= nil and value ~= nil then
			env_properties[key] = value
		end
	end
	return env_properties
end

---Filter directories when searching for test files
---@async
---@param name string Name of directory
---@param rel_path string Path to directory, relative to root
---@param root string Root directory of project
---@return boolean
function DirFilter.filter_dir(name, rel_path, root)
	-- read .env file
	local dot_env_properties = read_env_file(root .. ".env")

	local test_dir = dot_env_properties["DEFAULT_PATH"]

	if string.match(rel_path, test_dir) then
		return true
	end

	return false
end

return DirFilter
