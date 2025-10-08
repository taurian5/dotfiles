" Basic Vim Configuration

" General Settings
set nocompatible              " Use Vim defaults instead of Vi
syntax on                     " Enable syntax highlighting
filetype plugin indent on     " Enable file type detection

" UI Settings
set number                    " Show line numbers
set relativenumber            " Show relative line numbers
set showcmd                   " Show command in bottom bar
set cursorline                " Highlight current line
set wildmenu                  " Visual autocomplete for command menu
set showmatch                 " Highlight matching brackets

" Indentation
set tabstop=4                 " Number of visual spaces per TAB
set softtabstop=4             " Number of spaces in tab when editing
set shiftwidth=4              " Number of spaces for autoindent
set expandtab                 " Tabs are spaces
set autoindent                " Auto-indent new lines
set smartindent               " Smart auto-indenting

" Search
set incsearch                 " Search as characters are entered
set hlsearch                  " Highlight search matches
set ignorecase                " Case insensitive search
set smartcase                 " Case sensitive if uppercase present

" Performance
set lazyredraw                " Redraw only when needed

" Backup
set nobackup                  " No backup files
set noswapfile                " No swap files

" Key Mappings
let mapleader = ","           " Set leader key to comma
nnoremap <leader>w :w<CR>     " Quick save
nnoremap <leader>q :q<CR>     " Quick quit
nnoremap <leader><space> :nohlsearch<CR>  " Clear search highlight
