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

require('plugins.nvim-lspconfig.mappings')
