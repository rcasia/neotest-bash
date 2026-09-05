---@diagnostic disable: undefined-global
local CommandBuilder = require("neotest-bash.util.command_builder")
local assertions = require("tests.assertions")

describe("command_builder", function()
	describe("args", function()
		it("should build command without args", function()
			local cmd = CommandBuilder:new()
			cmd:executable("./lib/bashunit")
			cmd:path("test.sh")

			assertions.same("./lib/bashunit test.sh", cmd:build())
		end)

		it("should build command with empty args table", function()
			local cmd = CommandBuilder:new()
			cmd:executable("./lib/bashunit")
			cmd:path("test.sh")
			cmd:args({})

			assertions.same("./lib/bashunit test.sh", cmd:build())
		end)

		it("should build command with a single arg", function()
			local cmd = CommandBuilder:new()
			cmd:executable("./lib/bashunit")
			cmd:path("test.sh")
			cmd:args({ "--report-coverage" })

			assertions.same("./lib/bashunit test.sh --report-coverage", cmd:build())
		end)

		it("should build command with multiple args", function()
			local cmd = CommandBuilder:new()
			cmd:executable("./lib/bashunit")
			cmd:path("test.sh")
			cmd:args({ "--report-coverage", "--verbose" })

			assertions.same("./lib/bashunit test.sh --report-coverage --verbose", cmd:build())
		end)

		it("should build command with filter and args", function()
			local cmd = CommandBuilder:new()
			cmd:executable("./lib/bashunit")
			cmd:path("test.sh")
			cmd:filter("test_it_works")
			cmd:args({ "--report-coverage" })

			assertions.same("./lib/bashunit test.sh --filter test_it_works --report-coverage", cmd:build())
		end)
	end)
end)
