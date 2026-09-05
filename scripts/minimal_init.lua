-- scripts/minimal_init.lua
-- Headless test bootstrap for mini.test. No user config is loaded and
-- plugins are not sourced (`nvim --noplugin -u this-file`); everything the
-- suite needs comes from ./dependencies (created by `make install`).
--
-- Modeled on rcasia/neotest-java scripts/minimal_init.lua (which replaced
-- plenary's busted runner with mini.test in neotest-java#317).
---@diagnostic disable: deprecated

local DEPENDENCIES_DIR = "./dependencies"

-- Speed up startup by skipping unneeded runtime plugins
for _, p in ipairs({
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"matchit",
	"matchparen",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"rrhelper",
	"spellfile_plugin",
	"shada_plugin",
}) do
	vim.g["loaded_" .. p] = 1
end

vim.opt.shortmess:append("I")
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- ─────────────────────────────────────────────────────────────
-- Runtime path setup (plugin roots, NOT /lua/ subdirectories).
-- `./?.lua` lets specs require repo files like `tests.assertions`.
-- ─────────────────────────────────────────────────────────────
package.path = "./?.lua;./?/init.lua;" .. package.path
vim.opt.runtimepath:append(".")
vim.opt.runtimepath:append(DEPENDENCIES_DIR .. "/mini.nvim")
vim.opt.runtimepath:append(DEPENDENCIES_DIR .. "/nvim-nio")
vim.opt.runtimepath:append(DEPENDENCIES_DIR .. "/neotest")
vim.opt.runtimepath:append(DEPENDENCIES_DIR .. "/nvim-treesitter")
-- plenary must be on the runtimepath only because neotest v5.20 transitively
-- requires plenary.path/plenary.filetype in neotest.lib.*. Do NOT source its
-- plugin/ — that is what installs luassert's global `assert`, which this
-- harness intentionally no longer provides (see tests/assertions.lua).
vim.opt.runtimepath:append(DEPENDENCIES_DIR .. "/plenary.nvim")

-- nvim-treesitter's language registrations, including the `sh` filetype ->
-- `bash` parser alias that position discovery on *_test.sh fixtures needs.
vim.cmd("runtime! plugin/filetypes.lua")

-- ─────────────────────────────────────────────────────────────
-- Enable mini.test
-- ─────────────────────────────────────────────────────────────
require("mini.test").setup({
	collect = {
		emulate_busted = true,
		find_files = function()
			return vim.fn.globpath("tests", "**/*_spec.lua", true, true)
		end,
	},
	execute = {
		reporter = require("mini.test").gen_reporter.stdout(),
		stop_on_error = false,
	},
})
