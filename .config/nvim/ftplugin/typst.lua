local typst_preview = require('typst-preview')

typst_preview.setup {
	dependencies_bin = {
		tinymist = '/usr/bin/tinymist',
		websocat = '/usr/bin/websocat',
	},
}

vim.keymap.set(
	'n',
	'<F10>',
	function()
		vim.cmd "TypstPreview"
	end
)
