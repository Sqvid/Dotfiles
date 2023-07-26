local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup("cocGolang", {clear = true})
autocmd("BufWritePre", {
	group = "cocGolang",
	pattern = "go",
	command = [[silent! call CocAction("runCommand", "editor.action.organizeImport")]],
	desc = "Organise imported Go modules"
})
