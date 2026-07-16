local namespace = {
	config = {
		-- Global border style
		--
		-- See: https://en.wikipedia.org/wiki/Box-drawing_character
		---@type 'edge'|'single'|'double'|'shadow'|'rounded'|'solid'
		border_style = "edge",

		code_action_lightbulb = {
			enable = false,
		},

		colorscheme = {
			-- Color scheme for dark mode.
			dark = "kanagawa",
			-- Color scheme for light mode.
			light = "dayfox",
		},

		-- LSP inlay hints.
		inlay_hints = {
			enable = false,
		},
	},
}

_G.zz = namespace

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
