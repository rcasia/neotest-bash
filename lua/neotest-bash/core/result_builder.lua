local xml = require("neotest.lib.xml")
local scan = require("plenary.scandir")
local context_manager = require("plenary.context_manager")
local with = context_manager.with
local open = context_manager.open

ResultBuilder = {}

---@async
---@param spec neotest.RunSpec
---@param result neotest.StrategyResult
---@param tree neotest.Tree
---@return table<string, neotest.Result>
function ResultBuilder.build_results(spec, result, tree)
	return nil
end

return ResultBuilder
