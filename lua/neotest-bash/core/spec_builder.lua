local root_finder = require("neotest-bash.core.root_finder")
local CommandBuilder = require("neotest-bash.util.command_builder")

SpecBuilder = {
	---@param args neotest.RunArgs
	---@return nil | neotest.RunSpec | neotest.RunSpec[]
	build_spec = function(args)
		local tree_data = args.tree.data()
		local symbol = tree_data.name
		local type = tree_data.type
		local path = tree_data.path
		local root = root_finder.findRoot(tree_data.path)

		local command = CommandBuilder:new()

		if type == "test" then
			command:filter(symbol)
		end

		command:executable("./lib/bashunit")
		command:path(path)

		return {
			command = command:build(),
			cwd = root,
			symbol = symbol,
		}
	end,
}

return SpecBuilder
