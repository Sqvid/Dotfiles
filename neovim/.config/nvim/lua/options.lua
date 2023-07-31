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
opt.mouse = "nv"
-- Add OCaml indent tool to runtimepath
opt.runtimepath:prepend("~/.opam/cs3110-2023sp/share/ocp-indent/vim")

cmd("colorscheme tokyonight")

cmd("filetype plugin on")
