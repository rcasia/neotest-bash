BashunitFinder = {
	---@param root? string|nil
	---@param config? neotest-bash.AdapterConfig|nil
	---@return string|nil
	findBashunit = function(root, config)
		local config_path = config and config.executable
		if config_path then
			config_path = vim.fs.normalize(config_path)

			-- if config path is a relative path, join it with the root or the current working directory
			if config_path:match("^[^/\\:][%w%._%-%/\\]*$") then
				config_path = vim.fs.joinpath(root or vim.fn.getcwd(), config_path)
			end
		end

		local bashunit_paths = {
			config_path,
			vim.fs.joinpath(root or vim.fn.getcwd(), "lib/bashunit"),
			vim.fn.exepath("bashunit"),
		}

		local logger = require("neotest.logging")
		logger.debug("[neotest-bash] Looking for bashunit...")
		for _, p in ipairs(bashunit_paths) do
			if p then
				logger.debug(string.format("[neotest-bash] Trying %s ...", p))
				if vim.fn.executable(p) ~= 0 then
					logger.info(string.format("[neotest-bash] Found bashunit at %s", p))
					return p
				end
			end
		end

		logger.info("[neotest-bash] Could not find bashunit")
		return nil
	end,
}

return BashunitFinder
