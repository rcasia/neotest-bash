local xml = require("neotest.lib.xml")
local scan = require("plenary.scandir")
local context_manager = require("plenary.context_manager")
local with = context_manager.with
local open = context_manager.open
local position_discoverer = require("neotest-bash.core.positions_discoverer")

ResultBuilder = {}

local Results = {
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

	to_table = function(self)
		return self._results
	end,
}

---@async
---@param spec neotest.RunSpec
---@param result neotest.StrategyResult
---@param tree neotest.Tree
---@return table<string, neotest.Result>
function ResultBuilder.build_results(spec, result, tree)
	local results = Results:new()

	for _, node in tree:iter_nodes() do
		local node_data = node:data()

		-- when the exit code is 0, the test passed
		if result.code == 0 then
			results:add_successful_result(node_data)
		else
			results:add_failed_result(node_data)
		end
	end

	return results:to_table()
end

return ResultBuilder
