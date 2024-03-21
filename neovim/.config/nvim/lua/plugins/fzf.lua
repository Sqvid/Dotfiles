-- fzf wrapper plugin.
-- Replace :buffers mapping if fzf plugin is available.
local mapOpts = {silent = true}

vim.g.fzf_preview_window = "up,50%"
vim.keymap.set("n", "<Leader>b", ":Buffers<CR>", mapOpts)
vim.keymap.set("n", "<Leader>o", ":Files<CR>", mapOpts)

return {
  "junegunn/fzf.vim"
}
