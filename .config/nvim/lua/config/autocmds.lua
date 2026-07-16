-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local o = vim.o
local fn = vim.fn
local api = vim.api
local nvim_create_augroup = api.nvim_create_augroup
local nvim_create_autocmd = api.nvim_create_autocmd

-- Auto light / dark theme

local function apply_background_colorscheme()
	if o.background == "dark" then
		vim.cmd.colorscheme(zz.config.colorscheme.dark)
	else
		vim.cmd.colorscheme(zz.config.colorscheme.light)
	end
	-- Setup the indent-blankline highlights when changing the colorscheme otherwise it picks up the
	-- default colors. What's happening is that the plugin is defining highlight groups like
	-- `@ibl.whitespace.char.1` which are being cleared when changing the colorscheme but I couldn't
	-- find any way to tell the plugin to redefine them so let's explicitly call it to setup again.
	-- local ok, ibl_highlights = pcall(require, 'ibl.highlights')
	-- if ok then
	--   ibl_highlights.setup()
	-- end
end

nvim_create_autocmd("OptionSet", {
	group = nvim_create_augroup("zz__auto_background", { clear = true }),
	desc = "Auto light / dark theme",
	pattern = "background",
	callback = apply_background_colorscheme,
})

-- Noice links its cmdline popup border/title to DiagnosticSignInfo, whose bg is
-- lighter than the editor under kanagawa -- leaving a visible band behind the
-- rounded border. Redefine those groups: keep the accent fg, match Normal's bg.
-- Noice sets its own groups with `default = true`, so an explicit definition
-- here wins regardless of load order.
local function blend_noice_cmdline_border()
	local normal_bg = api.nvim_get_hl(0, { name = "Normal", link = false }).bg
	local info = api.nvim_get_hl(0, { name = "DiagnosticSignInfo", link = false })
	local warn = api.nvim_get_hl(0, { name = "DiagnosticSignWarn", link = false })
	api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = info.fg, bg = normal_bg })
	api.nvim_set_hl(0, "NoiceCmdlinePopupTitle", { fg = info.fg, bg = normal_bg })
	api.nvim_set_hl(0, "NoiceCmdlinePopupBorderSearch", { fg = warn.fg, bg = normal_bg })
	api.nvim_set_hl(0, "NoiceCmdlineIcon", { fg = info.fg, bg = normal_bg })
	api.nvim_set_hl(0, "NoiceCmdlineIconSearch", { fg = warn.fg, bg = normal_bg })
end

nvim_create_autocmd("ColorScheme", {
	group = nvim_create_augroup("zz__noice_cmdline_border", { clear = true }),
	desc = "Blend noice cmdline border bg with the editor",
	callback = function()
		vim.schedule(blend_noice_cmdline_border)
	end,
})

blend_noice_cmdline_border()
