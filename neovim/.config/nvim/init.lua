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
local opt = vim.opt
local cmd = vim.cmd

opt.cursorline = true
opt.ignorecase = true
opt.smartcase = true
opt.wrapscan = false
opt.number = true
opt.relativenumber = true
opt.scrolloff = 1
opt.signcolumn = "yes"
opt.termguicolors = true
opt.timeoutlen = 300
opt.colorcolumn = "81"
opt.textwidth = 80
opt.tabstop = 4
opt.shiftwidth = 4
opt.showmode = false
opt.laststatus = 3
opt.spelllang = "en_gb"
opt.hidden = true
opt.mouse = "v"
-- Add OCaml indent tool to runtimepath
opt.runtimepath:prepend("~/.opam/cs3110-2023sp/share/ocp-indent/vim")

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
