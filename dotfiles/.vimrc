set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'spf13/vim-colors'
Plugin 'blong/vim-airline'

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

set smarttab
set shiftwidth=2
set tabstop=2

set history=1000
set undolevels=1000
set title

" use leader-q to quit the search highlight
:nmap \q :nohlsearch<CR>

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
