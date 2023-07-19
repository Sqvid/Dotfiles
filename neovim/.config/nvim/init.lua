--
-- ███╗░░██╗███████╗░█████╗░██╗░░░██╗██╗███╗░░░███╗
-- ████╗░██║██╔════╝██╔══██╗██║░░░██║██║████╗░████║
-- ██╔██╗██║█████╗░░██║░░██║╚██╗░██╔╝██║██╔████╔██║
-- ██║╚████║██╔══╝░░██║░░██║░╚████╔╝░██║██║╚██╔╝██║
-- ██║░╚███║███████╗╚█████╔╝░░╚██╔╝░░██║██║░╚═╝░██║
-- ╚═╝░░╚══╝╚══════╝░╚════╝░░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝
--

-- Lua-interface helpers
local opt = vim.opt
local map = vim.keymap.set
local func = vim.fn
local cmd = vim.cmd
local api = vim.api
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

--------------------------------------------------------------------------------
-- Vim-Plug:
local Plug = func["plug#"]

func["plug#begin"]("~/.local/share/nvim/plugged")

-- A light and configurable statusline plugin
Plug("itchyny/lightline.vim")

-- Insert or delete brackets, parenthesis, quotes in pairs.
Plug("jiangmiao/auto-pairs")

-- Extension and language-server host for Neovim.
Plug("neoclide/coc.nvim", {branch = "release"})

-- A modern filetype plugin for LaTeX.
Plug("lervag/vimtex")

-- Tokyo Night colourscheme.
Plug("folke/tokyonight.nvim", {branch = "main"})

func["plug#end"]()

-- Plugin configurations:
-- Airline
--let g:airline#extensions#tabline#enabled = 1
--let g:airline#extensions#whitespace#mixed_indent_algo = 1
--let g:airline_powerline_fonts = 1
--let g:airline_theme = "tokyonight"

-- Lightline
vim.g.lightline = {colorscheme = "tokyonight"}

