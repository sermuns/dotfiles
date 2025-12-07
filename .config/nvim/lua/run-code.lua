-- Function to run the current file based on its type
local function run_code()
  local filetype = vim.bo.filetype
  local filename = vim.fn.expand '%:p'

  if filetype == 'go' then
    vim.cmd '!go run .'
  elseif filetype == 'python' then
    vim.cmd('!uv run ' .. filename)
  elseif filetype == 'markdown' then
    vim.cmd(string.format('TermExec open=1 cmd="meread %s"', filename))
    print("Launching MEREAD...")
  elseif filetype == 'typst' then
    vim.cmd 'TypstPreview'
    print 'Started typst preview!'
  else
    print('No run command defined for filetype: ' .. filetype)
  end
end

-- Map F10 to the run_code function using vim.keymap.set
vim.keymap.set('n', '<F10>', run_code, { noremap = true, silent = true })
