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
Bundle 'vim-ruby/vim-ruby'
"Bundle 'scrooloose/nerdtree'
"Bundle 'slimv.vim'
Bundle 'godlygeek/tabular'
"Bundle 'spolu/dwm.vim'
"Bundle 'kana/vim-smartinput'
Bundle 'jnwhiteh/vim-golang'
Bundle 'scrooloose/syntastic'
"Bundle 'chriskempson/vim-tomorrow-theme'
Bundle 'kien/ctrlp.vim'
"Bundle 'guns/vim-clojure-static'
Bundle 'tpope/vim-classpath'
Bundle 'tpope/vim-fireplace'
"Bundle 'Valloric/YouCompleteMe'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'airblade/vim-gitgutter'
Bundle 'pangloss/vim-javascript'
Bundle 'digitaltoad/vim-jade'

filetype plugin indent on     " required! 

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

"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
"endif
set viewoptions=cursor,folds
au BufWinLeave ?* mkview
au BufWinEnter ?* silent loadview
"au BufReadPre ?* silent loadview

set tabstop=2 " a tab is 2 spaces wide
set shiftwidth=2 " 
set expandtab " tab = spaces

autocmd FileType go setlocal shiftwidth=4 tabstop=4
au BufNewFile,BufRead *.nokogiri set filetype=ruby
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
set autoindent		" always set autoindenting on
set undofile " tell it to use an undo file
set undodir=~/.vimundo " set a directory to store the undo history

let g:solarized_termcolors=256
let g:solarized_termtrans=1
syntax enable
if !empty($BACKGROUND)
  set background="$BACKGROUND"
else
  set background=light
endif
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
nnoremap § :nohlsearch<CR>

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

" jump faster
nnoremap <c-J> 11j
nnoremap <c-K> 11k

" Better comand-line editing
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" ignore certain folders in CommandT
set wildignore+=*.o,*.obj,.git,output,coverage,classes,*.jar,*.png,*.jpg,*.gif,*.min.js,tmp,target,venv,*.pyc,node_modules

" mappings for Tabularize
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>

nmap <Leader>s :setlocal spell!<CR>
nmap <Leader>d :set background=dark<CR>

" vim clojure static
let g:clojure_maxlines = 80
let g:clojure_fuzzy_indent = 1
let g:clojure_fuzzy_indent_patterns = ['^with', '^def', '^let']
let g:clojure_fuzzy_indent_blacklist = ['-fn$', '\v^with-%(meta|out-str|loading-context)$']

