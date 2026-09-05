---@diagnostic disable: undefined-global

local plugin = require("neotest-bash")
local assertions = require("tests.assertions")

describe("dir_filter", function()
	it("should not filter dirs", function()
		local name = "tests"
		local rel_path = "tests"
		local root = root
		local result = plugin.filter_dir(name, rel_path, root)

		assertions.is_true(result)
	end)
end)
