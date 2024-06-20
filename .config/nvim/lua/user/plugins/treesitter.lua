return {
	"nvim-treesitter/nvim-treesitter",
	build = ':TSUpdate',
	config = function()
	  -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true
      require("nvim-treesitter.configs").setup({
      	auto_install = true,
      	highlight = { enable = true },
      	indent = { enable = true },
      	ensure_installed = {
        	"bash",
        	"c",
        	"cmake",
			"cpp",
			"css",        	
        	"diff",
        	"dockerfile",
        	"doxygen",
        	"gitignore",
        	"html",
        	"java",
        	"javascript",
        	"jsdoc",
        	"json",
        	"lua",
        	"make",
        	"markdown",
        	"markdown_inline",
        	"perl",
        	"printf",
        	"python",
        	"regex",
        	"ruby",
        	"ssh_config",
        	"vim",
        	"vimdoc",
        	"xml",
        	"yaml",
        	"zathurarc",
      	},
      	incremental_selection = {
        	enable = true,
        	keymaps = {
        	init_selection = "<C-s>",
        	node_incremental = "<C-s>",
        	scope_incremental = false,
        	node_decremental = "<bs>",
        	},
      	},
      })
    end,
}
