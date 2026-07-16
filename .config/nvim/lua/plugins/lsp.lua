-- NOTE: clangd, tailwindcss, pyright, and rust_analyzer are intentionally NOT
-- enabled here -- they are owned by their LazyVim extras (lang.clangd,
-- lang.tailwind, lang.python, lang.rust). rust uses rustaceanvim, which manages
-- rust_analyzer itself; enabling it here would attach a second client.

-- Bash
vim.lsp.enable("bashls")

-- C#
vim.lsp.enable("omnisharp")

-- TypeScript/JavaScript via tsgo (@typescript/native-preview).
-- The binary lives in the project's node_modules/.bin (pnpm), so resolve it per
-- buffer and start a client scoped to that project root. vim.lsp.start dedups by
-- {name, root_dir}, so each worktree/project gets its own client.
local ts_fts = { "typescript", "typescriptreact", "javascript", "javascriptreact" }

local function find_tsgo(fname)
	local found = vim.fs.find("node_modules/.bin/tsgo", { upward = true, path = vim.fs.dirname(fname) })[1]
	return found or (vim.fn.executable("tsgo") == 1 and "tsgo" or nil)
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = ts_fts,
	group = vim.api.nvim_create_augroup("zz__tsgo", { clear = true }),
	callback = function(args)
		local fname = vim.api.nvim_buf_get_name(args.buf)
		if fname == "" then
			return
		end
		local cmd = find_tsgo(fname)
		if not cmd then
			return -- no tsgo available for this project
		end
		local root = vim.fs.root(args.buf, { "tsconfig.json", "jsconfig.json", "package.json", ".git" })
		vim.lsp.start({
			name = "tsgo",
			cmd = { cmd, "--lsp", "--stdio" },
			root_dir = root or vim.fs.dirname(fname),
		}, { bufnr = args.buf })
	end,
})

return {
	-- Add a border to diagnostic float popups (extends LazyVim's diagnostics opts,
	-- which are applied via vim.diagnostic.config in nvim-lspconfig's setup).
	{
		"neovim/nvim-lspconfig",
		opts = {
			diagnostics = {
				float = {
					border = "rounded",
					source = true,
				},
			},
			servers = {
				["*"] = {
					-- <leader>cr = textual whole-word rename in the current buffer
					--              (zz.rename.buffer, defined in config/keymaps.lua).
					-- <leader>cR = project-wide LSP rename.
					-- gk        = signature help (renamed from the default gK).
					keys = {
						{
							"<leader>cr",
							function()
								zz.rename.buffer()
							end,
							desc = "Rename in buffer (string)",
						},
						{
							"<leader>cR",
							function()
								vim.lsp.buf.rename()
							end,
							desc = "Rename (LSP, project-wide)",
							has = "rename",
						},
						{ "gK", false }, -- disable the default uppercase binding
						{
							"gk",
							function()
								vim.lsp.buf.signature_help()
							end,
							desc = "Signature Help",
							has = "signatureHelp",
						},
					},
				},
			},
		},
	},
}
