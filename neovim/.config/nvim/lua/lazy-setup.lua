-- Bootstrap lazy.nvim if it's not installed.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath
  }
end
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
