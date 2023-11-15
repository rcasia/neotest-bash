local root_finder = require("neotest-bash.core.root_finder")

SpecBuilder = {}
---@param args neotest.RunArgs
---@return nil | neotest.RunSpec | neotest.RunSpec[]
function SpecBuilder.build_spec(args)
	local tree_data = args.tree.data()
	local symbol = tree_data.name
	local root = root_finder.findRoot(tree_data.path)

	return {
		command = "./lib/bashunit /home/user/project/test.sh",
		cwd = root,
		symbol = symbol,
	}
end

return SpecBuilder
