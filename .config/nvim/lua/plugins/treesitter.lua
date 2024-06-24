return {
    -- Plugin used for simplifying the installation of parsers
    -- It also provides a query mechanism to define highlight groups
    -- Notice that treesitter already come with neovim
    -- It can be found in the vim.treesitter table 
    "nvim-treesitter/nvim-treesitter",
    -- Auto update parsers (recommended)
    build = ':TSUpdate',
    config = function()
        -- Prefer git instead of curl in order to improve connectivity in some environments
        require("nvim-treesitter.install").prefer_git = true
        require("nvim-treesitter.configs").setup({
            -- Install parsers automatically when not found 
            auto_install = true,
            -- Enable highlight module
            highlight = { enable = true },
            -- Enable indentation module 
            indent = { enable = true },
            -- Ensure these parsers are always installed
            ensure_installed = {
                "bash",
                "c",
                "cmake",
                "cpp",
                "css",	
                "diff",
                "dockerfile",
                "doxygen",
                "gitcommit", 
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
                "query",
                "regex",
                "ruby",
                "ssh_config",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
                "zathurarc",
            },
            -- Enable incremental selection module
            -- Leverages tresitter to make smart selections
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<CR>",
                    node_incremental = "<CR>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        })
    end,
}
