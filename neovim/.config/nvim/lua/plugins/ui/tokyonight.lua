-- Tokyo Night colourscheme.
return {
  "folke/tokyonight.nvim",
  priority = 1000,

  opts = {
    style = "night",

    on_highlights =
      function(highlights, colors)
        highlights.IncSearch = {
          bg = colors.magenta,
          fg = colors.black
        }
      end
  }
}
