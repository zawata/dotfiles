-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- 4-space indentation (LazyVim defaults to 2).
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- Bar cursor only where insertion happens (insert / command); block in
-- normal, visual and operator-pending; underline for replace (overtype).
vim.opt.guicursor = "n-v-ve-o-sm:block,i-ci-c:ver25,r-cr:hor20,t:block"
