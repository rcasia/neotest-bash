local lib = require("neotest.lib")

PositionsDiscoverer = {}

---Given a file path, parse all the tests within it.
---@async
---@param file_path string Absolute file path
---@return neotest.Tree | nil
function PositionsDiscoverer:discover_positions(file_path)
	local query = [[]]

	return lib.treesitter.parse_positions(file_path, query)
end

return PositionsDiscoverer
