-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>cc", "gcc", { remap = true, desc = "Toggle comment" })
vim.keymap.set("x", "<leader>cc", "gc", { remap = true, desc = "Toggle comment" })

-- Always focus the file explorer instead of toggling it (overrides LazyVim's <leader>e).
vim.keymap.set("n", "<leader>e", "<cmd>Neotree focus<cr>", { desc = "Focus Explorer" })

-- <leader>E closes the explorer (<leader>e focuses it).
vim.keymap.set("n", "<leader>E", "<cmd>Neotree close<cr>", { desc = "Close Explorer" })

-- Rename split:
--   <leader>cr = textual whole-word rename in the current buffer only. Populates
--                the cmdline with a :substitute so you get live inccommand preview
--                and just type the new name -- works even when the LSP has no
--                symbol at the cursor.
--   <leader>cR = project-wide LSP rename.
-- The buffer-rename lives on the zz namespace so plugins/lsp.lua can reuse it to
-- override LazyVim's buffer-local <leader>cr keymap.
zz.rename = zz.rename or {}
function zz.rename.buffer()
	local word = vim.fn.expand("<cword>")
	if word == "" then
		return
	end
	local w = vim.fn.escape(word, "/\\")
	-- Cursor lands between the two slashes (3 chars before the end: /gI).
	local lefts = vim.api.nvim_replace_termcodes(("<Left>"):rep(3), true, false, true)
	vim.api.nvim_feedkeys(":%s/\\<" .. w .. "\\>//gI" .. lefts, "n", false)
end

-- Global fallbacks (LSP buffers get buffer-local versions from plugins/lsp.lua).
vim.keymap.set("n", "<leader>cr", zz.rename.buffer, { desc = "Rename in buffer (string)" })
vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, { desc = "Rename (LSP, project-wide)" })

-- <Delete> in visual mode deletes to the black-hole register (no yank).
-- (d still yanks-and-deletes as usual.)
vim.keymap.set("x", "<Del>", '"_d', { desc = "Delete without yanking" })

-- Ctrl-V = paste from the system clipboard in insert mode.
-- (Literal/special-char insertion is still available via <C-q>.)
vim.keymap.set("i", "<C-v>", "<C-r><C-o>+", { desc = "Paste (system clipboard)" })

-- Ctrl-Z = undo (overrides the default suspend behavior).
vim.keymap.set("n", "<C-z>", "u", { desc = "Undo" })
vim.keymap.set("i", "<C-z>", "<C-o>u", { desc = "Undo" })
vim.keymap.set("x", "<C-z>", "<Esc>ugv", { desc = "Undo" })

-- Ctrl-Shift-Z = redo (works in terminals that support the kitty keyboard
-- protocol, e.g. ghostty/kitty/wezterm). Ctrl-Y is a fallback for terminals
-- that can't distinguish Ctrl-Z from Ctrl-Shift-Z.
for _, lhs in ipairs({ "<C-S-z>", "<C-y>" }) do
	vim.keymap.set("n", lhs, "<C-r>", { desc = "Redo" })
	vim.keymap.set("i", lhs, "<C-o><C-r>", { desc = "Redo" })
	vim.keymap.set("x", lhs, "<Esc><C-r>gv", { desc = "Redo" })
end