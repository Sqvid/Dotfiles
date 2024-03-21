return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      go = {"gofumpt"}
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      async = true
    }
  }
}
