" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" vundle
filetype off " required
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
" Bundles
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'Lokaltog/vim-powerline'
Bundle 'altercation/vim-colors-solarized'
Bundle 'kchmck/vim-coffee-script'
Bundle 'wincent/Command-T'
Bundle 'vim-ruby/vim-ruby'
Bundle 'scrooloose/nerdtree'
Bundle 'VimClojure'
Bundle 'godlygeek/tabular'

filetype plugin indent on     " required! 

let mapleader = ","
set rnu " relative line numbers

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set ignorecase
set smartcase

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
nnoremap <leader>o :DiffOrig<CR>

set tabstop=2 " a tab is 2 spaces wide
set shiftwidth=2 " 
set expandtab " tab = spaces
set backupdir=~/.vim/tmp

au BufNewFile,BufRead *.yajl set filetype=ruby
au BufNewFile,BufRead *.ru set filetype=ruby
au BufNewFile,BufRead *.pill set filetype=ruby
au BufNewFile,BufRead Gemfile set filetype=ruby
au BufNewFile,BufRead Guardfile set filetype=ruby
set nobomb " no utf8 bom
set scrolloff=5               " keep at least 5 lines above/below
set sidescrolloff=5           " keep at least 5 lines left/right
set ttyfast " fast tty?
set shell=bash

set laststatus=2 " Always show the statusline
set t_Co=256 " Explicitly tell vim that the terminal has 256 colors

let g:solarized_termcolors=256
let g:solarized_termtrans=1
syntax enable
set background=dark
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
nnoremap <leader><leader> <c-^>
" clear search highlight
nnoremap <leader>c :nohlsearch<CR>
" toogle paste mode
nnoremap <leader>p :set paste!<CR>

set winwidth=84
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

" Better comand-line editing
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" ignore certain folders in CommandT
set wildignore+=*.o,*.obj,.git,output/**,coverage/**,lib

" mappings for Tabularize
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>

