"
" ███╗░░██╗███████╗░█████╗░██╗░░░██╗██╗███╗░░░███╗
" ████╗░██║██╔════╝██╔══██╗██║░░░██║██║████╗░████║
" ██╔██╗██║█████╗░░██║░░██║╚██╗░██╔╝██║██╔████╔██║
" ██║╚████║██╔══╝░░██║░░██║░╚████╔╝░██║██║╚██╔╝██║
" ██║░╚███║███████╗╚█████╔╝░░╚██╔╝░░██║██║░╚═╝░██║
" ╚═╝░░╚══╝╚══════╝░╚════╝░░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝
"

"******************************************************************************
" Vim-Plug:

call plug#begin('~/.local/share/nvim/plugged')

" Status bar plugin.
Plug 'vim-airline/vim-airline'

" Insert or delete brackets, parenthesis, quotes in pairs.
Plug 'jiangmiao/auto-pairs'

" Extension and language-server host for Neovim.
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" A modern filetype plugin for LaTeX.
Plug 'lervag/vimtex'

" Tokyo Night colourscheme.
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

call plug#end()

" Plugin configurations:
" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = "tokyonight"

" CoC Intellisense
" Use <Tab> to cycle completions.
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
" Use <CR> to confirm completion.
inoremap <expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" VimTeX
let g:vimtex_view_method = 'sioyek'


"******************************************************************************
" Settings:
set autowrite		" Automatically write when calling :make
set colorcolumn=81	" Sets coloured bar as a text-width guide.
set cursorline		" Highlight the cursor's current row.
set ignorecase		" Ignore case when searching.
set nowrapscan		" Don't wrap when jumping through search results.
set number		" Show line numbers.
set relativenumber	" Set relative line number.
set scrolloff=1 	" Keep the lines above and below the cursor.
set signcolumn=yes	" Draw a signcolumn.
set smartcase		" Don't ignore case if search contains capitals.
set termguicolors 	" Set terminal colours.
set timeoutlen=500	" Timeout between mapped key sequence presses.
set tw=80		" Text-wrapping width.
set updatetime=950	" Time to update .swp file.
set tabstop=4		" Set tab width.
set shiftwidth=4	" Set width for <, > shifts.

" Add OCaml indent tool to runtimepath
set runtimepath^="/home/siddhartha/.opam/cs3110-2023sp/share/ocp-indent/vim"

colorscheme tokyonight-night

filetype plugin on

" Jump to the last visited position in the file.
autocmd BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$")
	\ && &ft !~# 'commit' | exe "normal! g`\"" | endif

" Load templates based on file extensions.
augroup templates
	autocmd!
	autocmd BufNewFile *.* silent! execute '0r ~/.config/nvim/templates/template.'.expand("<afile>:e")
	autocmd BufNewFile [Mm]akefile silent! 0r ~/.config/nvim/templates/template.makefile
augroup END

"******************************************************************************
" Mappings:
" Set the leader key to be the spacebar.
let mapleader = " "
let maplocalleader = "-"

" Normal-mode mappings:
nnoremap <silent> <F9> :setlocal spell! spelllang=en_gb<CR>
nnoremap <silent> <Esc><Esc> :noh<CR>:let @/="ldsfl2393rj0mash02enp3irdsfc"<CR>
nnoremap <silent> daa ggdG
nnoremap <silent> zt zt2<C-Y>
nnoremap <silent> zb zb2<C-E>
" Fold around a code-block.
nnoremap <silent> <Leader>ff zfaB
nnoremap <silent> <Leader>p gqap
nnoremap <silent> K :Man<CR>
nnoremap <silent> gb gT
nnoremap <silent> <C-t> :Texplore<CR>
" Remove trailing spaces.
nnoremap <silent> <Leader>ts :%s/\s\+$//g<CR>``

" Insert-mode mappings
inoremap <silent> ,, <Esc>
inoremap <silent> <M-f> <Esc>


"******************************************************************************
" Plugin specific bindings:
" CoC Mappings Stolen from neoclide/coc.nvim/README.md

" Use `[g` and `]g` to navigate diagnostics
nnoremap <silent> [g <Plug>(coc-diagnostic-prev)
nnoremap <silent> ]g <Plug>(coc-diagnostic-next)

" Go-to code navigation. Use <C-o> to go back through the stack.
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)

" Rename a symbol.
nnoremap <silent> <leader>rn <Plug>(coc-rename)

" Apply AutoFix to problem on the current line.
nnoremap <silent> <leader>qf  <Plug>(coc-fix-current)

" Use KK to show documentation in preview window.
nnoremap <silent> KK :call ShowDocumentation()<CR>
function! ShowDocumentation()
	if CocAction('hasProvider', 'hover')
		call CocActionAsync('doHover')
	else
		call feedkeys('KK', 'in')
	endif
endfunction

augroup cocGolang
	autocmd!
	autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
augroup END
