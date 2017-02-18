call plug#begin()

" Sensible defaults
" implemented by neovim
if !has("nvim")
Plug 'tpope/vim-sensible'
endif
" Bufferline
Plug 'bling/vim-bufferline'
" Colorscheme
Plug 'jacoborus/tender'
Plug 'larsbs/vimterial'
" Easy editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-unimpaired'
" Snippets
Plug 'vutunganh/vim-snippets'
Plug 'SirVer/ultisnips'
" Autocompletion 
 if has("nvim")
   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
   Plug 'zchee/deoplete-clang'
   Plug 'Shougo/neoinclude.vim'
   Plug 'zchee/deoplete-jedi'
 endif
if !has("nvim")
"  Plug 'Valloric/YouCompleteMe'
"  Plug 'rdnetto/YCM-Generator'
Plug 'ajh17/VimCompletesMe'
endif

call plug#end()

" > Behaviour
""""""""""""""""""""""""""""""""""""""""
" lines above/below cursor
set scrolloff=5
" ignore case when searching
set ignorecase
" cooperate with ignorecase
set smartcase
set showmatch
set incsearch
set hlsearch
set lazyredraw
set mat=2
set mouse=a


" > Editing
""""""""""""""""""""""""""""""""""""""""
set wildmenu
set wildmode=full
set expandtab
set smarttab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set cindent
set cinkeys-=0#
set indentkeys-=0#
set wrap "Wrap lines
map <leader>pp :setlocal paste!<cr>


" > UI
""""""""""""""""""""""""""""""""""""""""
syntax enable
set background=dark
colorscheme vimterial
set foldcolumn=1
set number
set relativenumber
set t_Co=256
set cursorline
set showcmd
set laststatus=2
"set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
"set statusline=%<%.99F\ %h%w%m%r%y%=%-16(\ %l/%L\ %)
set statusline=\ %F%y%m%r%h\ %w\ \ CWD:\ %{getcwd()}\ \ \ Line:\ %l\/%L
let g:bufferline_echo = 1


" > Keybindings
""""""""""""""""""""""""""""""""""""""""
" leader key
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"
" moving around buffers
map <leader>l :bnext!<cr>
map <leader>h :bprevious!<cr>
" close buffer
map <leader>bd :bdelete<cr>
" tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 
" Remember info about open buffers on close
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" 0 moves to the beginning of line
map 0 ^
nnoremap <leader><CR> :nohlsearch<CR>

nnoremap <F5> :make<CR>


" > C++
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Don't indent access specifiers (public, private,...)
set cinoptions+=g0

" > YouCompleteMe
" deoplete in neovim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !has( "nvim" )
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_server_python_interpreter = '/usr/bin/python'
let g:ycm_python_binary_path = '/usr/bin/python'
endif


" > Deoplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has( "nvim" )
let g:deoplete#enable_at_startup = 1 
let g:deoplete#sources#clang#libclang_path='/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header ="/usr/lib/clang"
let g:deoplete#sources#clang#std={'c': 'c99', 'cpp': 'c++11', 'objc': 'c11', 'objcpp': 'c++1z'}
let g:deoplete#enable_refresh_always = 1

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
endif


" > Ultisnips
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<c-t>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"
