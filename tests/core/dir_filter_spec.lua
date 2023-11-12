---@diagnostic disable: undefined-global

local plugin = require("neotest-bash")
local async = require("nio").tests

local root = vim.fn.fnamemodify("tests/fixtures/demo-project/", ":p")

local function create_temporary_dir()
	-- create a temporary directory
	local tmp_dir = "/tmp/neotest-bash/tests/"
	os.execute("mkdir -p " .. tmp_dir)
	return tmp_dir
end

local function remove_dir()
	-- delete the temporary directory
	os.execute("rm -rf /tmp/neotest-bash/tests/")
end

--- @param dir string
--- @param env table
local function create_env_file(dir, env)
	local env_file = dir .. ".env"
	os.execute("touch " .. env_file)
	for k, v in pairs(env) do
		os.execute("echo " .. k .. "=" .. v .. " >> " .. env_file)
	end
end

describe("dir_filter", function()
	after_each(function()
		remove_dir()
	end)

	local allowed_dirs = {
		"tests/",
		"tests/core/",
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
	local all_dirs = vim.tbl_extend("force", allowed_dirs, not_allowed_dirs)
	for _, dir in ipairs(all_dirs) do
		async.it("should allow all directories when there is no .env file: " .. dir, function()
			-- create a temporary directory
			local tmp_root = create_temporary_dir()

			local is_allowed = plugin.filter_dir("name1", dir, tmp_root)

			assert.is_true(is_allowed)
		end)
	end

	local dirs = {
		["tests/core/"] = true,
		["tests/core/deeper/"] = false,
	}
	for dir, expected in pairs(dirs) do
		async.it("should allow only one directory when DEFAULT_PATH is a test file: " .. dir, function()
			local name = "name1" -- doesn't matter
			-- create a temporary directory
			local tmp_root = create_temporary_dir()
			create_env_file(tmp_root, { ["DEFAULT_PATH"] = "tests/core/logic_test.sh" })

			local is_allowed = plugin.filter_dir(name, dir, tmp_root)

			assert.is_equal(expected, is_allowed)
		end)
	end

  it("playing around", function()
	  print(string.find("core/tests/", "core") ~= nil)
  end)
end)
