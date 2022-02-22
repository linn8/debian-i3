set nu
syntax on
colorscheme darcula
nnoremap <C-n> :NERDTree<CR>
set smartindent
filetype plugin on
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle
