local map = vim.keymap.set

-- :LspClangdSwitchSourceHeader is defined by the clangd profile of the
-- nvim-lspconfig plugin.
map("n", "gh", ":LspClangdSwitchSourceHeader<CR>", {silent = true})
