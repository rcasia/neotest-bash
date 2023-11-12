local read_dot_env = require("neotest-bash.core.util.read_dot_env")

DirFilter = {}

---Filter directories when searching for test files
---@async
---@param name string Name of directory
---@param rel_path string Path to directory, relative to root
---@param root string Root directory of project
---@return boolean
function DirFilter.filter_dir(name, rel_path, root)
	-- read .env file
	local dot_env_properties = read_dot_env(root .. ".env")

	local test_dir = dot_env_properties["DEFAULT_PATH"]
	if test_dir == nil then
		return true -- allow all directories
	end

	if string.match(rel_path, test_dir) then
		return true -- allow specified directories
	end

	return false -- disallow all other directories
end

return DirFilter
