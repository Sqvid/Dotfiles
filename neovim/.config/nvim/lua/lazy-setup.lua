-- Bootstrap lazy.nvim if it's not installed.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
  lazy = true,
  -- Set up all plugins in the lua/plugins directory.
  {import = "plugins"},
  {import = "plugins.lsp"},
  {import = "plugins.ui"}
})

-- Set up LSP related plugins.
require("lsp-setup")
