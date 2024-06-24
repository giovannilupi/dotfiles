return {
    -- Plugin to display a status line
    "nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require("lualine").setup({
            sections = {
                -- Specify type of line ending literally instead of using symbols
                lualine_x = { "encoding", { "fileformat", symbols = { unix = "LF", dos = "CRLF", mac = "CR" } }, "filetype" },
            },
            options = { theme = 'gruvbox', },
        })
    end,
}
