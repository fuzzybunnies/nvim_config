local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
	git = {
		clone_timeout = 300, -- Timeout, in seconds, for git clones
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
	use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions used by lots of plugins
	use({ "kyazdani42/nvim-tree.lua" })
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	use({
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})
	use({ "kyazdani42/nvim-web-devicons" })
	use("navarasu/onedark.nvim")

	use({ "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" })
	use({ "neovim/nvim-lspconfig" })
	use({ "mhartington/formatter.nvim" })

	-- -- use { "akinsho/bufferline.nvim", commit = "83bf4dc7bff642e145c8b4547aa596803a8b4dc4" }
	-- -- use { "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" }
	-- use { "nvim-lualine/lualine.nvim",
	--   requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	-- }

	-- -- use { "ahmedkhalf/project.nvim", commit = "628de7e433dd503e782831fe150bb750e56e55d6" }
	-- -- use { "lewis6991/impatient.nvim", commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6" }
	-- -- use { "goolord/alpha-nvim", commit = "0bb6fc0646bcd1cdb4639737a1cee8d6e08bcc31" }

	-- -- -- Colorschemes
	-- -- use { "folke/tokyonight.nvim" }
	-- -- use { "lunarvim/darkplus.nvim", commit = "13ef9daad28d3cf6c5e793acfc16ddbf456e1c83" }

	-- -- -- cmp plugins
	-- use { "hrsh7th/nvim-cmp" }         -- The completion plugin
	-- use { "hrsh7th/cmp-buffer" }       -- buffer completions
	-- use { "hrsh7th/cmp-path" }         -- path completions
	-- use { "saadparwaiz1/cmp_luasnip" } -- snippet completions
	-- use { "hrsh7th/cmp-nvim-lsp" }
	-- use { "hrsh7th/cmp-nvim-lua" }

	-- -- -- snippets
	-- use { "L3MON4D3/LuaSnip" }             --snippet engine
	-- use { "rafamadriz/friendly-snippets" } -- a bunch of snippets to use

	-- -- -- LSP
	-- -- -- use { "williamboman/nvim-lsp-installer", commit = "e9f13d7acaa60aff91c58b923002228668c8c9e6" } -- simple to use language server installer
	-- use { "neovim/nvim-lspconfig" }           -- enable LSP
	-- use { "jose-elias-alvarez/null-ls.nvim" } -- for formatters and linters
	-- use { "RRethy/vim-illuminate" }

	-- -- -- Telescope
	-- use { "benfowler/telescope-luasnip.nvim" }

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	-- -- -- Git
	use({ "lewis6991/gitsigns.nvim" })

	-- -- -- DAP
	-- -- use { "mfussenegger/nvim-dap", commit = "6b12294a57001d994022df8acbe2ef7327d30587" }
	-- -- use { "rcarriga/nvim-dap-ui", commit = "1cd4764221c91686dcf4d6b62d7a7b2d112e0b13" }
	-- -- use { "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" }

	-- -- added by me
	use({ "akinsho/toggleterm.nvim" })
	use({ "lukas-reineke/indent-blankline.nvim" })
	-- use { "Shatur/neovim-session-manager" }

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
