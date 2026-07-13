require('meread').setup {}

vim.keymap.set(
	'n',
	'<F10>',
	function()
		vim.cmd "MereadPreview"
	end
)
