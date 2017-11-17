set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-sensible'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'itchyny/lightline.vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'jnwhiteh/vim-golang'
Plugin 'rhysd/vim-crystal'
Plugin 'pangloss/vim-javascript'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'airblade/vim-gitgutter'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

let mapleader = ","
let maplocalleader = ";"

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
"autocmd BufReadPost * silent! normal! g`"zvzt

set tabstop=2 " a tab is 2 spaces wide
set shiftwidth=2
set expandtab " tab = spaces

autocmd FileType go setlocal shiftwidth=4 tabstop=4
au BufNewFile,BufRead *.nokogiri set filetype=ruby
au BufNewFile,BufRead *.ru set filetype=ruby
au BufNewFile,BufRead Gemfile set filetype=ruby

set nobomb " no utf8 bom
set scrolloff=5               " keep at least 5 lines above/below
set sidescrolloff=5           " keep at least 5 lines left/right
set ttyfast
set shell=bash
set laststatus=2 " Always show the statusline
set autoindent		" always set autoindenting on
set undofile " tell it to use an undo file
set undodir=~/.vimundo " set a directory to store the undo history
set t_Co=256 " Explicitly tell vim that the terminal has 256 colors
set background=dark

let g:solarized_termcolors=256
let g:solarized_termtrans=1
syntax enable
colorscheme solarized

if has("gui_running")
  " no toolbar
  set guioptions-=T
  set guifont=Monaco:h14
  set transparency=05
  set background=light
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
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=5
set winminheight=5
set winheight=999

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

let g:tmuxline_powerline_separators = 0
let g:tmuxline_theme = 'lightline'
let g:tmuxline_preset = 'nightly_fox'

let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_ruby_rubocop_exec = '/Users/carl/.rbenv/shims/rubocop'
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_check_on_wq = 0
set noshowmode " no relvant with lightline

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif
