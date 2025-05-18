return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      desc = "Format buffer",
    },
  },
  -- Everything in opts will be passed to setup()
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      c = { "clang-format" },
      cpp = { "clang-format" },
      go = { "gofumpt" },
      ocaml = { "ocamlformat" },
      python = { "black", "isort" },
    },
    -- Set up format-on-save
    format_after_save = { lsp_fallback = false },
    -- Customize formatters
    formatters = {
      ["clang-format"] = {
        prepend_args = { "--fallback-style=Google" },
      },
    },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
