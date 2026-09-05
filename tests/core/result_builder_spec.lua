---@diagnostic disable: undefined-global

local plugin = require("neotest-bash")
local assertions = require("tests.assertions")
local async = require("nio").tests

local function read_tree_from_file(file_path)
	return plugin.discover_positions(file_path)
end

describe("result_builder", function()
	async.it("should build a result for the test node matching the spec symbol", function()
		-- given
		local tree = read_tree_from_file("tests/fixtures/example_test.sh")
		local result = {
			code = 0,
		}
		local spec = {
			symbol = "test_sum_1_plus_1",
		}

		-- when
		local results = plugin.results(spec, result, tree)

		-- then
		-- only the node whose name matches the symbol is reported, as passed
		assertions.equal(1, vim.tbl_count(results))
		for _, res in pairs(results) do
			assertions.equal("passed", res.status)
		end
	end)

	async.it("should report a failed result when the exit code is non-zero", function()
		-- given
		local tree = read_tree_from_file("tests/fixtures/example_test.sh")
		local result = {
			code = 1,
		}
		local spec = {
			symbol = "test_sum_2_plus_2",
		}

		-- when
		local results = plugin.results(spec, result, tree)

		-- then
		assertions.equal(1, vim.tbl_count(results))
		for _, res in pairs(results) do
			assertions.equal("failed", res.status)
		end
	end)

	async.it("should build no results when the symbol matches no node", function()
		-- given
		local tree = read_tree_from_file("tests/fixtures/example_test.sh")
		local result = {
			code = 0,
		}
		local spec = {
			symbol = "test_that_does_not_exist",
		}

		-- when
		local results = plugin.results(spec, result, tree)

		-- then
		assertions.equal(0, vim.tbl_count(results))
	end)
end)
