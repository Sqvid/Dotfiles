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

" CoC Intellisense Engine.
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Go language support.
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}

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
set viminfo='20,\"50	" Read/write a .viminfo file, don't store more
			" than 50 lines of registers.
set history=200		" Keep 50 lines of command line history.
set number		" Show line numbers.
set updatetime=950	" Time to update .swp file.
set colorcolumn=81	" Sets coloured bar at 80 characters as a guide.
set tw=80		" Text wrapping at 79 characters.
set termguicolors 	" Set terminal colours.
set scrolloff=1 	" Keep the lines above and below the cursor.
set ignorecase		" Ignore case when searching.
set smartcase		" Don't ignore case if search contains capitals.
set inccommand=nosplit 	" Live feedback during substitution.
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
	autocmd BufNewFile *.* silent! execute '0r ~/.config/nvim/templates/skeleton.'.expand("<afile>:e")
	autocmd BufNewFile [Mm]akefile silent! 0r ~/.config/nvim/templates/skeleton.makefile
augroup END

"******************************************************************************
" Mappings:
" Set the leader key to be the spacebar.
let mapleader = " "

" Normal mode mappings:
nnoremap <silent> <C-l> :LLPStartPreview <CR>
nnoremap <silent> <F9> :setlocal spell! spelllang=en_gb <CR>
nnoremap <silent> <Esc><Esc> :noh<CR>:let @/="ldsfl2393rj0mash02enp3irdsfc"<CR>
nnoremap <silent> daa ggdG
nnoremap <silent> zt zt2<C-Y>
nnoremap <silent> zb zb2<C-E>
nnoremap <silent> <C-j> /<++><CR>:noh<CR>ca<
nnoremap <silent> <Leader>ff zfaB
nnoremap <silent> <Leader>p gqap
nnoremap <silent> K :Man<CR>

" Insert mode mappings:
inoremap <silent> <C-j> <Esc>/<++><CR>:noh<CR>ca<
