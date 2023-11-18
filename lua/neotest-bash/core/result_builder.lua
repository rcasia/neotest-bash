local ResultList = require("neotest-bash.util.result_list")

ResultBuilder = {}

---@async
---@param spec neotest.RunSpec
---@param result neotest.StrategyResult
---@param tree neotest.Tree
---@return table<string, neotest.Result>
function ResultBuilder.build_results(spec, result, tree)
	local results = ResultList:new()
	local is_file = string.match(spec.symbol, "_test.sh") ~= nil

	-- TODO: as bashunit does not provide reporting yet,
	-- we run tests running one command per test funtion
	-- so we do not expect to find files as spec.symbol
	if not is_file then
		for _, node in tree:iter_nodes() do
			local node_data = node:data()
			if node_data.name == spec.symbol then
				results:add_result_with_code(node_data, result.code)
			end
		end
	end

	return results:to_table()
end

return ResultBuilder
