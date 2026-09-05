local ResultList = require("neotest-bash.util.result_list")

ResultBuilder = {}

---@async
---@param spec neotest.RunSpec
---@param result neotest.StrategyResult
---@param tree neotest.Tree
---@return table<string, neotest.Result>
function ResultBuilder.build_results(spec, result, tree)
	local results = ResultList:new()

	for _, node in tree:iter_nodes() do
		local node_data = node:data()
		if node_data.name == spec.symbol then
			results:add_result_with_code(node_data, result.code)
		end
	end

	return results:to_table()
end

return ResultBuilder
