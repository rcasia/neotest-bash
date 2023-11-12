local context_manager = require("plenary.context_manager")
local with = context_manager.with
local open = context_manager.open

-- @param path string
-- @return table<string, string>
local function read_dot_env(path)
	local lines = {}
	-- read file
	local function read_file(pathname)
		local _content = ""
		with(open(pathname, "r"), function(reader)
			_content = reader:read("*a")
		end)
		return _content
	end

	local success, content = pcall(read_file, path)
	if not success then
		return {}
	end

	-- convert to array of lines
	lines = vim.split(content, "\n")

	-- convert to table of key-value pairs
	local env_properties = {}
	for _, line in ipairs(lines) do
		local key, value = line:match("^([^=]+)=(.*)$")
		if key ~= nil and value ~= nil then
			env_properties[key] = value
		end
	end
	return env_properties
end

return read_dot_env
