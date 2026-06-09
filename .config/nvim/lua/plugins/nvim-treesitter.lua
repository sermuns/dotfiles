return {
  'neovim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = { 'neovim-treesitter/treesitter-parser-registry' },
  opts = {
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
  },
}
