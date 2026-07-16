return {
	"mfussenegger/nvim-lint",
	opts = {
		-- oxlint for the JS/TS family.
		linters_by_ft = {
			javascript = { "oxlint" },
			javascriptreact = { "oxlint" },
			typescript = { "oxlint" },
			typescriptreact = { "oxlint" },
		},
		linters = {
			oxlint = {
				-- The built-in oxlint resolves ./node_modules/.bin/oxlint relative to
				-- nvim's cwd, which breaks when editing a project file from elsewhere.
				-- Resolve it from the linted buffer's directory upward instead.
				cmd = function()
					local fname = vim.api.nvim_buf_get_name(0)
					local dir = fname ~= "" and vim.fs.dirname(fname) or vim.fn.getcwd()
					local local_bin = vim.fs.find("node_modules/.bin/oxlint", { upward = true, path = dir })[1]
					return local_bin or "oxlint"
				end,
			},
		},
	},
}
