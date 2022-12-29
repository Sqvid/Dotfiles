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

" Extension host for Neovim. Load extensions and host language servers.
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Live LaTeX preview.
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

" Tokyo Night colourscheme.
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

call plug#end()

" Plugin configurations:
" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = "tokyonight"

" CoC Intellisense
" Use <Tab> to cycle completions.
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
" Use <CR> to confirm completion.
inoremap <expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" LaTeX live preview
let g:livepreview_previewer = 'zathura'


"******************************************************************************
" Settings:
set number		" Show line numbers.
set relativenumber	" Set relative line number.
set updatetime=950	" Time to update .swp file.
set colorcolumn=81	" Sets coloured bar as a text-width guide.
set tw=80		" Text-wrapping width.
set termguicolors 	" Set terminal colours.
set scrolloff=1 	" Keep the lines above and below the cursor.
set ignorecase		" Ignore case when searching.
set smartcase		" Don't ignore case if search contains capitals.
set nowrapscan		" Don't wrap when jumping through search results.
set autowrite		" Automatically write when calling :make
set timeoutlen=500	" Timeout between mapped key sequence presses.

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

" Normal mode mappings:
nnoremap <silent> <F9> :setlocal spell! spelllang=en_gb <CR>
nnoremap <silent> <Esc><Esc> :noh<CR>:let @/="ldsfl2393rj0mash02enp3irdsfc"<CR>
nnoremap <silent> daa ggdG
nnoremap <silent> zt zt2<C-Y>
nnoremap <silent> zb zb2<C-E>
nnoremap <silent> <Leader>ff zfaB
nnoremap <silent> <Leader>p gqap
nnoremap <silent> K :Man<CR>

" Filetype specific mappings
autocmd BufEnter *.tex nnoremap <silent> <C-l> :LLPStartPreview <CR>

"******************************************************************************
" CoC Mappings Stolen from neoclide/coc.nvim/README.md
"

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
