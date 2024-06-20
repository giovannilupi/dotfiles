return {
	"nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
    	local lualine = require("lualine")
    	lualine.setup({
    		sections = {
				-- Change the Tux icon to the string unix for representing the type of line ending (LF or CRLF)
				lualine_x = { "encoding", { "fileformat", symbols = { unix = "unix" } }, "filetype" },
			},
    		options = {
    			theme = 'gruvbox',
    		},
    	})
    end,
}