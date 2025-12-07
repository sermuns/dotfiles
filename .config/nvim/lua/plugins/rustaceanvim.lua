return {
  'mrcjkb/rustaceanvim',
  version = '^6', -- Recommended
  lazy = false, -- This plugin is already lazy
  config = function()
    vim.keymap.set('n', 'gD', ':RustLsp openDocs<CR>')
    vim.keymap.set('n', 'F12', ':RustAnalyzer config { cargo = {target = "wasm32-unknown-unknown" } }')
  end,
}
