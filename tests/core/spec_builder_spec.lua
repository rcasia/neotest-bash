---@diagnostic disable: undefined-global
local async = require("nio").tests

local plugin = require("neotest-bash")
local root_finder = require("neotest-bash.core.root_finder")

--- mock root finder
local function mock_root_finder(mocked_root)
	root_finder.findRoot = function()
		return mocked_root
	end
end

local function mock_args_tree(data)
	return {
		tree = {
			data = function()
				return data
			end,
		},
		extra_args = {},
	}
end

describe("spec_builder", function()
	pending("should run command for a test file", function()
		-- given
		local args = mock_args_tree({
			name = "test.sh",
			path = "/home/user/project/test.sh",
			type = "file",
		})

		local mocked_root = "/home/user/mocked/directory/"
		mock_root_finder(mocked_root)

		-- when
		local result = plugin.build_spec(args)

		-- then
		local expected_spec = {
			command = "./lib/bashunit /home/user/project/test.sh",
			cwd = mocked_root,
			symbol = "test.sh",
		}

		assert.are.same(expected_spec, result)
	end)

	pending("should run command for a test function inside a test file", function()
		-- given
		local args = mock_args_tree({
			name = "test_it_works",
			path = "/home/user/project/test.sh",
			type = "test",
		})

		local mocked_root = "/home/user/mocked/directory/"
		mock_root_finder(mocked_root)

		-- when
		local result = plugin.build_spec(args)

		-- then
		local expected_spec = {
			command = "./lib/bashunit /home/user/project/test.sh --filter test_it_works",
			cwd = mocked_root,
			symbol = "test_it_works",
		}

		assert.are.same(expected_spec, result)
	end)

	async.it("should run a list of commands from a tree node selection", function()
		-- given
		--
		local path = "tests/fixtures/example_test.sh"
		local tree = plugin.discover_positions(path)
		local args = { tree = tree }
		local mocked_root = "/home/user/mocked/directory/"
		mock_root_finder(mocked_root)

		-- when
		local result = plugin.build_spec(args)

		-- then
		local expected_spec = {
			{
				command = "./lib/bashunit tests/fixtures/example_test.sh --filter test_sum_1_plus_1",
				cwd = mocked_root,
				symbol = "test_sum_1_plus_1",
			},
			{
				command = "./lib/bashunit tests/fixtures/example_test.sh --filter test_sum_2_plus_2",
				cwd = mocked_root,
				symbol = "test_sum_2_plus_2",
			},
		}

		assert.are.same(expected_spec, result)
	end)
end)
