-- within nvim -> :help options

vim.opt.number = true			        -- line numbers
vim.opt.relativenumber = true  		        -- relative number lines
vim.opt.numberwidth = 4			        -- width of the line number column




--
--
-- vim.opt.backup = false			    	-- creates a backup file
-- vim.opt.cmdheight = 2			    	-- additional space in cmd line for messages
-- vim.opt.completeopt = { "menuone", "noselect" }
-- vim.opt.ignorecase = true
-- vim.opt.mouse = "a"
-- vim.opt.showmode = false
-- vim.opt.showtabline = 2
-- vim.opt.smartcase = true
-- vim.opt.smartindent = true
-- vim.opt.splitbelow = true
-- vim.opt.splitright = true
-- vim.opt.swapfile = false
-- vim.opt.termguicolors = true
-- vim.opt.updatetime = 300
-- vim.opt.writebackup = false
-- vim.opt.expandtab = true
-- vim.opt.shiftwidth = 2
-- vim.opt.tabstop = 2
-- vim.opt.cursorline = true		        -- highlight the current line
-- vim.opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
-- vim.opt.wrap = false                           -- wrap at window boundary
-- vim.opt.scrolloff = 8                           -- scroll offset from top or bottom of file
-- vim.opt.sidescrolloff = 8                       -- scroll offset from side of file
-- vim.opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications
--
-- -- vim.cmd "set whichwrap+=<,>,[,],h,l"
-- vim.opt.iskeyword:append("-")                   -- strings separated by dashes are considered one word
--
-- -- vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work
