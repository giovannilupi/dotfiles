return {
    -- Plugin to enable syntax-aware motions leveraging treesitter
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    -- This plugin can be loaded after the UI
    event = "VeryLazy",
    config = function()
        require("nvim-treesitter.configs").setup({
            textobjects = {
                select = {
                    enable = true,

                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,

                    keymaps = {
                        -- Conditionals
                        ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
                        ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },
                        -- Loops
                        ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
                        ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },
                        -- Functions
                        ["af"] = { query = "@function.outer", desc = "Select outer part of a function definition" },
                        ["if"] = { query = "@function.inner", desc = "Select inner part of a function definition" },
                        -- Classes
                        ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
                        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
                        -- Scopes
                        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                    },
                },
            },
        })
    end,
}
