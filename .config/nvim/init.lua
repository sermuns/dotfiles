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
vim.keymap.set('n', 'gca', vim.lsp.buf.code_action)
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

vim.api.nvim_create_autocmd('PackChanged', {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
			vim.system({ 'cmake', '-S.', '-Bbuild', '-DCMAKE_BUILD_TYPE=Release' }, { cwd = ev.data.path },
				function(obj)
					if obj.code ~= 0 then
						vim.notify 'cmake --build failed for telescope-fzf-native.nvim'
					else
						vim.system(
							{ 'cmake', '--build', 'build', '--config', 'Release', '--target',
								'install' }, { cwd = ev.data.path })
					end
				end)
		end
	end,
})

vim.cmd('packadd! nohlsearch')

vim.pack.add({
	'https://github.com/folke/tokyonight.nvim',
	'https://github.com/neovim/nvim-lspconfig',
	{ src = 'https://github.com/nvim-mini/mini.completion', version = 'stable' },
	{ src = 'https://github.com/nvim-mini/mini.statusline', version = 'stable' },
	'https://github.com/stevearc/quicker.nvim',
	'https://github.com/lewis6991/gitsigns.nvim',
	{
		src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
		version = vim.version.range('3')
	},
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/sphamba/smear-cursor.nvim",
	"https://github.com/karb94/neoscroll.nvim",
	{
		src = 'https://github.com/nvim-telescope/telescope.nvim',
		version = vim.version.range '0.2',
	},
	'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
	'https://github.com/folke/todo-comments.nvim',
})

vim.lsp.enable {
	'lua_ls',
	'rust_analyzer',
	'yamlls',
	'tombi',
}

vim.lsp.config('rust_analyzer', {
	cmd = vim.lsp.rpc.connect("127.0.0.1", 27631),
	settings = {
		["rust-analyzer"] = {
			lspMux = {
				version = "1",
				method = "connect",
				server = "rust-analyzer",
			},
		},
	}
})

require('mini.completion').setup {}
local statusline = require('mini.statusline')
statusline.setup {}
statusline.section_location = function()
	return '%2l:%-2v'
end

require('quicker').setup {}
require('gitsigns').setup {}
require('todo-comments').setup {}

require('smear_cursor').setup({
	stiffness = 0.95,
	trailing_stiffness = 0.8,
	distance_stop_animating = 0.1,
	hide_target_hack = false,
})

require('neoscroll').setup {
	easing = 'cubic',
	duration_multiplier = 0.3,
	performance_mode = false,
}

vim.keymap.set('n', '\\', '<cmd>Neotree toggle<cr>')

require('telescope').setup {
	extensions = {
		fzf = {}
	}
}

require('telescope').load_extension('fzf')

local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

vim.cmd.colorscheme 'tokyonight-night'
