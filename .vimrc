
execute pathogen#infect()

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
lan mes en_US.UTF-8
let mapleader = ","

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup		" do not keep a backup file, use versions instead

set history=50		" keep 50 lines of command line history

set encoding=utf-8
set scrolloff=5 " number of screen lines above and below cursor
set showmode    " show current mode in the last line
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set number
set relativenumber
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

set wrap
set textwidth=79
set colorcolumn=80
set formatoptions=qrn1
set list
set listchars=trail:·,tab:»\ 

set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set laststatus=2

nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

set incsearch		" do incremental searching
set showmatch

call togglebg#map("")

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  set background=dark
  set t_Co=256
  colorscheme solarized
  " invisible character colors
  highlight NonText guifg=#4a4a59
  highlight SpecialKey guifg=#4a4a59
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

  " For all text files set 'textwidth' to 79 characters.
  autocmd FileType text setlocal textwidth=79

  au FocusLost * :wa

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
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

command W w !sudo tee % > /dev/null

nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

nnoremap <leader>w <C-w>v<C-w>l
nn <leader>nn :set nu!<CR>
nn <leader>rn :set rnu!<CR>
nn <leader>ntt :NERDTreeToggle<CR>
nn <leader>gt :GundoToggle<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

if has("win32") || has("win64")
  set directory=$TMP
else
  set directory=/tmp
end

set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

" Configure plugins
" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" closetag
let g:closetag_html_style=1
" end configure plugins

