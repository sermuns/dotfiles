local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font 'Monaspace Krypton'
config.font_size = 40

local padding = 0
config.window_padding = {
	left = padding,
	right = padding,
	top = padding,
	bottom = padding,
}

config.color_scheme = 'tokyonight_night'

config.enable_tab_bar = false

config.default_prog = { 'bash', '-i' }

return config
