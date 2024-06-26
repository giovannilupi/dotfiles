-- Set leader key to space
-- This is the key that leads all user-defined keymaps 
-- vim.g is a vim global
vim.g.mapleader = " "

-- NORMAL MODE
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x')

-- keep cursor in the middle when moving or searching
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- VISUAL MODE

-- move lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")


vim.keymap.set("x", "p", [["_dP]])

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Save file with Ctrl+s
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Keybing to quit
vim.keymap.set('n', '<leader>q', ':q<CR>', { noremap = true, silent = true, desc = "Quit" })

-- Indent entire file preserving the cursor position
vim.keymap.set('n', '<leader>if', function()
    -- Save the current cursor position
    local pos = vim.fn.getpos('.')
    -- Execute the gg=G command
    vim.cmd('normal! gg=G')
    -- Restore the cursor position
    vim.fn.setpos('.', pos)
end, { noremap = true, silent = true, desc = "Indent file" })

-- Toggle diagnostics
vim.g.diagnostics_visible = true
function _G.toggle_diagnostics()
    if vim.g.diagnostics_visible then
        vim.g.diagnostics_visible = false
        vim.diagnostic.disable()
    else
        vim.g.diagnostics_visible = true
        vim.diagnostic.enable()
    end
end
vim.api.nvim_buf_set_keymap(0, 'n', '<Leader>dg', ':call v:lua.toggle_diagnostics()<CR>', {silent=true, noremap=true, desc="Toggle diagnostics", })

-- Highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
