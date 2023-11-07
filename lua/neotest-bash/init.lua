local FileChecker = require("neotest-bash.core.file_checker")
local RootFinder = require("neotest-bash.core.root_finder")
local DirFilter = require("neotest-bash.core.dir_filter")
local PositionsDiscoverer = require("neotest-bash.core.positions_discoverer")
local SpecBuilder = require("neotest-bash.core.spec_builder")
local ResultBuilder = require("neotest-bash.core.result_builder")

---@class neotest.Adapter
---@field name string
NeotestBashAdapter = { name = "neotest-bash" }

---Find the project root directory given a current directory to work from.
---Should no root be found, the adapter can still be used in a non-project context if a test file matches.
---@async
---@param dir string @Directory to treat as cwd
---@return string | nil @Absolute root dir of test suite
function NeotestBashAdapter.root(dir)
	return RootFinder.findRoot(dir)
end

---Filter directories when searching for test files
---@async
---@param name string Name of directory
---@param rel_path string Path to directory, relative to root
---@param root string Root directory of project
---@return boolean
function NeotestBashAdapter.filter_dir(name, rel_path, root)
	return DirFilter.filter_dir(name, rel_path, root)
end

---@async
---@param file_path string
---@return boolean
function NeotestBashAdapter.is_test_file(file_path)
	return FileChecker.isTestFile(file_path)
end

---Given a file path, parse all the tests within it.
---@async
---@param file_path string Absolute file path
---@return neotest.Tree | nil
function NeotestBashAdapter.discover_positions(file_path)
	return PositionsDiscoverer.discover_positions(file_path)
end

---@param args neotest.RunArgs
---@return nil | neotest.RunSpec | neotest.RunSpec[]
function NeotestBashAdapter.build_spec(args)
	return SpecBuilder.build_spec(args)
end

---@async
---@param spec neotest.RunSpec
---@param result neotest.StrategyResult
---@param tree neotest.Tree
---@return table<string, neotest.Result>
function NeotestBashAdapter.results(spec, result, tree)
	return ResultBuilder.build_results(spec, result, tree)
end

return NeotestBashAdapter
