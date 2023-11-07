local plugin = require("neotest-bash")
local async = require("nio").tests

local current_dir = vim.fn.expand("%:p:h")

describe("PositionDiscoverer", function()
	async.it("discovers test with prefix 'test_' ", function()
		--given
		local filename = current_dir .. "/tests/fixtures/example_test.sh"

		--when
		local tree = plugin.discover_positions(filename)

		--then
		-- local test_file_node = tree:to_list()[1]
		local test_function_node = tree:to_list()[2][1]
		local actual_test_name = test_function_node.name

		assert.are.equal("test_sum_1_plus_1", actual_test_name)

		-- there is only one test function
		assert.are.equal(1, #tree:children())
	end)

	async.it("ignores functions that are not tests", function()
		--given
		local filename = current_dir .. "/tests/fixtures/no_test_functions_here_test.sh"

		--when
		local tree = plugin.discover_positions(filename)

		--then
		local children = tree:children()

		assert.are.equal(0, #children)
	end)
end)
