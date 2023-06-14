local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})


-- the on_attach function below is "format on save"


null_ls.setup({
  -- these sources eventually try to resolve a binary
  -- somewhere on your system. you'll need to make sure you
  -- can execute the intended binary for each source if you
  -- want null_ls to 
  sources = {
    -- null_ls.builtins.formatting.erb_lint,
    -- null_ls.builtins.formatting.erb_lint.with({extra_args = { "--the-args" }})
    -- null_ls.builtins.diagnostics.erb_lint,
    null_ls.builtins.formatting.rubocop,
    null_ls.builtins.diagnostics.rubocop,
    null_ls.builtins.formatting.prettier,
  },
  -- on_attach = function(client, bufnr)
  --   if client.supports_method("textDocument/formatting") then
  --     -- format on save
  --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  --     vim.api.nvim_create_autocmd("BufWritePre", {
  --       group = augroup,
  --       buffer = bufnr,
  --       callback = function()
  --         -- vim.lsp.buf.formatting_sync()
  --         -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
  --         vim.lsp.buf.format({ bufnr = bufnr })
  --       end,
  --     })
  --   end
  -- end,
})
