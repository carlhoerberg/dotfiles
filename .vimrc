set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
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
set rnu " relative line numbers
set number " display current line number also
set hlsearch

" Omnicomlete to ctrl-space
imap <c-space> <c-x><c-o>

" Don't use Ex mode, use Q for formatting
"map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
"inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
"if has('mouse')
"  set mouse=a
"endif

set viewoptions=cursor,folds
autocmd BufReadPost * silent! normal! g`"zvzt

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

set winwidth=100
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=5
set winminheight=5
set winheight=999

" reselect after indentation
vnoremap < <gv
vnoremap > >gv
" easier windows moving
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" jump faster
nnoremap <c-J> 11j
nnoremap <c-K> 11k

" Better comand-line editing
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" ignore certain folders in CommandT
set wildignore+=*.o,*.obj,.git,output,coverage,classes,*.jar,*.png,*.jpg,*.gif,*.min.js,tmp,target,venv,*.pyc,node_modules,vendor

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

nmap <Leader>s :setlocal spell!<CR>
nmap <Leader>d :set background=dark<CR>

let g:airline_powerline_fonts = 0
let g:tmuxline_powerline_separators = 0
let g:tmuxline_theme = 'airline'
let g:tmuxline_preset = 'nightly_fox'

let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_ruby_rubocop_exec = '/Users/carl/.rbenv/shims/rubocop'
let g:syntastic_javascript_checkers = ['jshint']
