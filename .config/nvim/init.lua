vim.g.mapleader = ' '

vim.o.number = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.linebreak = true

vim.o.undofile = true

vim.opt.listchars = { tab = '| ', trail = '·', nbsp = '␣' }
vim.o.list = true

vim.opt.tabstop = 3

vim.opt.completeopt = { "menu", "menuone", "noinsert" }

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

vim.keymap.set({ 't', 'i' }, '<C-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set({ 't', 'i' }, '<C-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set({ 't', 'i' }, '<C-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set({ 't', 'i' }, '<C-l>', '<C-\\><C-n><C-w>l')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set({ 'n', 'v' }, '<leader>p', [["+p]])

vim.keymap.set('n', '<A-h>', vim.cmd.bprevious)
vim.keymap.set('n', '<A-l>', vim.cmd.bnext)
vim.keymap.set('n', '<A-q>', vim.cmd.close)

vim.keymap.set('n', '<F3>', vim.cmd.source)

vim.keymap.set('n', '<F2>', vim.lsp.buf.rename)
vim.keymap.set('n', 'gr', vim.lsp.buf.references)
vim.keymap.set('n', 'gca', vim.lsp.buf.code_action)
vim.keymap.set('n', '<S-M-f>', vim.lsp.buf.format)

vim.keymap.set('v', '<C-c>', 'gc', { remap = true })
vim.keymap.set('n', '<C-c>', 'gcc', { remap = true })

vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set({ 'n', 'v' }, '<leader>p', [["+p]])

vim.keymap.set('n', '<Esc>', vim.cmd.nohlsearch)

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	callback = function()
		vim.hl.on_yank()
	end,
})



vim.cmd('packadd! nohlsearch')

vim.pack.add({
	-- Quickstart configs for LSP
	'https://github.com/neovim/nvim-lspconfig',
	-- Fuzzy picker
	'https://github.com/ibhagwan/fzf-lua',
	-- Autocompletion
	{ src = 'https://github.com/nvim-mini/mini.completion', version = 'stable' },
	-- Enhanced quickfix/loclist
	'https://github.com/stevearc/quicker.nvim',
	-- Git integration
	'https://github.com/lewis6991/gitsigns.nvim',
	{
		src = 'https://github.com/mrcjkb/rustaceanvim',
		version = vim.version.range('^9')
	},
	{
		src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
		version = vim.version.range('3')
	},
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/sphamba/smear-cursor.nvim",
	"https://github.com/karb94/neoscroll.nvim",
})

vim.lsp.enable 'lua_ls'

require('fzf-lua').setup { fzf_colors = true }
require('mini.completion').setup {}
require('quicker').setup {}
require('gitsigns').setup {}

require('smear_cursor').setup({
	stiffness = 0.95,
	trailing_stiffness = 0.8,
	distance_stop_animating = 0.1,
	hide_target_hack = false,
})

require('neoscroll').setup {
	easing = 'cubic',
	duration_multiplier = 0.2,
	performance_mode = true,
}

vim.keymap.set('n', '\\', '<cmd>Neotree toggle<cr>')
