---@diagnostic disable: undefined-global

local plugin = require("neotest-bash")

describe("dir_filter", function()
	it("should not filter dirs", function()
		local name = "tests"
		local rel_path = "tests"
		local root = root
		local result = plugin.filter_dir(name, rel_path, root)

		assert.is_true(result)
	end)
end)
