require("mason").setup()
local mason_lspconfig = require("mason-lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()

local servers = {
	lua_ls = {},
	ruby_lsp = {},
}

mason_lspconfig.setup {
	ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
	function(server_name)
		-- print(server_name)
		-- require("pl.pretty").dump(capabilities)

		require("lspconfig")[server_name].setup {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
			filetypes = (servers[server_name] or {}).filetypes,
		}
	end
}



