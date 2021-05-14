"******************************************************************************
" Vim-Plug:

call plug#begin('~/.local/share/nvim/plugged')

" Live LaTeX preview.
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

" Status bar plugin.
Plug 'vim-airline/vim-airline'

" Tab powered autocomplete autocomplete.
Plug 'ervandew/supertab'

" NERDTree file system explorer.
Plug 'scrooloose/nerdtree'

" Distraction-free writing.
Plug 'junegunn/goyo.vim'

" Vim wrapper for fzf.
Plug 'junegunn/fzf.vim'

" Nightfly colourscheme.
Plug 'bluz71/vim-nightfly-guicolors'

" CoC Intellisense Engine.
Plug 'neoclide/coc.nvim', {'branch': 'release'}


call plug#end()

" Plugin configurations:
" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" LaTeX live preview
let g:livepreview_previewer = 'zathura'

" CoC Intellisense
" Use <c-space> to trigger completion.
inoremap <silent><expr> <C-Space> coc#refresh()

" SuperTab
" Reverse default navigation direction.
let g:SuperTabDefaultCompletionType = "<C-n>"

"******************************************************************************
" Settings:
set viminfo='20,\"50	" Read/write a .viminfo file, don't store more
			" than 50 lines of registers.
set history=200		" Keep 50 lines of command line history.
set number		" Show line numbers.
set relativenumber      " Show relative line numbers.
set updatetime=950	" Time to update .swp file.
set colorcolumn=80	" Sets coloured bar at 80 characters as a guide.
set tw=79		" Text wrapping at 79 characters.
set termguicolors 	" Set terminal colours.
set scrolloff=1 	" Keep the lines above and below the cursor.
set ignorecase		" Ignore case when searching.
set smartcase		" Don't ignore case if search contains capitals.
set inccommand=nosplit 	" Live feedback during substitution.
set nowrapscan		" Don't wrap when jumping through search results.

colorscheme nightfly

filetype plugin on

" Jump to the last visited position in the file.
autocmd BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") 
	\ && &ft !~# 'commit' |   exe "normal! g`\"" | endif

"******************************************************************************
" Mappings:
" Set the leader key to be the spacebar.
let mapleader = " "

" Normal mode mappings:
nnoremap <silent> <C-l> :LLPStartPreview <CR>
nnoremap <silent> <F9> :setlocal spell! spelllang=en_gb <CR>
nnoremap <silent> <Esc><Esc> :noh<CR>:let @/="ldsfl2393rj0mash02enp3irdsfc"<CR>
nnoremap <silent> <C-n> :NERDTree <CR>
nnoremap <silent> daa ggdG
nnoremap <silent> zt zt2<C-Y>
nnoremap <silent> zb zb2<C-E>
nnoremap <silent> <C-j> /<++><CR>:noh<CR>ca<
nnoremap <silent> <Leader>ff zfaB
nnoremap <silent> K :Man<CR>

" Insert mode mappings:
inoremap <silent> <C-j> <Esc>/<++><CR>:noh<CR>ca<
