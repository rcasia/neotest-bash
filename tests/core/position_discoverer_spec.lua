local plugin = require("neotest-bash")
local async = require("nio").tests

local current_dir = vim.fn.expand("%:p:h")

describe("PositionDiscoverer", function()
	async.it("discovers normal test", function()
		--given
		local expected_test_name = "test_sum_1_plus_1"
		local filename = current_dir .. "/tests/fixtures/example_test.sh"

		--when
		local tree = plugin.discover_positions(filename)

		--then
		-- local test_file_node = tree:to_list()[1]
		local test_function_node = tree:to_list()[2][1]
		local actual_test_name = test_function_node.name

		assert.are.equal(expected_test_name, actual_test_name)
	end)
end)
