local CommandBuilder = {
	_executable = "",
	_path = "",
	_filter = "",

	--- @return CommandBuilder
	new = function(self)
		local o = o or {}
		setmetatable(o, self)
		self.__index = self
		return o
	end,

	--- @param executable string @executable bashunit executable binary
	executable = function(self, executable)
		self._executable = executable
		return self
	end,

	--- @param path string @path to test file
	path = function(self, path)
		self._path = path
		return self
	end,

	---@param filter string @filter by test name
	filter = function(self, filter)
		self._filter = filter
		return self
	end,

	--- @return string @command to run
	build = function(self)
		if self._filter == "" then
			return self._executable .. " " .. self._path
		end
		return self._executable .. " " .. self._path .. " --filter " .. self._filter
	end,
}

return CommandBuilder
