ExitCode = {
	Success = 0,
}

local ResultList = {
	-- TODO: needs to be static until bashunit provides reporting
	_results = {},

	new = function(self)
		self.__index = self
		return setmetatable({}, self)
	end,

	add_successful_result = function(self, result)
		self._results[result.id] = {
			status = "passed",
		}
	end,

	add_failed_result = function(self, result)
		self._results[result.id] = {
			status = "failed",
		}
	end,

	add_skipped_result = function(self, result)
		self._results[result.id] = {
			status = "skipped",
		}
	end,

	add_result_with_code = function(self, result, code)
		if code == ExitCode.Success then
			self:add_successful_result(result)
		else
			self:add_failed_result(result)
		end
	end,

	-- @returns boolean whether all results passed
	are_all_passed = function(self)
		for id, v in pairs(self._results) do
			if v.status ~= "passed" then
				return false
			end
		end
		return true
	end,

	--- @returns table<string, neotest.Result> copy of results
	to_table = function(self)
		-- makes a copy
		local results = {}
		for id, v in pairs(self._results) do
			results[id] = v
		end

		return results
	end,
}

return ResultList
