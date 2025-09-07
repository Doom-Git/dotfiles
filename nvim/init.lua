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
-- require "vague".setup({ transparent = true })
-- vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")

-- Gruvbox Dark Color Palette
local colors = {
  bg         = "#282828",
  bg_soft    = "#32302f",
  fg         = "#ebdbb2",
  fg_dim     = "#a89984",
  red        = "#fb4934",
  green      = "#b8bb26",
  yellow     = "#fabd2f",
  blue       = "#83a598",
  purple     = "#d3869b",
  aqua       = "#8ec07c",
  orange     = "#fe8019",
  gray       = "#928374",
  dark_gray  = "#3c3836",
  comment    = "#7c6f64",
  none       = "NONE",
}

-- Helper function to set highlights
local function highlight(group, color)
  vim.api.nvim_set_hl(0, group, color)
end

-- Apply highlights
local function set_highlights()
  -- Editor basics
  highlight("Normal",       { fg = colors.fg, bg = "NONE" }) --"#030200"
  highlight("NormalNC",     { fg = colors.fg_dim, bg = colors.bg })
  highlight("Visual",       { bg = colors.dark_gray })
  highlight("CursorLine",   { bg = colors.bg_soft })
  highlight("CursorColumn", { bg = colors.bg_soft })
  highlight("LineNr",       { fg = colors.gray, bg = "NONE" })
  highlight("CursorLineNr", { fg = colors.yellow, bold = true })

  -- Syntax
  highlight("Comment",      { fg = colors.comment, italic = true })
  highlight("Constant",     { fg = colors.purple })
  highlight("String",       { fg = colors.green })
  highlight("Character",    { fg = colors.orange })
  highlight("Number",       { fg = colors.orange })
  highlight("Boolean",      { fg = colors.orange })
  highlight("Identifier",   { fg = colors.blue })
  highlight("Function",     { fg = colors.blue })
  highlight("Statement",    { fg = colors.red })
  highlight("Conditional",  { fg = colors.red })
  highlight("Repeat",       { fg = colors.red })
  highlight("Label",        { fg = colors.red })
  highlight("Operator",     { fg = colors.fg })
  highlight("Keyword",      { fg = colors.red })
  highlight("Exception",    { fg = colors.red })

  highlight("PreProc",      { fg = colors.aqua })
  highlight("Include",      { fg = colors.aqua })
  highlight("Define",       { fg = colors.aqua })
  highlight("Macro",        { fg = colors.aqua })

  highlight("Type",         { fg = colors.yellow })
  highlight("StorageClass", { fg = colors.yellow })
  highlight("Structure",    { fg = colors.yellow })
  highlight("Typedef",      { fg = colors.yellow })

  highlight("Special",      { fg = colors.orange })
  highlight("SpecialChar",  { fg = colors.orange })
  highlight("Tag",          { fg = colors.aqua })
  highlight("Delimiter",    { fg = colors.fg })
  highlight("SpecialComment", { fg = colors.comment, italic = true })

  highlight("Todo",         { fg = colors.bg, bg = colors.yellow, bold = true })

  -- UI
  highlight("StatusLine",   { fg = colors.fg, bg = colors.dark_gray })
  highlight("StatusLineNC", { fg = colors.fg_dim, bg = colors.bg_soft })
  highlight("VertSplit",    { fg = colors.dark_gray, bg = colors.bg })
  highlight("Pmenu",        { fg = colors.fg, bg = colors.dark_gray })
  highlight("PmenuSel",     { fg = colors.bg, bg = colors.blue })
  highlight("PmenuThumb",   { bg = colors.gray })
  highlight("PmenuSbar",    { bg = colors.dark_gray })

  highlight("Search",       { fg = colors.bg, bg = colors.yellow, bold = true })
  highlight("IncSearch",    { fg = colors.bg, bg = colors.orange, bold = true })

  highlight("MatchParen",   { fg = colors.red, bold = true })

  highlight("DiffAdd",      { bg = "#32361a" })
  highlight("DiffChange",   { bg = "#273641" })
  highlight("DiffDelete",   { bg = "#3c1f1e" })
  highlight("DiffText",     { bg = "#45707a" })

  highlight("GitGutterAdd",    { fg = colors.green })
  highlight("GitGutterChange", { fg = colors.yellow })
  highlight("GitGutterDelete", { fg = colors.red })

  -- LSP
  highlight("DiagnosticError", { fg = colors.red })
  highlight("DiagnosticWarn",  { fg = colors.yellow })
  highlight("DiagnosticInfo",  { fg = colors.blue })
  highlight("DiagnosticHint",  { fg = colors.aqua })
end

-- Apply theme
local function load()
  vim.cmd("highlight clear")
  vim.cmd("syntax reset")
  vim.o.background = "dark"
  vim.g.colors_name = "gruvbox_dark"

  set_highlights()
end

load()

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
