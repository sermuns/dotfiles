return {
  'chomosuke/typst-preview.nvim',
  lazy = false,
  opts = {
    -- invert_colors = 'auto',
    open_cmd = 'xdg-open %s &>/dev/null',
    -- port = 23626,
    dependencies_bin = {
      ['tinymist'] = '/home/sermuns/.local/share/nvim/mason/bin/tinymist',
    },
  },
}
