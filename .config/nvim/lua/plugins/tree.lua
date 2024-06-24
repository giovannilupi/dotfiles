return {
    "nvim-tree/nvim-tree.lua",
    version = '*',
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        -- Disable netrw at startup (recommended)
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- Height and width for floating window
        local HEIGHT_RATIO = 0.7
        local WIDTH_RATIO = 0.7
        require('nvim-tree').setup({
            -- Show files ignored by git
            git = { ignore = false, },
            view = {
                -- Show relative number lines
                relativenumber = true,
                -- Show file tree as floating window
                float = {
                    enable = true,
                    open_win_config = function()
                        local screen_w = vim.opt.columns:get()
                        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                        local window_w = screen_w * WIDTH_RATIO
                        local window_h = screen_h * HEIGHT_RATIO
                        local window_w_int = math.floor(window_w)
                        local window_h_int = math.floor(window_h)
                        local center_x = (screen_w - window_w) / 2
                        local center_y = ((vim.opt.lines:get() - window_h) / 2)
                        - vim.opt.cmdheight:get()
                        return {
                            border = 'rounded',
                            relative = 'editor',
                            row = center_y,
                            col = center_x,
                            width = window_w_int,
                            height = window_h_int,
                        }
                    end,
                },
                width = function()
                    return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
                end,
            },
        })

        -- Global mappings
        vim.api.nvim_set_keymap("n", "<leader>ee", ":NvimTreeFindFileToggle<CR>", {silent = true, noremap = true, desc = "Toggle file explorer" })
    end,
}
