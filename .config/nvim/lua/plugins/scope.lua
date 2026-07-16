return {
	"tiagovla/scope.nvim",
	lazy = false,
	priority = 100, -- load before bufferline so it intercepts buffer events
	config = function()
		-- Needed for session restore to remember per-tab buffer lists.
		vim.opt.sessionoptions:append({ "tabpages", "globals" })
		require("scope").setup({})
	end,
}
