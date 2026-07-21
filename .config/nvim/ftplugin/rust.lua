local tcp = vim.uv.new_tcp()
tcp:connect("127.0.0.1", 27631, function(err)
	tcp:close()

	if err then
		-- lspmux is not responding
		return
	end

	vim.lsp.config('rust_analyzer', {
		cmd = vim.lsp.rpc.connect("127.0.0.1", 27631),
		settings = {
			["rust-analyzer"] = {
				lspMux = {
					version = "1",
					method = "connect",
					server = "rust-analyzer",
				},
			},
		}
	})
end
)

vim.keymap.set('n', 'gD', require("ferris.methods.open_documentation"))

vim.lsp.config('rust_analyzer', {
	settings = {
		["rust-analyzer"] = {
			cargo = {
				features = "all",
			},
			-- procMacro = {
			-- 	ignored = {
			-- 		leptos_macro = {
			-- 			"component",
			-- 			"server",
			-- 		},
			-- 	},
			-- },
		},
	}
})
