return {
	{ 'danilamihailov/beacon.nvim' },
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		lazy = false,
		---@module "neo-tree"
		---@type neotree.Config?
		opts = {
			window = {
				mappings = {
					["<bs>"] = "none", -- disable navigate_up on backspace
					["<space>"] = "none", -- let the leader key work inside neo-tree
				},
			},
			filesystem = {
				filtered_items = {
					visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
					hide_dotfiles = true,
					hide_gitignored = true,
				},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"css",
				"diff",
				"dockerfile",
				"html",
				"javascript",
				"json",
				"latex",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"rust",
				"scss",
				"svelte",
				"tsx",
				"typst",
				"typescript",
				"vim",
				"vue",
				"yaml",
			},
		},
	},

	-- Highlight URLs inside vim
	{ "itchyny/vim-highlighturl", event = "BufReadPost" },

	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		event = "VeryLazy",
	},
}
