return {
    "goolord/alpha-nvim",
    opts = function()
        local dashboard = require "alpha.themes.dashboard"
        require "alpha.term"
        require "math"

        dashboard.opts.opts.noautocmd = false
        dashboard.section.terminal.opts.redraw = true
        local path = "/Users/gioel/.config/nvim/lua/plugins/"

        -- Command to display the contents of o.txt
        dashboard.section.terminal.command = "cat " .. path .. "dashboard.txt"
        dashboard.section.terminal.width = 50  -- Adjust width as needed
        dashboard.section.terminal.height = 18  -- Adjust height as needed

        dashboard.leader = "␣"
        dashboard.section.buttons.val = {
            dashboard.button("n", " " .. " New file",        [[<cmd> ene <BAR> startinsert <cr>]]),
            dashboard.button("f", " " .. " Find file",       "<cmd>Telescope<CR>"),
            dashboard.button("t", "󰙅 " .. " Open tree",       "<cmd>NvimTreeOpen<CR>"),
            dashboard.button("r", " " .. " Recent"   , ":Telescope oldfiles<CR>"),
            dashboard.button("l", "󰒲 " .. " Lazy",            "<cmd> Lazy <cr>"),
            dashboard.button("q", " " .. " Quit",            "<cmd> qa <cr>"),
        }

        dashboard.opts.layout = {
            { type = "padding", val = 2 },
            dashboard.section.terminal,
            { type = "padding", val = 2 },
            dashboard.section.buttons,
            dashboard.section.footer,
        }

        return dashboard
    end,
    config = function(_, opts)
        require("alpha").setup(opts.config)

        local function setLaststatus()
            if vim.bo.filetype == "alpha" then
                if vim.opt.laststatus == 0 then return end
                vim.opt.laststatus = 0
                vim.g.neovide_scale_factor = 0.75
            else
                if vim.opt.laststatus == 3 then return end
                vim.opt.laststatus = 3
                vim.g.neovide_scale_factor = 1
            end
        end
        setLaststatus()
    end,
}
