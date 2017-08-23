call plug#begin()

" Bufferline
Plug 'bling/vim-bufferline'
" Colorscheme
Plug 'jacoborus/tender'
" Easy editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'Raimondi/delimitMate'
Plug 'tommcdo/vim-lion'
" Autocompletion 
if has("nvim")
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'Shougo/neoinclude.vim'
  Plug 'zchee/deoplete-clang', { 'for': [ 'cpp', 'c' ] }
  Plug 'zchee/deoplete-jedi', { 'for': 'python' }
endif

if !has("nvim")
  Plug 'maralla/completor.vim'
endif

" Latex
Plug 'lervag/vimtex', { 'for' : [ 'tex', 'latex' ] }

call plug#end()

" > Behaviour
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set scrolloff=5 " lines above/below cursor
set ignorecase  " ignore case when searching
set smartcase   " cooperate with ignorecase
set hidden      " switch buffers without having to save the file being left
set incsearch   " incrementally shows searched pattern
set hlsearch    " highlights search results
set lazyredraw  " ??
set mouse=a     " mouse in terminal??
set noeb        " no error bell
set vb          " visual bell
set t_vb=       " neovim terminal visual bell


" > Editing
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmenu      " better command line completion
set wildmode=full " same as above
set expandtab     " tab insert spaces
set smarttab      " bs deletes a bunch of spaces like a tab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set cindent
set cinkeys-=0#
set indentkeys-=0#
set wrap          " wrap lines
map <leader>pp :setlocal paste!<cr>


" > UI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable             " enables syntax highlighting
set background=dark 
set t_Co=256              " ??
set t_ut=                 " ??
colorscheme tender
set relativenumber
set cursorline            "highlights the line
set showcmd               "shows currently entered command
set laststatus=2          " all windows have status lines
set statusline=\ %F%y%m%r%h\ %w\ \ CWD:\ %{getcwd()}\ \ \ Line:\ %l\/%L\ Column:\ %c
let g:bufferline_echo = 1 "bufferline plugin

if has('gui_running')
  set guifont=Monospace\ 12
endif


" > Keybindings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"
" close buffer
map <leader>bd :bdelete<cr>
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" Remember info about open buffers on close
map 0 ^
" 0 moves to the beginning of line
nnoremap <leader><CR> :nohlsearch<CR>
nnoremap <F5> :make<CR>
cmap w!! !sudo tee % > /dev/null

inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" > C++
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Don't indent access specifiers (public, private,...)
set cinoptions+=g0
set cinoptions+=N-s

" > Completor.vim
" deoplete in neovim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !has("nvim")
  let g:completor_python_binary = '/usr/bin/python'
  let g:completor_clang_binary = '/usr/bin/clang'
endif

" > VimCompletesMe
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" augroup OmniCompletionSetup
"   autocmd!
"   autocmd FileType c          set omnifunc=ccomplete#Complete
"   autocmd FileType php        set omnifunc=phpcomplete#CompletePHP
"   autocmd FileType python     set omnifunc=jedi#completions
"   autocmd FileType ruby       set omnifunc=rubycomplete#Complete
"   autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"   autocmd FileType html       set omnifunc=htmlcomplete#CompleteTags
"   autocmd FileType css        set omnifunc=csscomplete#CompleteCSS
"   autocmd FileType xml        set omnifunc=xmlcomplete#CompleteTags
" augroup END


" > Deoplete
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has( "nvim" )
let g:deoplete#enable_at_startup = 1 
let g:deoplete#enable_refresh_always = 1

let g:deoplete#sources#clang#libclang_path='/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header ="/usr/lib/clang"
let g:deoplete#sources#clang#std={'c': 'c99', 'cpp': 'c++14', 'objc': 'c11', 'objcpp': 'c++1z'}

" debugging mode
" let g:deoplete#enable_profile = 1
" call deoplete#enable_logging('DEBUG', 'deoplete.log')
" call deoplete#custom#set('jedi', 'debug_enabled', 1)

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
endif

" > Surround
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType cpp let g:surround_{char2nr("d")} = "#ifdef DEBUG\n\r\n#endif"
autocmd FileType c let g:surround_{char2nr("d")} = "#ifdef DEBUG\n\r\n#endif"
