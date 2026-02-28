local CommandBuilder = {
	_executable = "",
	_path = "",
	_filter = "",
	_args = {},

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

	---@param args string[] @additional CLI arguments
	args = function(self, args)
		self._args = args
		return self
	end,

	--- @return string @command to run
	build = function(self)
		local cmd = self._executable .. " " .. self._path
		if self._filter ~= "" then
			cmd = cmd .. " --filter " .. self._filter
		end
		if self._args and #self._args > 0 then
			cmd = cmd .. " " .. table.concat(self._args, " ")
		end
		return cmd
	end,
}

return CommandBuilder
