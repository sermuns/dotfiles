return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  branch = 'master',
  main = 'nvim-treesitter.configs',
  opts = {
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
  },
}
