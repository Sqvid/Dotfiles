"******************************************************************************
" Vim-Plug

" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
"Examples:
"
" Make sure you use single quotes
" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
"Plug 'junegunn/vim-easy-align'
" Any valid git URL is allowed
"Plug 'https://github.com/junegunn/vim-github-dashboard.git'
" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'
"
" Plugins go here:
"
"
" A Vim Plugin for Lively Previewing LaTeX PDF Output
 Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

" A Vim motions on speed
"Plug 'https://github.com/easymotion/vim-easymotion'

" Status bar plugin
 Plug 'vim-airline/vim-airline'

" Supertab: autocomplete
 Plug 'https://github.com/ervandew/supertab'

" NERDTree file system explorer
 Plug 'https://github.com/scrooloose/nerdtree.git'

" Goyo: Distraction-free writing
 Plug 'junegunn/goyo.vim'

call plug#end()


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
set t_Co=256 		" Set terminal colours
set wildmenu 		" Command completion menu
set incsearch 		" Start searching before hitting enter
set scrolloff=1 	" Keep the lines above and below the cursor
set ignorecase		" Ignore case when searching
set smartcase		" Don't ignore case if search contains capitals
set showcmd		" Show keystrokes


"******************************************************************************
" Mappings:
let mapleader = " "

nnoremap <silent> <C-l> :LLPStartPreview <CR>
nnoremap <silent> <F9> :setlocal spell! spelllang=en_gb <CR>
nnoremap <silent> <Esc><Esc> :noh<CR>:let @/="ldsfl2393rj0mash02enp3irnddsfc"<CR>
nnoremap <silent> <C-n> :NERDTree <CR>
nnoremap <silent> <C-]> <C-]>zt
nnoremap <silent> daa ggdG
nnoremap <silent> zt zt2<C-Y>
nnoremap <silent> zb zb2<C-E>


" Plugin configurations:
"
" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" LaTeX live preview
let g:livepreview_previewer = 'zathura'


"******************************************************************************
" The Rest:
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

filetype plugin on

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup fedora
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add $PWD/cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif
