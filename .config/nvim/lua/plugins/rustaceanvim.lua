return {
  'mrcjkb/rustaceanvim',
  version = '^9',
  lazy = false,
  config = function()
    vim.keymap.set('n', 'gD', function()
      vim.cmd.RustLsp 'openDocs'
    end, { silent = true })

    local bufnr = vim.api.nvim_get_current_buf()
    vim.keymap.set('n', '<leader>a', function()
      vim.cmd.RustLsp 'codeAction'
    end, { silent = true, buffer = bufnr })

    vim.g.rustaceanvim = {
      server = {
        default_settings = {
          ['rust-analyzer'] = {
            cargo = {
              features = 'all',
              targetDir = '/home/sermuns/.cache/cargo/'
            },
          },
        },
      },
    }
  end,
}
