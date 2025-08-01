require("nvchad.configs.lspconfig").defaults()

local servers = { "rust-analyzer" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
