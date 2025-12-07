return {
  'chomosuke/typst-preview.nvim',
  lazy = false, -- or ft = 'typst'
  version = '1.*',
  opts = {
    -- invert_colors = 'auto',
    open_cmd = 'xdg-open %s &>/dev/null',
    port = 23626,
    dependencies_bin = {
      ['tinymist'] = '/home/sermuns/.local/share/nvim/mason/bin/tinymist',
    },
  },
}
