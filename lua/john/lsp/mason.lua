local servers = {
 	"lua_ls",
-- 	"cssls",
-- 	"html",
-- 	"tsserver",
-- 	"pyright",
-- 	"bashls",
-- 	"jsonls",
-- 	"yamlls",
 "solargraph",
}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("john.lsp.handlers").on_attach,
		capabilities = require("john.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

  -- here's a way to add specific opts for each of the lsp servers
  -- look in the settings dir for files named like the servers.
  -- the file is a config that looks like the lspconfig file for the server
  -- change the section you want
	local require_ok, conf_opts = pcall(require, "john.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end
