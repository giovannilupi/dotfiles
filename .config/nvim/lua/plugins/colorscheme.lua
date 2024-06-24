return {
    -- Gruvbox colorscheme
    "ellisonleao/gruvbox.nvim",
    -- Force lazy.nvim to load this plugin first
    priority = 1000,
    -- Configuration callback
    -- This is guaranteed to execute after lazy has loaded the plugin
    config = function()
        -- Transparency is disabled by default
        require("gruvbox").setup({ transparent_mode = true })
        -- vim.cmd executes Vim commands
        vim.cmd("colorscheme gruvbox")
    end,
}
