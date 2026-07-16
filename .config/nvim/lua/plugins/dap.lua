-- Post-load tweaks for nvim-dap. Runs once, after nvim-dap and its deps
-- (mason-nvim-dap, the clangd extra's config) have finished -- so our C/C++
-- adapter choice is the final word and the sign/frame tweaks stick.
vim.api.nvim_create_autocmd("User", {
	pattern = "LazyLoad",
	callback = function(ev)
		if ev.data ~= "nvim-dap" then
			return
		end
		local dap = require("dap")

		-- Red breakpoint signs (LazyVim leaves them DiagnosticInfo/blue).
		for _, name in ipairs({ "DapBreakpoint", "DapBreakpointCondition", "DapLogPoint" }) do
			local def = vim.fn.sign_getdefined(name)[1]
			if def then
				def.texthl = "DiagnosticError"
				vim.fn.sign_define(name, def)
			end
		end

		-- Always show runtime/library frames (e.g. __cxa_throw) by stripping the
		-- "subtle" hint dap-ui filters on.
		dap.listeners.after.stackTrace["zz_show_subtle"] = function(_, _, response)
			if response and response.stackFrames then
				for _, frame in ipairs(response.stackFrames) do
					if frame.presentationHint == "subtle" then
						frame.presentationHint = nil
					end
				end
			end
		end

		-- C/C++ via gdb's native DAP (better GCC/libstdc++ support than codelldb).
		-- Set here so it overrides the codelldb/cppdbg configs the clangd extra and
		-- mason-nvim-dap register during load.
		dap.adapters.gdb = {
			type = "executable",
			command = "gdb",
			args = { "-i", "dap" },
		}
		local configs = {
			{
				name = "Launch (gdb)",
				type = "gdb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtBeginningOfMainSubprogram = false,
			},
			{
				name = "Attach (gdb)",
				type = "gdb",
				request = "attach",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				pid = require("dap.utils").pick_process,
				cwd = "${workspaceFolder}",
			},
		}
		dap.configurations.c = configs
		dap.configurations.cpp = configs

		return true -- one-shot
	end,
})

return {
	-- nvim-dap + dap-ui come from the dap.core extra; just extend the
	-- mason-nvim-dap ensure_installed list (lazy merges with the extra's opts).
	{
		"jay-babu/mason-nvim-dap.nvim",
		opts = { ensure_installed = { "python", "bash" } },
	},

	-- Replace nvim-dap-ui with nvim-dap-view.
	{ "rcarriga/nvim-dap-ui", enabled = false },
	{
		"mfussenegger/nvim-dap",
		-- Load dap-view with dap so its auto_toggle listeners are registered
		-- before a session starts.
		dependencies = { "igorlfs/nvim-dap-view" },
	},
	{
		"igorlfs/nvim-dap-view",
		opts = {
			auto_toggle = true, -- open on session start, close on end
			winbar = {
				controls = {
					enabled = true, -- clickable play/step/terminate buttons in the winbar
				},
			},
		},
		-- stylua: ignore
		keys = {
			{ "<leader>du", "<cmd>DapViewToggle<cr>", desc = "Dap View (toggle)" },
			{ "<leader>de", "<cmd>DapViewWatch<cr>", desc = "Watch expression", mode = { "n", "x" } },
		},
	},
}
