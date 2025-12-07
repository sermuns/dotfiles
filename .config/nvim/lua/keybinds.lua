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

vim.keymap.set('n', '<A-h>', '<cmd>tabprevious<cr>', { desc = 'Prev Tab' })
vim.keymap.set('n', '<A-l>', '<cmd>tabnext<cr>', { desc = 'Next Tab' })

-- Move selected lines
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv")

-- Helix-like system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set({ 'n', 'v' }, '<leader>p', [["+p]])

-- spell suggestion
vim.keymap.set('n', '<C-s>', 'z=', { desc = 'Spell suggestion' })

-- see diagnostisc
vim.keymap.set('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>')

local function paste_image()
  if vim.bo.filetype ~= 'typst' then
    return
  end

  local dir = vim.fn.expand '%:p:h'
  local name = vim.fn.input('Image name: ', 'image')
  if name == '' then
    return
  end

  -- Detect clipboard MIME type
  local handle = io.popen 'wl-paste --list-types'
  local types = handle:read '*a'
  handle:close()

  local mime_map = {
    ['image/png'] = '.png',
    ['image/jpeg'] = '.jpg',
    ['image/svg+xml'] = '.svg',
  }

  local ext, mime
  for m, e in pairs(mime_map) do
    if types:match(m) then
      ext, mime = e, m
      break
    end
  end

  if not ext then
    print("Clipboard has no supported image. Detected MIME types:\n" .. types)
    return
  end

  local filename = string.format('%s/%s%s', dir, name, ext)
  local cmd = string.format("wl-paste --no-newline --type %s > '%s'", mime, filename)
  if os.execute(cmd) ~= 0 then
    print 'Failed to save clipboard content'
    return
  end

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { '#image("' .. vim.fn.fnamemodify(filename, ':t') .. '")' })
end

vim.keymap.set('i', '<C-v>', paste_image, { noremap = true, silent = true })
