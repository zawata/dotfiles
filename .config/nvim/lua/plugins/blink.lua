return {
	"saghen/blink.cmp",
	opts = function(_, opts)
		opts.keymap = opts.keymap or {}

		-- "default" preset does NOT bind <CR>/<Tab> to accept, so Enter falls
		-- through to a normal newline. We then rebind Tab to accept.
		opts.keymap.preset = "default"

		-- <Tab>: accept the highlighted completion; otherwise jump a snippet /
		-- accept a copilot suggestion; otherwise fall back to a normal <Tab> (indent).
		opts.keymap["<Tab>"] = {
			"select_and_accept",
			LazyVim.cmp.map({ "snippet_forward", "ai_nes", "ai_accept" }),
			"fallback",
		}
		opts.keymap["<S-Tab>"] = { "snippet_backward", "fallback" }

		-- <CR>: never accept -- just a normal newline.
		opts.keymap["<CR>"] = { "fallback" }

		-- <Esc>: dismiss the completion popup but stay in insert mode; if the popup
		-- is already closed, fall back to the normal <Esc> (leave insert mode).
		opts.keymap["<Esc>"] = { "cancel", "fallback" }

		-- Auto-show the function signature/param popup while typing arguments
		-- (e.g. after "(" or ","). Manual trigger is still <C-k> (insert) / gK.
		opts.signature = vim.tbl_deep_extend("force", opts.signature or {}, {
			enabled = true,
			window = { border = "rounded", show_documentation = true },
		})
	end,
}
