--
-- ███╗  ██╗███████╗ █████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗ ██║██╔════╝██╔══██╗██║   ██║██║████╗ ████║
-- ██╔██╗██║█████╗  ██║  ██║╚██╗ ██╔╝██║██╔████╔██║
-- ██║╚████║██╔══╝  ██║  ██║ ╚████╔╝ ██║██║╚██╔╝██║
-- ██║ ╚███║███████╗╚█████╔╝  ╚██╔╝  ██║██║ ╚═╝ ██║
-- ╚═╝  ╚══╝╚══════╝ ╚════╝    ╚═╝   ╚═╝╚═╝     ╚═╝
--

--------------------------------------------------------------------------------
-- Plugin Manager:
-- Leader keys need to be set before lazy.nvim is loaded.
vim.keymap.set({"n", "v"}, "<Space>", "<Nop>", {silent = true})
vim.g.mapleader = " "
vim.g.maplocalleader = "-"

-- Lazy.nvim plugin manager:
require("lazy-setup")

--------------------------------------------------------------------------------
-- Options:
local o = vim.o
local cmd = vim.cmd

o.colorcolumn = "81"
o.cursorline = true
o.hidden = true
o.ignorecase = true
o.laststatus = 3
o.mouse = "v"
o.number = true
o.relativenumber = true
o.scrolloff = 1
o.shiftwidth = 4
o.showmode = false
o.signcolumn = "yes"
o.smartcase = true
o.spelllang = "en_gb"
o.tabstop = 4
o.termguicolors = true
o.textwidth = 80
o.timeoutlen = 300
o.wrapscan = false

cmd("colorscheme tokyonight")

cmd("filetype plugin on")
--------------------------------------------------------------------------------
-- Mappings:
local map = vim.keymap.set
local mapOpts = {silent = true}

-- Normal-mode mappings:
map("n", "<Leader>s", ":setlocal spell!<CR>", mapOpts)
map("n", "<Esc><Esc>", ':noh<CR>:let @/="ldsfl2393rj0mash02enp3irdsfc"<CR>', mapOpts)
map("n", "daa", "ggdG", mapOpts)
map("n", "zt", "zt2<C-Y>", mapOpts)
map("n", "zb", "zb2<C-E>", mapOpts)
-- Fold around a code-block.
map("n", "<Leader>p", "gwap", mapOpts)
map("n", "K", ":Man<CR>", mapOpts)
map("n", "gb", "gT", mapOpts)
map("n", "<C-t>", ":Texplore<CR>", mapOpts)
map("n", "[b", ":bprevious<CR>", mapOpts)
map("n", "]b", ":bnext<CR>", mapOpts)

-- Insert-mode mappings
map("i", ",,", "<Esc>", mapOpts)

--------------------------------------------------------------------------------
-- Autocommands:
require("autocmds")
