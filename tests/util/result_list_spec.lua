---@diagnostic disable: undefined-global

local ResultList = require("neotest-bash.util.result_list")
local assertions = require("tests.assertions")

describe("result_list", function()
	it("keeps results isolated per instance", function()
		-- given
		local a = ResultList:new()
		local b = ResultList:new()

		-- when
		a:add_successful_result({ id = "a_only" })

		-- then
		assertions.equal(1, vim.tbl_count(a:to_table()))
		assertions.equal(0, vim.tbl_count(b:to_table()))
	end)

	it("maps exit codes to passed/failed statuses", function()
		-- given
		local list = ResultList:new()

		-- when
		list:add_result_with_code({ id = "t1" }, 0)
		list:add_result_with_code({ id = "t2" }, 1)

		-- then
		local results = list:to_table()
		assertions.equal("passed", results["t1"].status)
		assertions.equal("failed", results["t2"].status)
	end)
end)
