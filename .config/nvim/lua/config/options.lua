-- Interface for interacting with vimscript options table in lua
local opt = vim.opt

-- line numbers
opt.number = true  -- print the line number in front of each line
opt.relativenumber = true  -- show relative line numbers

-- tabs
opt.tabstop = 4  -- number of spaces that a <Tab> in the file counts for (default 8)
opt.shiftwidth = 4  -- number of spaces for each indent
opt.softtabstop = 4  -- number of spaces that a <Tab> counts for while performing editing
opt.expandtab = true  -- expand tab to spaces

-- indentation
opt.autoindent = true  -- copy indent from current line when starting new one (default true)
opt.smartindent = true  -- do smart autoindenting when starting a new line

-- search settings
opt.ignorecase = true  -- ignore case when searching
opt.smartcase = true  -- if you include mixed case in your search, assumes you want case-sensitive
opt.hlsearch = true  -- highlight all matches on previous search pattern
opt.incsearch = true  -- highlight matched string while typing
opt.grepprg = "rg --vimgrep"

-- completions
opt.completeopt = "menu,menuone,noselect"  -- popup menu and force the user to select an option from the menu

-- undo
opt.undofile = true  -- save undo history to file, so it persists between nvim sessions
opt.undolevels = 10000  -- maximum number of changes that can be undone

-- popup menu
opt.pumheight = 10  -- limits pop up menu height (all screen is used otherwise)

-- clipboard
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"  -- sync with system clipboard if not in ssh (nvim >= 0.10.0)

-- mouse
opt.mouse = "a"  -- allow the mouse to be used in all modes

-- appearance
opt.wrap = false  -- line wrapping
opt.cursorline = false  -- highlight the current line
opt.termguicolors = true  -- enable RGB color in the TUI
opt.background = "dark"   -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes"  -- always draw sign column
opt.scrolloff = 999  -- keep the cursor in the middle of the screen when scrolling verticalg
opt.sidescrolloff = 8  -- columns of context

-- split windows
opt.splitright = true  -- split vertical window to the right
opt.splitbelow = true  -- split horizontal window to the bottom

-- miscellaneous
opt.updatetime = 250  -- speeds up swap file write to disk and completion
opt.backup = false  -- disbale backup creation before overwriting a file
opt.swapfile = false  -- use a swapfile for the buffer
opt.isfname:append("@-@")  -- add support for @ character in file names
opt.laststatus = 3  -- global statusline
opt.showmode = false -- don't show mode since we have a statusline
opt.virtualedit = "block"  -- allow cursor to move where there is no text in visual block mode
opt.spelllang = { "en" }  -- set spell languages
