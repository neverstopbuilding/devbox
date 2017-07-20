set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'spf13/vim-colors'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-bufferline'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'SirVer/ultisnips'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-ruby/vim-ruby'
Plugin 'mattn/emmet-vim'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-surround'

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

" enable the matchit plugin
runtime macros/matchit.vim

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
set spellfile=/vagrant/dotfiles/.vim-spell-en.utf-8.add
set spelllang=en_us
highlight SpellBad cterm=underline ctermfg=Red ctermbg=Black
highlight SpellCap cterm=underline ctermfg=51 ctermbg=Black
" open help files in a vertical window
autocmd FileType help wincmd L

" show invisible characters
set list
set listchars=tab:▸\ ,eol:¬,trail:·
highlight NonText ctermbg=233 ctermfg=236
highlight SpecialKey ctermbg=233 ctermfg=236

" highlight match charactars slightly differently
highlight MatchParen cterm=bold ctermbg=237 ctermfg=208

" Automatically wrap at 80 characters for Markdown
" autocmd BufRead,BufNewFile *.md,*.markdown setlocal textwidth=80
autocmd filetype markdown set nolist
set wrap
set linebreak
"set textwidth=80
" turn this back on for specific source code types or even the below which would
" be more helpful
" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%81v.\+/
" set colorcolumn=+1

" bufferline statusline configuration
let g:bufferline_echo = 0

set splitbelow
set splitright

" disable folding for markdown plugin
let g:vim_markdown_folding_disabled=1

" this will strip any trailing white space on save
autocmd BufWritePre * :%s/\s\+$//e

" set the snippets directory to the source controlled vagrant root
let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

inoremap <C-e> <C-o>A

set clipboard=unnamed
map <leader>yy "*yy
map <leader>y "*y

" syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

augroup filetypedetect
    au! BufRead,BufNewFile *_spec.rb    set filetype=ruby.rspec
augroup END
