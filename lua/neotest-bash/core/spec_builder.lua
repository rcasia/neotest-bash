local root_finder = require("neotest-bash.core.root_finder")
local bashunit_finder = require("neotest-bash.util.bashunit_finder")
local CommandBuilder = require("neotest-bash.util.command_builder")

SpecBuilder = {
	---@param args neotest.RunArgs
	---@param config? neotest-bash.AdapterConfig|nil
	---@return nil | neotest.RunSpec | neotest.RunSpec[]
	build_spec = function(args, config)
		local tree = args.tree
		local tree_data = tree:data()
		local path = tree_data.path
		local root = root_finder.findRoot(tree_data.path)
		local bashunit_path = bashunit_finder.findBashunit(root, config)

		if not bashunit_path then
			error("bashunit not found")
		end

		local commands = {}
		for _, node in tree:iter_nodes() do
			local node_data = node:data()
			if node_data.type == "test" then
				local command = CommandBuilder:new()
				local symbol = node_data.name

				command:filter(symbol)
				command:executable(bashunit_path)
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
