---@diagnostic disable: undefined-global

local plugin = require("neotest-bash")
local async = require("nio").tests

local current_dir = vim.fn.expand("%:p:h")
local root = vim.fn.fnamemodify("tests/fixtures/demo-project/", ":p")

describe("dir_filter", function()
	local allowed_dirs = {
		"tests/",
		"tests/core",
	}
	for _, dir in ipairs(allowed_dirs) do
		async.it("should allow: " .. dir, function()
			local name = "name1" -- doesn't matter
			local is_allowed = plugin.filter_dir(name, dir, root)

			assert.is_true(is_allowed)
		end)
	end

	local not_allowed_dirs = {
		"scr/",
		"build/",
	}
	for _, dir in ipairs(not_allowed_dirs) do
		async.it("should not allow: " .. dir, function()
			local name = "name1" -- doesn't matter

			local is_allowed = plugin.filter_dir(name, dir, root)

			assert.is_false(is_allowed)
		end)
	end
end)
