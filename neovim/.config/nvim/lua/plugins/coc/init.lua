-- Extension and language-server host for Neovim.
require("plugins.coc.mappings")
require("plugins.coc.autocmds")

return {
	"neoclide/coc.nvim",
	branch = "release"
}
