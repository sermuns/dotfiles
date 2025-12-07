--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
-- vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.linebreak = true
vim.opt.tabstop = 3

-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '| ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- No "splash/intro"
-- vim.opt.shortmess = 'I'

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.o.exrc = true
vim.o.secure = true

-- Disable netrw (MIGHT FUCK SHIT UP)
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

vim.filetype.add {
  extension = {
    html = 'html',
    ers = 'rustscript',
  },
}
