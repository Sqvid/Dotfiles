"******************************************************************************
" Vim-Plug

" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" Plugins go here:

" A Vim Plugin for Lively Previewing LaTeX PDF Output
 Plug 'https://github.com/xuhdev/vim-latex-live-preview', { 'for': 'tex' }

" Status bar plugin
 Plug 'https://github.com/vim-airline/vim-airline'

" Supertab: autocomplete
 Plug 'https://github.com/ervandew/supertab'

" NERDTree file system explorer
 Plug 'https://github.com/scrooloose/nerdtree'

" Goyo: Distraction-free writing
 Plug 'https://github.com/junegunn/goyo.vim'

" Nightfly colourscheme.
 Plug 'https://github.com/bluz71/vim-nightfly-guicolors'

call plug#end()


" Plugin configurations:
" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" LaTeX live preview
let g:livepreview_previewer = 'zathura'


"******************************************************************************
" Settings:
set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start	" Allow backspacing over everything in insert mode
set ai			" Always set autoindenting on
set viminfo='20,\"50	" Read/write a .viminfo file, don't store more
			" Than 50 lines of registers
set history=50		" Keep 50 lines of command line history
set ruler		" Show the cursor position all the time
set number		" Show line numbers
set updatetime=950	" Time to update .swp file. Used by LLP plugin
set colorcolumn=80	" Sets coloured bar at 80 characters as a guide
set tw=79		" Text wrapping at 79 characters
set background=dark	" Fixes urxvt real transparency
set termguicolors 	" Set terminal colours
set wildmenu 		" Command completion menu
set incsearch 		" Start searching before hitting enter
set scrolloff=1 	" Keep the lines above and below the cursor
set ignorecase		" Ignore case when searching
set smartcase		" Don't ignore case if search contains capitals
set showcmd		" Show keystrokes

filetype plugin on


"******************************************************************************
" Mappings:
let mapleader = " "

nnoremap <silent> <C-l> :LLPStartPreview <CR>
nnoremap <silent> <F9> :setlocal spell! spelllang=en_gb <CR>
nnoremap <silent> <Esc><Esc> :noh<CR>:let @/="ldsfl2393rj0mash02enp3irnddsfc"<CR>
nnoremap <silent> <C-n> :NERDTree <CR>
nnoremap <silent> daa ggdG
nnoremap <silent> zt zt2<C-Y>
nnoremap <silent> zb zb2<C-E>
nnoremap <silent> <C-j> /<++><CR>:noh<CR>ca<
nnoremap <silent> ciq ci"
nnoremap <silent> <Leader>ff zfaB

inoremap <silent> <C-j> <Esc>/<++><CR>:noh<CR>ca<
