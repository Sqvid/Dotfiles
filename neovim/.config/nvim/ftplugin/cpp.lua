local map = vim.keymap.set

-- :ClangdSwitchSourceHeader is defined by the clangd profile of the
-- nvim-lspconfig plugin.
map("n", "gh", ":ClangdSwitchSourceHeader<CR>", {silent = true})
