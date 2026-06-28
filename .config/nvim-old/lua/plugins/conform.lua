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
      maudfmt = {
        command = '/home/sermuns/.cargo/bin/maudfmt',
        args = { '-s' },
      },
      mbake = {
        command = 'mbake',
        args = { 'format', '--stdin' },
      },
    },
    formatters_by_ft = {
      -- lua = { '' },
      python = { 'ruff_format' },
      javascript = { 'prettierd' },
      typescript = { 'prettierd' },
      html = { 'prettierd' },
      json = { 'prettierd' },
      scss = { 'prettierd' },
      typst = { 'typstyle' },
      markdown = { 'prettierd' },
      yaml = { 'prettierd' },
      dockerfile = { 'prettierd' },
      xml = { 'xmlformatter' },
      c = { 'clang-format' },
      cs = { 'clang-format' },
      cpp = { 'clang-format' },
      -- toml = { 'taplo' },
      go = { 'gofmt' },
      sh = { 'shfmt' },
      rust = { 'rustfmt', 'maudfmt' },
      css = { 'prettierd' },
      kdl = { 'kdlfmt' },
      gdscript = { 'gdscript-formatter' },
      svelte = { 'prettierd' },
      nix = { 'nixfmt' },
      bib = { 'tex-fmt' },
      make = { 'mbake' },
      jsonc = { 'prettierd' },
      svg = { 'xmlstarlet' },
    },
  },
}
