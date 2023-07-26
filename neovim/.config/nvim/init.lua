--
-- ███╗░░██╗███████╗░█████╗░██╗░░░██╗██╗███╗░░░███╗
-- ████╗░██║██╔════╝██╔══██╗██║░░░██║██║████╗░████║
-- ██╔██╗██║█████╗░░██║░░██║╚██╗░██╔╝██║██╔████╔██║
-- ██║╚████║██╔══╝░░██║░░██║░╚████╔╝░██║██║╚██╔╝██║
-- ██║░╚███║███████╗╚█████╔╝░░╚██╔╝░░██║██║░╚═╝░██║
-- ╚═╝░░╚══╝╚══════╝░╚════╝░░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝
--

--------------------------------------------------------------------------------
-- Leader keys need to be set before lazy.nvim is loaded.
vim.keymap.set({"n", "v"}, "<Space>", "<Nop>", {silent = true})
vim.g.mapleader = " "
vim.g.maplocalleader = "-"

-- Lazy.nvim plugin manager:
require("lazy-setup")

--------------------------------------------------------------------------------
-- Settings:
require("options")
require("mappings")
require("autocmds")
