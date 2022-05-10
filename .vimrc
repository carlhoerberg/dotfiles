set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-sensible'
Plugin 'sheerun/vim-polyglot'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'airblade/vim-gitgutter'
Plugin 'itchyny/lightline.vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'dense-analysis/ale'
Plugin 'ctrlpvim/ctrlp.vim'
"Plugin 'mileszs/ack.vim'
Plugin 'lifepillar/vim-solarized8'
Plugin 'vim-crystal/vim-crystal'
Plugin 'nfnty/vim-nftables'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

let g:javascript_plugin_jsdoc = 1
let g:crystal_auto_format = 1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

if executable('rg')
  set grepprg=rg\ --vimgrep
endif

let mapleader = ","
let maplocalleader = ";"

set encoding=utf8

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set smartcase
"set rnu " relative line numbers, slow
set number " display current line number also
set hlsearch

if has('mouse')
  set mouse=a
endif

set viewoptions=cursor,folds
autocmd BufReadPost * silent! normal! g`"zvzt

set tabstop=2 " a tab is 2 spaces wide
set shiftwidth=2
set expandtab " tab = spaces

autocmd FileType go setlocal tabstop=4 noexpandtab
au BufNewFile,BufRead *.nokogiri set filetype=ruby
au BufNewFile,BufRead *.ru set filetype=ruby
au BufNewFile,BufRead Gemfile set filetype=ruby

set nobomb " no utf8 bom
set scrolloff=5               " keep at least 5 lines above/below
set sidescrolloff=5           " keep at least 5 lines left/right
set ttyfast
set laststatus=2 " Always show the statusline
set autoindent		" always set autoindenting on
set undofile " tell it to use an undo file
set undodir=~/.vimundo " set a directory to store the undo history
set t_Co=256 " Explicitly tell vim that the terminal has 256 colors
set background=dark

let g:solarized_termcolors=256
let g:solarized_termtrans=1
"let g:solarized_termcolors=16
"let g:solarized_use16 = 1
syntax enable
colorscheme solarized8_flat

if has("gui_running")
  " no toolbar
  set guioptions-=T
  set background=dark
  set vb
endif

" switch between buffers
nnoremap åå <c-^>
" clear search highlight
nnoremap § :setlocal nohlsearch!<CR>
" toggle show unprintable characters
nnoremap ää :set list!<CR>

nmap <Leader>s :setlocal spell!<CR>

" reselect after indentation
vnoremap < <gv
vnoremap > >gv

" Better comand-line editing
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

set winwidth=100

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

let g:tmuxline_powerline_separators = 0
let g:tmuxline_theme = 'lightline'
let g:tmuxline_preset = 'nightly_fox'
set noshowmode " no relvant with lightline

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif
