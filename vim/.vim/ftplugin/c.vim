" Turn on C-style indenting support. Helpful for auto-pair mappings.
set cindent

" Provide auto-pairing for ", (, [, and {
inoremap " ""<++><Esc>4hi
inoremap ( ()<++><Esc>4hi
inoremap [ []<++><Esc>4hi
inoremap { {<Esc>o<BS>}<++><Esc>O
