local lib = require("neotest.lib")

PositionsDiscoverer = {}

---Given a file path, parse all the tests within it.
---@async
---@param file_path string Absolute file path
---@return neotest.Tree | nil
function PositionsDiscoverer.discover_positions(file_path)
	local query = [[
                (function_definition
                        name: (word) @test.name
                        (#match? @test.name "^test_")
                ) @test.definition
        ]]

	return lib.treesitter.parse_positions(file_path, query)
end

return PositionsDiscoverer
