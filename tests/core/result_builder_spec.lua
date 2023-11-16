---@diagnostic disable: undefined-global

local plugin = require("neotest-bash")
local async = require("nio").tests

local function read_tree_from_file(file_path)
	return plugin.discover_positions(file_path)
end

describe("result_builder", function()
	async.it("should build results for successful tests", function()
		-- given
		local tree = read_tree_from_file("tests/fixtures/example_test.sh")
		local result = {
			code = 0,
		}

		-- when
		local results = plugin.results(spec, result, tree)

		-- then
		-- assert all tests passed by checking result table
		for _, res in pairs(results) do
			assert.are.equal("passed", res.status)
		end
	end)

	async.it("should build results for failed tests", function()
		-- given
		local tree = read_tree_from_file("tests/fixtures/example_test.sh")
		local result = {
			code = 1,
		}

		-- when
		local results = plugin.results(spec, result, tree)

		-- then
		-- assert all tests failed by checking result table
		for _, res in pairs(results) do
			assert.are.equal("failed", res.status)
		end
	end)
end)
