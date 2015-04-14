set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'spf13/vim-colors'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'

call vundle#end()
filetype plugin indent on

set hidden
set nowrap
set backspace=indent,eol,start
set autoindent
set copyindent
set number
set showmatch
set ignorecase
set smartcase
set hlsearch
set incsearch
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set softtabstop=2

set history=1000
set undolevels=1000
set title
" use leader-q to quit the search highlight
:nmap \q :nohlsearch<CR>

set mouse=a

" turn on syntax highlighting
syntax on

" quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

set t_Co=256
colorscheme molokai

" change temp edit file command
:nmap <C-e> :e#<CR>

set pastetoggle=<F2>

" ensure the powerline comes on by default versus at a split
set laststatus=2
set encoding=utf-8
let g:airline_powerline_fonts = 1
let g:airline_theme='molokai'

" configure nerd tree
map <C-n> :NERDTreeToggle<CR>
"set noesckeys
set timeout
set timeoutlen=300 
set ttimeoutlen=0

" easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

map <silent> <leader>s :set spell!<CR>
set spelllang=en_us
highlight SpellBad cterm=underline ctermfg=Red ctermbg=Black

" open help files in a vertical window
autocmd FileType help wincmd L

" show invisible characters
set list
set listchars=tab:▸\ ,eol:¬,trail:·
highlight NonText ctermbg=233 ctermfg=236
highlight SpecialKey ctermbg=233 ctermfg=236