-- CoC Intellisense
local cocMapOpts = {
	silent = true,
	noremap = true,
	expr = true,
	replace_keycodes = false
}
-- Use <Tab> to cycle completions.
map("i", "<Tab>", [[coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<Tab>" : coc#refresh()]], cocMapOpts)
map("i", "<S-Tab>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], cocMapOpts)
-- Use <CR> to confirm completion.
map("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], cocMapOpts)

-- VimTeX
vim.g.vimtex_view_method = "sioyek"


--------------------------------------------------------------------------------
-- Settings:
-- Highlight the row the cursor is currently on.
opt.cursorline = true
-- Ignore case when searching.
opt.ignorecase = true
-- Don't ignore case if search contains capitals.
opt.smartcase = true
-- Wrap when jumping through search results.
opt.wrapscan = false
-- Show line numbers.
opt.number = true
-- Set relative line number.
opt.relativenumber = true
-- Keep the lines above and below the cursor.
opt.scrolloff = 1
-- Draw a signcolumn.
opt.signcolumn = "yes"
-- Set terminal colours.
opt.termguicolors = true
-- Timeout between mapped key sequence presses.
opt.timeoutlen = 200
-- Sets coloured bar as a text-width guide.
opt.colorcolumn = "81"
-- Text-wrapping width.
opt.textwidth = 80
-- Set tab width.
opt.tabstop = 4
-- Set width for indention shifts.
opt.shiftwidth = 4
-- Show current mode on the last line.
opt.showmode = false
-- Where to draw the statusline.
opt.laststatus = 3

-- Add OCaml indent tool to runtimepath
opt.runtimepath:prepend("~/.opam/cs3110-2023sp/share/ocp-indent/vim")

cmd("colorscheme tokyonight-night")

cmd("filetype plugin on")

-- Jump to the last visited position in the file.
augroup("jumpLastPosition", {clear = true})
autocmd({"BufReadPost"}, {
	group = "jumpLastPosition",
	callback =
	function()
		local ft = vim.opt_local.filetype:get()
		-- don"t apply to git messages
		if (ft:match("commit") or ft:match("rebase")) then
			return
		end
		-- get position of last saved edit
		local markpos = api.nvim_buf_get_mark(0, '"')
		local line = markpos[1]
		local col = markpos[2]
		-- if in range, go there
		if (line > 1) and (line <= api.nvim_buf_line_count(0)) then
			api.nvim_win_set_cursor(0, {line,col})
		end
	end
})

-- Load templates based on file extensions.
augroup("templates", {clear = true})
autocmd("BufNewFile", {
	group = "templates",
	command = [[silent! execute '0r ~/.config/nvim/templates/template.'.expand("<afile>:e")]]
})
autocmd("BufNewFile", {
	group = "templates",
	pattern = "makefile",
	command = "silent! 0r ~/.config/nvim/templates/template.makefile"
})

-- Delete trailing whitespace before saving.
augroup("deleteTrailingSpace", {clear = true})
autocmd("BufWritePre", {
	group = "deleteTrailingSpace",
	callback =
	function()
		local view = func.winsaveview()
		cmd([[silent! %s/\s\+$//g]])
		func.winrestview(view)
	end,
	desc = "Delete trailing whitespace before saving"
})

--------------------------------------------------------------------------------
-- Mappings:
vim.g.mapleader = " "
vim.g.maplocalleader = "-"

-- Normal-mode mappings:
local mapOpts = {silent = true}
map("n", "<F9>", ":setlocal spell!<CR>", mapOpts)
map("n", "<Esc><Esc>", ':noh<CR>:let @/="ldsfl2393rj0mash02enp3irdsfc"<CR>', mapOpts)
map("n", "daa", "ggdG", mapOpts)
map("n", "zt", "zt2<C-Y>", mapOpts)
map("n", "zb", "zb2<C-E>", mapOpts)
-- Fold around a code-block.
map("n", "<Leader>ff", "zfaB", mapOpts)
map("n", "<Leader>p", "gwap", mapOpts)
map("n", "K", ":Man<CR>", mapOpts)
map("n", "gb", "gT", mapOpts)
map("n", "<C-t>", ":Texplore<CR>", mapOpts)

-- Insert-mode mappings
map("i", ",,", "<Esc>", mapOpts)

-- Plugin specific bindings:
-- CoC Mappings Stolen from neoclide/coc.nvim/README.md
-- Use `[g` and `]g` to navigate diagnostics
map("n", "[g", "<Plug>(coc-diagnostic-prev)", mapOpts)
map("n", "]g", "<Plug>(coc-diagnostic-next)", mapOpts)

-- Go-to code navigation. Use <C-o> to go back through the stack.
map("n", "gd", "<Plug>(coc-definition)", mapOpts)
map("n", "gy", "<Plug>(coc-type-definition)", mapOpts)
map("n", "gi", "<Plug>(coc-implementation)", mapOpts)
map("n", "gr", "<Plug>(coc-references)", mapOpts)

-- Rename a symbol.
map("n", "<leader>rn", "<Plug>(coc-rename)", mapOpts)

-- Apply AutoFix to problem on the current line.
map("n", "<leader>qf", "<Plug>(coc-fix-current)", {silent = true, nowait = true})

-- Use KK to show documentation in preview window.
function _G.show_docs()
	local cw = func.expand("<cword>")
	if func.index({"vim", "help"}, vim.bo.filetype) >= 0 then
		api.nvim_command("h " .. cw)
	elseif api.nvim_eval("coc#rpc#ready()") then
		func.CocActionAsync("doHover")
	else
		api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
	end
end
map("n", "KK", ":lua _G.show_docs()<CR>", mapOpts)

augroup("cocGolang", {clear = true})
autocmd("BufWritePre", {
	group = "cocGolang",
	pattern = "go",
	command = 'silent! call CocAction("runCommand", "editor.action.organizeImport")',
	desc = "Organise imported Go modules"
})
