return {
	-- Apply the configured light/dark colorscheme at startup instead of
	-- LazyVim's default. Live toggling is handled by the OptionSet autocmd.
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = function()
				local c = zz.config.colorscheme
				vim.cmd.colorscheme(vim.o.background == "dark" and c.dark or c.light)
			end,
		},
	},
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		opts = {
			-- Remove the distinct background behind the line-number gutter.
			colors = {
				theme = {
					all = {
						ui = {
							bg_gutter = "none",
						},
					},
				},
			},
			overrides = function(colors)
				local theme = colors.theme
				-- Tinted diagnostic virtual text, à la tokyonight.nvim.
				local makeDiagnosticColor = function(color)
					local c = require("kanagawa.lib.color")
					return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
				end

				return {
					-- Make floating windows (noice cmdline, hover, etc.) match the
					-- editor background instead of kanagawa's darker float bg.
					NormalFloat = { bg = theme.ui.bg },
					FloatBorder = { bg = theme.ui.bg },
					FloatTitle = { bg = theme.ui.bg },

					DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
					DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
					DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
					DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),

					-- Softer indent guides (defaults link to NonText, too bright).
					-- neo-tree + editor (snacks) kept the same subtle color.
					NeoTreeIndentMarker = { fg = theme.ui.bg_p2 },
					SnacksIndent = { fg = theme.ui.bg_p2 },
					-- Active scope kept lighter so it stands out from the indent lines.
					SnacksIndentScope = { fg = theme.ui.special },
				}
			end,
		},
	},
	{
		"EdenEast/nightfox.nvim",
		priority = 1000,
		config = true,
	},
}
