" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'crusoexia/vim-monokai'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'


" Initialize plugin system
call plug#end()

" colorscheme elflord
colorscheme monokai

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='powerlineish'
