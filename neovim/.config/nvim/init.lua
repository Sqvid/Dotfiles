--
-- ███╗  ██╗███████╗ █████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗ ██║██╔════╝██╔══██╗██║   ██║██║████╗ ████║
-- ██╔██╗██║█████╗  ██║  ██║╚██╗ ██╔╝██║██╔████╔██║
-- ██║╚████║██╔══╝  ██║  ██║ ╚████╔╝ ██║██║╚██╔╝██║
-- ██║ ╚███║███████╗╚█████╔╝  ╚██╔╝  ██║██║ ╚═╝ ██║
-- ╚═╝  ╚══╝╚══════╝ ╚════╝    ╚═╝   ╚═╝╚═╝     ╚═╝
--

-- Basics
require("options")
require("mappings")
require("autocmds")

-- Plugin manager
require("lazy-setup")

-- Miscellaneous
vim.cmd("colorscheme tokyonight")
vim.cmd("filetype plugin on")
