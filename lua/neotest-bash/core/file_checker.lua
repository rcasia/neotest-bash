FileChecker = {}

---@async
---@param file_path string
---@return boolean
function FileChecker.isTestFile(file_path)
	-- test files end with test.sh
	return file_path:match("test.sh$")
end

return FileChecker
