-- Bootstrap lazy.nvim
-- vim.fn allows us to access vimscript functions in lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazyrepo = "https://github.com/folke/lazy.nvim.git"
-- If the lazy.nvim directory does not exist, git clone lazy.nvim
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", lazyrepo, "--branch=stable", lazypath, })
end
-- Prepend the lazy.nvim directory to the runtime path
-- This syntax is a shorthand for vim.opt.rtp.prepend(vim.opt.rtp, lazypath)
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
-- The require call looks for the lazy directory in the runtime path
-- It finds the directory under lazy.nvim/lua/lazy and run its init.lua
-- We then call the setup function from lazy providing a list of plugins to load
-- Each plugin is specified as a table containing its name and configuration
require("lazy").setup("plugins")
