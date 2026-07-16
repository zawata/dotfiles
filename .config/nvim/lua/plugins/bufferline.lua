return {
	"akinsho/bufferline.nvim",
	opts = function(_, opts)
		opts.options = opts.options or {}

		-- Hover requires mousemoveevent on at the nvim level.
		vim.opt.mousemoveevent = true

		-- Keep the bufferline visible even when the current tab has no buffers
		-- (e.g. a freshly opened nvim tab with scope.nvim).
		opts.options.always_show_bufferline = true

		-- Hide the close (X) icon unless the cursor is hovering over the tab.
		opts.options.hover = {
			enabled = true,
			delay = 100,
			reveal = { "close" },
		}

		for _, offset in ipairs(opts.options.offsets or {}) do
			if offset.filetype == "neo-tree" then
				offset.text_align = "center"
			end
		end

		-- LazyVim's default get_element_icon only checks a sparse ft table and
		-- returns nil for most filetypes -> bufferline falls back to a colorless
		-- default. Route through mini.icons (which honors our per-extension
		-- overrides for cpp/hpp/etc.) so every tab gets a colored icon.
		opts.options.get_element_icon = function(o)
			local mi = require("mini.icons")
			local icon, hl
			if o.path and o.path ~= "" then
				icon, hl = mi.get("file", o.path)
			end
			if not icon and o.extension and o.extension ~= "" then
				icon, hl = mi.get("extension", o.extension)
			end
			if not icon and o.filetype and o.filetype ~= "" then
				icon, hl = mi.get("filetype", o.filetype)
			end
			if not icon then
				icon, hl = mi.get("default", "file")
			end
			-- bufferline expects two return values: (icon, hl), not a table.
			return icon, hl
		end

		-- Make the current buffer unmistakable: a solid accent-colored block with
		-- dark bold text, instead of the subtle default.
		local accent_bg = "#7e9cd8" -- kanagawa crystalBlue
		local accent_fg = "#1f1f28" -- editor bg (dark text on the accent)
		opts.highlights = opts.highlights or {}
		local selected_groups = {
			"buffer_selected",
			"numbers_selected",
			"modified_selected",
			"duplicate_selected",
			"close_button_selected",
			"pick_selected",
			"diagnostic_selected",
			"hint_selected",
			"hint_diagnostic_selected",
			"info_selected",
			"info_diagnostic_selected",
			"warning_selected",
			"warning_diagnostic_selected",
			"error_selected",
			"error_diagnostic_selected",
		}
		for _, g in ipairs(selected_groups) do
			opts.highlights[g] = vim.tbl_extend("force", opts.highlights[g] or {}, {
				fg = accent_fg,
				bg = accent_bg,
				bold = true,
				italic = false,
			})
		end
		-- Drop the left indicator bar; the colored block is the indicator now.
		opts.highlights.indicator_selected = { fg = accent_bg, bg = accent_bg }
	end,
}
