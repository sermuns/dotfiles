require('typst-preview').setup {
	dependencies_bin = {
		tinymist = '/usr/bin/tinymist',
		websocat = '/usr/bin/websocat',
	},
}


vim.lsp.config["tinymist"] = {
	settings = {
		formatterMode = "typstyle",
	}
}


vim.keymap.set(
	'n',
	'<F10>',
	function()
		vim.cmd "TypstPreview"
	end
)
