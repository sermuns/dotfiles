return {
  'mrcjkb/rustaceanvim',
  version = '^7', -- Recommended
  lazy = false, -- This plugin is already lazy
  config = function()
    vim.keymap.set('n', 'gD', function()
      vim.cmd.RustLsp 'openDocs'
    end, { silent = true })
    -- vim.keymap.set('n', 'F12', ':RustAnalyzer config { cargo = { target = "wasm32-unknown-unknown" } }')
    -- local bufnr = vim.api.nvim_get_current_buf()
    -- vim.keymap.set('n', '<leader>a', function()
    --   vim.cmd.RustLsp 'codeAction' -- supports rust-analyzer's grouping
    --   -- or vim.lsp.buf.codeAction() if you don't want grouping.
    -- end, { silent = true, buffer = bufnr })
   -- vim.keymap.set(
   --    'n',
   --    'K', -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
   --    function()
   --      vim.cmd.RustLsp { 'hover', 'actions' }
   --    end,
   --    { silent = true, buffer = bufnr }
   --  )
  end,
}
