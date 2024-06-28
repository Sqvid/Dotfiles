-- Interface to the tree-sitter incremental parsing library.
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",

  config = function ()
    require("nvim-treesitter.configs").setup {
      ensure_installed = {
        "c",
        "cpp",
        "go",
        "python",
        "lua",
        "ocaml"
      },
      indent = { enable = false }
    }
  end
}
