-- Interface to the tree-sitter incremental parsing library.
return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  opts = {
  indent = { enable = true },
  ensure_installed = {
    "c",
    "cpp",
    "go",
    "python",
    "lua",
    "ocaml",
  },
  }
}
