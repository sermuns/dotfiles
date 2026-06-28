-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

local comment_keymap = '<C-c>'
vim.keymap.set('v', comment_keymap, function()
  vim.cmd.norm 'gc'
end)
vim.keymap.set('n', comment_keymap, function()
  vim.cmd.norm 'gcc'
end)

vim.keymap.set('n', '<A-h>', '<cmd>bp<cr>', { desc = 'Prev Buffer' })
vim.keymap.set('n', '<A-l>', '<cmd>bn<cr>', { desc = 'Next Buffer' })

-- Move selected lines
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv")

-- Helix-like system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set({ 'n', 'v' }, '<leader>p', [["+p]])

-- spell suggestion
vim.keymap.set('n', '<C-s>', 'z=', { desc = 'Spell suggestion' })

-- see diagnostisc
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
