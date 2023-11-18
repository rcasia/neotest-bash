local root_finder = require("neotest-bash.core.root_finder")
local CommandBuilder = require("neotest-bash.util.command_builder")

SpecBuilder = {
	---@param args neotest.RunArgs
	---@return nil | neotest.RunSpec | neotest.RunSpec[]
	build_spec = function(args)
		local tree = args.tree
		local tree_data = tree:data()
		local path = tree_data.path
		local root = root_finder.findRoot(tree_data.path)

		local commands = {}
		for _, node in tree:iter_nodes() do
			local node_data = node:data()
			if node_data.type == "test" then
				local command = CommandBuilder:new()
				local symbol = node_data.name

				command:filter(symbol)
				command:executable("./lib/bashunit")
				command:path(path)

				-- add command to list of commands
				commands[#commands + 1] = {
					command = command:build(),
					cwd = root,
					symbol = symbol,
				}
			end
		end

		return commands
	end,
}

return SpecBuilder
