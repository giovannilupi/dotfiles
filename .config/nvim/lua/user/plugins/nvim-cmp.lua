return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
    	"hrsh7th/cmp-buffer",
    	"hrsh7th/cmp-path",
    	{
        	'L3MON4D3/LuaSnip',
        	build = 'make install_jsregexp'
    	},
    	"saadparwaiz1/cmp_luasnip",
    	"rafamadriz/friendly-snippets",
    	"onsails/lspkind.nvim",
    },
    config = function()
   		local cmp = require("cmp")
   		local luasnip = require("luasnip")
   		local lspkind = require("lspkind")
   		require('luasnip.loaders.from_vscode').lazy_load()

   		cmp.setup ({
   			completion = { completeopt = 'menu,menuone,noinsert' },
   			snippet = {
          		expand = function(args)
            		luasnip.lsp_expand(args.body)
          		end,
        	},
       		mapping = cmp.mapping.preset.insert({
        		["<C-n>"] = cmp.mapping.select_next_item(),
        		["<C-p>"] = cmp.mapping.select_prev_item(),
        		["<C-b>"] = cmp.mapping.scroll_docs(-4),
            	["<C-f>"] = cmp.mapping.scroll_docs(4),
            	["<C-t>"] = cmp.mapping.complete(),
            	["<C-e>"] = cmp.mapping.abort(),
            	["<CR>"] = cmp.mapping.confirm(),
        	}),
       		sources = cmp.config.sources({
        		{ name = "luasnip" },
        		{ name = "buffer" },
        		{ name = "path" },
        	}),
    		formatting = {
    			format = lspkind.cmp_format(),
    		},
   		})
   	end,
}