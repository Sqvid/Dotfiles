"******************************************************************************
" Settings:
set nocompatible        " Use Vim defaults (much better!)
set bs=indent,eol,start " Allow backspacing over everything in insert mode
set ai                  " Always set autoindenting on
set viminfo='20,\"50    " Read/write a .viminfo file, don't store more
                        " Than 50 lines of registers
set history=50          " Keep 50 lines of command line history
set ruler               " Show the cursor position all the time
set number              " Show line numbers
set colorcolumn=81      " Sets coloured bar at 81 characters as a guide
set tw=80               " Text wrapping at 80 characters
set wildmenu            " Command completion menu
set incsearch           " Start searching before hitting enter
set scrolloff=1         " Keep the lines above and below the cursor
set ignorecase          " Ignore case when searching
set smartcase           " Don't ignore case if search contains capitals
set showcmd             " Show keystrokes

filetype plugin on

"******************************************************************************
" Mappings:
let mapleader = " "

nnoremap <silent> <Leader>s :setlocal spell! spelllang=en_gb <CR>
nnoremap <silent> <Esc><Esc> :noh<CR>:let @/="ldsfl2393rj0mash02enp3irnddsfc"<CR>
