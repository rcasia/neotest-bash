local read_dot_env = require("neotest-bash.core.util.read_dot_env")

DirFilter = {}

local function is_file(path)
	-- check if it's a file with regex
	-- example: .../some_test.sh
	-- should end with _test.sh
	return string.match(path, "_test.sh$")
end

---Filter directories when searching for test files
---@async
---@param name string Name of directory
---@param rel_path string Path to directory, relative to root
---@param root string Root directory of project
---@return boolean
function DirFilter.filter_dir(name, rel_path, root)
	-- read .env file
	local dot_env_properties = read_dot_env(root .. ".env")

	local test_path = dot_env_properties["DEFAULT_PATH"]
	if test_path == nil then
		return true -- allow all directories
	end

	if is_file(test_path) then
		-- get rid of the file name
		-- example: tests/some_test.sh -> tests/
		local test_dir = string.match(test_path, "^(.*/)")
		return test_dir == rel_path -- allow only the directory of the file
	end

	if string.find(rel_path, test_path) ~= nil then
		return true -- allow specified directories
	end

	return false -- disallow all other directories
end

return DirFilter
