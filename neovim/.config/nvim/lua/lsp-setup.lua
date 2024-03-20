local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

local default_lsp_setup = function(server)
	require("lspconfig")[server].setup({
		capabilities = lsp_capabilities
	})
end

local lspconfig = require("lspconfig")

-- Setup language servers.
lspconfig.clangd.setup {}
lspconfig.gopls.setup {}

require("mason").setup()
require('mason-lspconfig').setup({
	handlers = { default_lsp_setup }
})

vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

-- Use LspAttach autocommand to only map the following keys after the language
-- server attaches to the current buffer.
vim.api.nvim_create_autocmd("LspAttach", { group =
	vim.api.nvim_create_augroup("UserLspConfig", {}), callback = function(ev)
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<Leader>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<Leader>f", function()
			vim.lsp.buf.format { async = true }
		end, opts)
	end,
})

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require("cmp")

cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" }
	},
	mapping = cmp.mapping.preset.insert({
		-- Enter key confirms completion item.
		["<CR>"] = cmp.mapping(function(fallback)
			-- This little snippet will confirm with <CR>, and if no entry is
			-- selected, will confirm the first item.
			if cmp.visible() then
				local entry = cmp.get_selected_entry()
				if not entry then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				end
				cmp.confirm()
			else
				fallback()
			end
			end, {"i","s","c",}),

		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
			end, { "i", "s" }),

		-- Ctrl + space triggers completion menu.
		["<C-Space>"] = cmp.mapping.complete(),
	}),
})
