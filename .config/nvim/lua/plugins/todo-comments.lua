return {
    -- Highlight comments starting with KEYWORD:
    "folke/todo-comments.nvim",
    event = 'VimEnter',
    dependencies = { "nvim-lua/plenary.nvim" },
    -- Do not display icons in the sign column
    opts = { signs = false, }
}
