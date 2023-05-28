local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

-- when luasnip finds a javascript file, load up
-- the javascriptreact snippets too
-- the "filenames" are defined at friendly-snippets
-- repo because cmp load luasnip and
-- luasnip loads friendly snippets
luasnip.filetype_extend("javascript", { "javascriptreact" })
luasnip.filetype_extend("ruby", { "rails" })

-- required in order to get snippets to show in the completion menu
require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

-- load up the kind icons from a nerdfont
local kind_icons = {
	Function = "",
	Method = "",
	Text = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}


cmp.setup({
	snippet = {
    -- pick your snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
	},

	mapping = cmp.mapping.preset.insert({
    -- move up and down in the list of snippets provided
    -- this is Ctrl+k, Ctrl+j
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
    -- move up and down in the documents provided by the currently selected snippet
    -- this is Ctrl+b, Ctrl+f
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    -- pull up the ALL of the completion options
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    -- exit the completion menu
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({ select = true }),

    -- what do do when a Tab is pressed
		["<Tab>"] = cmp.mapping(function(fallback)
      -- if a completion is menu is visible go to the next item
			if cmp.visible() then
				cmp.select_next_item()
      -- if we're in a snippet and it's only expandable, expand it
			elseif luasnip.expandable() then
				luasnip.expand()
      -- if we're in a snippet and its also jumpable, then jump to the next $1 -> $2
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
      -- 
			elseif check_backspace() then
				fallback()
      -- just do a Tab
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	}),

  -- how does the completion menu look?
	formatting = {
    -- font symbol, the abbr, where the snippet comes from
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			vim_item.kind = kind_icons[vim_item.kind]
      -- the string that shows up in the menu section
			vim_item.menu = ({
				nvim_lsp = "lsp",
				nvim_lua = "nvim-lua",
				luasnip = "luasnip",
				buffer = "buffer",
				path = "path",
				emoji = "",
			})[entry.source.name]
			return vim_item
		end,
	},

  -- this is order of precedence for the completion menu
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
  },
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	experimental = {
		ghost_text = true,
	},
})
