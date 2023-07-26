local map = vim.keymap.set

local cocMapOpts = {
	silent = true,
	noremap = true,
	expr = true,
	replace_keycodes = false
}

-- Use <Tab> to cycle completions.
function _G.check_back_space()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end
map("i", "<Tab>", [[coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<Tab>" : coc#refresh()]], cocMapOpts)
map("i", "<S-Tab>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], cocMapOpts)
-- Use <CR> to confirm completion.
map("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], cocMapOpts)

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
	local cw = vim.fn.expand("<cword>")
	if vim.fn.index({"vim", "help"}, vim.bo.filetype) >= 0 then
		vim.api.nvim_command("h " .. cw)
	elseif vim.api.nvim_eval("coc#rpc#ready()") then
		vim.fn.CocActionAsync("doHover")
	else
		vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
	end
end
map("n", "KK", ":lua _G.show_docs()<CR>", mapOpts)
