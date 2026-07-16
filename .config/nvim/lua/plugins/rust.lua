return {
	"mrcjkb/rustaceanvim",
	opts = {
		server = {
			default_settings = {
				["rust-analyzer"] = {
					-- Match rustfmt's imports_granularity = "Crate": auto-imports added
					-- via code actions merge into the crate's existing use tree.
					imports = {
						granularity = { group = "crate" },
						prefix = "crate",
					},
				},
			},
		},
	},
}
