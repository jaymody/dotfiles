set number
set hlsearch
set incsearch
set ignorecase
set smartcase
set cursorline
set nowrap
set confirm
set showmatch
set termguicolors
set wildmenu
set hidden
set clipboard^=unnamed,unnamedplus

" insert mode vertical bar
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" filetype plugin indent on
colorscheme habamax
syntax on

inoremap <C-c> <Esc>
vnoremap <C-c> <Esc>
nnoremap <C-c> :noh<CR><Esc>
vnoremap p "_dP

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
