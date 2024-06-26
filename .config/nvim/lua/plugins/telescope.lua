return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = 'make',
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
        { 'nvim-telescope/telescope-ui-select.nvim' },
        { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
        require('telescope').setup {
            -- Esc key exits telescope even from insert mode
            defaults = {
                mappings = {
                    i = {
                        ["<esc>"] = require("telescope.actions").close
                    },
                },
                layout_strategy="vertical",
                layout_config = {
                    vertical = {
                        width = 0.9,
                        height = 0.9,
                    },
                },
            },

            extensions = {
                ['ui-select'] = {
                    require('telescope.themes').get_dropdown(),
                },
            },
        }

        -- Enable Telescope extensions if they are installed
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')

        local builtin = require 'telescope.builtin'
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
        vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind existing [B]uffers' })

        vim.keymap.set('n', '<leader>fhf',  function()
            builtin.find_files({ hidden = true, no_ignore = true })
        end, { desc = '[F]ind [H]idden [F]iles' })

        -- Slightly advanced example of overriding default behavior and theme
        vim.keymap.set('n', '<leader>/', function()
            -- You can pass additional configuration to Telescope to change the theme, layout, etc.
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                previewer = false, layout_config = {width = 0.85, height = 0.55},
            })
        end, { desc = '[/] Fuzzily search in current buffer' })

    end,
}
