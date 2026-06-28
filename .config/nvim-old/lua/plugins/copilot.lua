return {
  'github/copilot.vim',
  enabled = true, 
  config = function()
    vim.cmd 'Copilot disable'
    vim.keymap.set('i', '<M-c>', '<Plug>(copilot-suggest)')
  end,
}
