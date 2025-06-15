local map = vim.keymap.set

-- Enable LSPs.
vim.lsp.enable("clangd")
vim.lsp.enable("gopls")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("emmet_ls")
vim.lsp.enable("jedi_language_server")
vim.lsp.enable("ocamllsp")

require("lint").linters_by_ft = {
  cpp = {"clang-tidy", "cpplint"},
}

-- LSP keybindings.
-- Use the LspAttach autocommand to only map the following keys after the
-- language server attaches to the current buffer.
vim.api.nvim_create_autocmd("LspAttach", { group =
  vim.api.nvim_create_augroup("UserLspConfig", {}), callback = function(ev)
    local opts = { buffer = ev.buf }
    map("n", "<Leader>e", vim.diagnostic.open_float)
    map("n", "[d", vim.diagnostic.goto_prev)
    map("n", "]d", vim.diagnostic.goto_next)
    map("n", "gD", vim.lsp.buf.declaration, opts)
    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "K", vim.lsp.buf.hover, opts)
    map("n", "gi", vim.lsp.buf.implementation, opts)
    map("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    map("n", "<Leader>D", vim.lsp.buf.type_definition, opts)
    map("n", "<Leader>rn", vim.lsp.buf.rename, opts)
    map("n", "gr", vim.lsp.buf.references, opts)
    map("n", "<Leader>qf", vim.lsp.buf.code_action, opts)
  end
})
