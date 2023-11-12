---@diagnostic disable: undefined-global

local plugin = require("neotest-bash")
local async = require("nio").tests

local root = vim.fn.fnamemodify("tests/fixtures/demo-project/", ":p")

describe("dir_filter", function()
	local allowed_dirs = {
		"tests/",
		"tests/core",
	}
	for _, dir in ipairs(allowed_dirs) do
		async.it("should allow with .env file => (DEFAULT_PATH=tests): " .. dir, function()
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
		async.it("should not allow with .env file => (DEFAULT_PATH=tests): " .. dir, function()
			local name = "name1" -- doesn't matter

			local is_allowed = plugin.filter_dir(name, dir, root)

			assert.is_false(is_allowed)
		end)
	end

	-- local all_dirs = table.insert(not_allowed_dirs, allowed_dirs)
	-- merge tables
	local all_dirs = { vim.tbl_extend("force", allowed_dirs, not_allowed_dirs) }
	for _, dir in ipairs(all_dirs) do
		async.it("should allow all directories when there is no .env file", function()
			-- create a temporary directory
			local tmp_dir = vim.fn.tempname()

			vim.fn.mkdir(tmp_dir, "p")

			local is_allowed = plugin.filter_dir("name1", dir, tmp_dir)

			--delete the temporary directory
			vim.fn.delete(tmp_dir, "rf")

			assert.is_true(is_allowed)
		end)
	end
end)
