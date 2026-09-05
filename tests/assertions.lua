-- Plain-Lua replacements for the luassert matchers the suite used to get
-- from plenary. mini.test (emulate_busted) provides describe/it/hooks only,
-- so deep-compare helpers live here. Argument order matches the old
-- `assert.are.<matcher>(expected, actual)` calls.
local M = {}

local function fmt(value)
	local text = vim.inspect(value)
	return (text:gsub("[\r\n]%s*", " "))
end

function M.same(expected, actual)
	if not vim.deep_equal(expected, actual) then
		error(("Values are not same.\nExpected: %s\nActual:   %s"):format(fmt(expected), fmt(actual)), 2)
	end
end

function M.equal(expected, actual)
	if expected ~= actual then
		error(("Values are not equal.\nExpected: %s\nActual:   %s"):format(fmt(expected), fmt(actual)), 2)
	end
end

function M.is_true(value)
	M.equal(true, value)
end

function M.is_nil(value)
	if value ~= nil then
		error(("Expected nil, got %s"):format(fmt(value)), 2)
	end
end

function M.has_error(fn)
	local ok, err = pcall(fn)
	if ok then
		error("Expected function to raise an error, but it returned normally", 2)
	end
	return err
end

return M
