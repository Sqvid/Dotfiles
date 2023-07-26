local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local cmd = vim.cmd
local func = vim.fn
local api = vim.api

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

-- Highlight yanked text for a short time.
augroup("highlightOnYank", {clear = true})
autocmd("TextYankPost", {
	group = "highlightOnYank",
	command = [[silent! lua vim.highlight.on_yank({higroup = "IncSearch", timeout = 100})]]
})

-- Track daily thesis progress.
augroup("thesisProgress", {clear = true})
local progressScript = "~/Documents/CourseWork/Cambridge/MPhilThesis/paper/progress.sh"
autocmd("BufWritePost", {
	group = "thesisProgress",
	pattern = "*/MPhilThesis/paper/**.tex",
	callback =
	function ()
		local progress = func.system(progressScript)
		cmd("redraw")
		print(progress)
	end
})
