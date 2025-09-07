vim = vim
vim.cmd([[set mouse=]])
vim.opt.winborder = "rounded"
vim.opt.hlsearch = false
vim.opt.tabstop = 2
vim.opt.cursorcolumn = false
vim.opt.ignorecase = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"

local map = vim.keymap.set
vim.g.mapleader = " "

map('n', '<leader>o', ':update<CR> :source<CR>')
map('n', '<leader>w', ':write<CR>')
map('n', '<leader>q', ':quit<CR>')
map('n', '<leader>lf', vim.lsp.buf.format)
map('n', '<leader>n', ':set nowrap<CR>')

vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/nvim-mini/mini.completion" },
})


-- colors
require "vague".setup({ transparent = true })
vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")

require "mason".setup()
require "mini.completion".setup({
	delay = { completion = 100, info = 100, signature = 50 },

	-- Configuration for action windows:
	-- - `height` and `width` are maximum dimensions.
	-- - `border` defines border (as in `nvim_open_win()`; default "single").
	window = {
		info = { height = 25, width = 80, border = nil },
		signature = { height = 25, width = 80, border = nil },
	},

	-- Way of how module does LSP completion
	lsp_completion = {
		-- `source_func` should be one of 'completefunc' or 'omnifunc'.
		source_func = 'completefunc',

		-- `auto_setup` should be boolean indicating if LSP completion is set up
		-- on every `BufEnter` event.
		auto_setup = true,

		-- A function which takes LSP 'textDocument/completion' response items
		-- (each with `client_id` field for item's server) and word to complete.
		-- Output should be a table of the same nature as input. Common use case
		-- is custom filter/sort. Default: `default_process_items`
		process_items = nil,

		-- A function which takes a snippet as string and inserts it at cursor.
		-- Default: `default_snippet_insert` which tries to use 'mini.snippets'
		-- and falls back to `vim.snippet.expand` (on Neovim>=0.10).
		snippet_insert = nil,
	},
})

vim.lsp.enable({ "lua_ls", "rust-analyzer", "gopls" })
