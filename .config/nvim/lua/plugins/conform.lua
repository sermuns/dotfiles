return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<S-M-f>',
      function()
        require('conform').format { async = true }
      end,
      mode = 'n',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    formatters = {
      -- taplo = {
      --   args = { 'format', '-o', 'indent_string=\t', '-' },
      -- },
    },
    formatters_by_ft = {
      lua = { 'stylua', stop_after_first = true },
      python = { 'ruff_format' },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      html = { 'prettierd' },
      scss = { 'prettierd', 'prettier', stop_after_first = true },
      typst = { 'typstyle' },
      markdown = { 'prettierd' },
      yaml = { 'prettierd' },
      dockerfile = { 'prettierd' },
      xml = { 'xmlformatter' },
      c = { 'clang-format' },
      cs = { 'clang-format' },
      -- toml = { 'taplo' },
      htmldjango = { 'djlint' },
      go = { 'gofmt' },
      sh = { 'shfmt' },
      rust = { 'rustfmt' },
      css = { 'prettierd' },
      kdl = { 'kdlfmt' },
    },
  },
}
