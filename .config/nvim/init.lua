vim.g.mapleader = ' '

vim.o.number = true

vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.showmode = false

vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.linebreak = true

vim.o.undofile = true

vim.opt.listchars = { tab = '| ', trail = '·', nbsp = '␣' }
vim.o.list = true

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

-- reload config
vim.keymap.set(
	'n',
	'<F3>',
	function()
		vim.cmd.source(vim.env.MYVIMRC)
		vim.notify 'Nvim config reloaded'
	end
)

vim.keymap.set('n', '<F2>', vim.lsp.buf.rename)
vim.keymap.set('n', '<S-M-f>', vim.lsp.buf.format)
vim.keymap.set({ 'n', 'v' }, 'H', vim.lsp.buf.code_action)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gr', vim.lsp.buf.references)

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
	end
})


vim.api.nvim_create_autocmd('BufReadPost', {
	group = vim.api.nvim_create_augroup('last-known-pos', { clear = true }),
	callback = function(args)
		local valid_line = vim.fn.line [['"]] >= 1 and vim.fn.line [['"]] < vim.fn.line '$'
		local not_commit = vim.b[args.buf].filetype ~= 'commit'

		if valid_line and not_commit then
			vim.cmd [[normal! g`"]]
		end
	end,
})

vim.cmd('packadd! nohlsearch')

vim.pack.add({
	'https://github.com/folke/tokyonight.nvim',
	'https://github.com/neovim/nvim-lspconfig',
	{ src = 'https://github.com/nvim-mini/mini.nvim', version = 'stable' },
	'https://github.com/stevearc/quicker.nvim',
	'https://github.com/lewis6991/gitsigns.nvim',
	{
		src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
		version = vim.version.range('3')
	},
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	'https://github.com/folke/todo-comments.nvim',
	'https://github.com/j-hui/fidget.nvim',
	'https://github.com/chomosuke/typst-preview.nvim',
	'https://github.com/brenoprata10/nvim-highlight-colors',
	'https://github.com/nvim-tree/nvim-web-devicons',
	'https://github.com/vxpm/ferris.nvim',
	{
		src = 'https://github.com/sermuns/MEREAD',
		version = vim.version.range('1')
	}
})

vim.lsp.config('html', {
	filetypes = { 'html', 'htmldjango' }
})

vim.lsp.enable {
	'lua_ls',
	'yamlls',
	'tombi',
	'just',
	'rumdl',
	'cssls',
	'rust_analyzer',
	'basedpyright',
	'ruff',
	'jinja_lsp',
	'html',
	'docker_language_server',
}

require('ferris').setup {}

require('nvim-highlight-colors').setup({})

require('fidget').setup {}

require('mini.completion').setup {}
-- do file path completion
vim.keymap.set("i", "<C-f>", "<C-x><C-f>", { remap = true })

local statusline = require('mini.statusline')
statusline.setup {}
statusline.section_location = function()
	return '%2l:%-2v'
end

local pick = require 'mini.pick'
pick.setup {}
vim.keymap.set('n', '<leader>sh', pick.builtin.help, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sf', pick.builtin.files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sg', pick.builtin.grep_live, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sr', pick.builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader><leader>', pick.builtin.buffers, { desc = '[ ] Find existing buffers' })

local animate = require('mini.animate')
animate.setup {
	cursor = {
		timing = animate.gen_timing.quadratic {
			easing = 'in-out',
			duration = 2,
		}
	},
	scroll = {
		timing = animate.gen_timing.quadratic {
			easing = 'out',
			duration = 2,
		}
	}
}


require('quicker').setup {}
require('gitsigns').setup {}
require('todo-comments').setup {}


vim.keymap.set('n', '\\', '<cmd>Neotree toggle<cr>')

vim.cmd.colorscheme 'tokyonight-night'
