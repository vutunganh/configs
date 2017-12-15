call plug#begin()

" Packages
Plug 'sheerun/vim-polyglot'
" Bufferline
Plug 'bling/vim-bufferline'
" Easy editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'Raimondi/delimitMate'
Plug 'tommcdo/vim-lion'
" Autocompletion 
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'Shougo/neoinclude.vim'
  Plug 'zchee/deoplete-clang', { 'for': [ 'cpp', 'c' ] }
  Plug 'zchee/deoplete-jedi', { 'for': 'python' }
  Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': ['./install.sh',':UpdateRemotePlugins']}
  Plug 'JuliaEditorSupport/LanguageServer.jl'
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
set lazyredraw  " doesn't redraw screen when typing commands
set mouse=a     " mouse in terminal??
set noeb        " no error bell
set vb          " visual bell
set t_vb=       " don't flash when scrolling past first/last line


" > Editing
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmenu      " better command line completion
set wildmode=full " same as above
set expandtab     " tab insert spaces
set smarttab      " bs deletes a bunch of spaces like a tab
" set tabstop=2   " can't touch this
set shiftwidth=2  " '``tab'' size
set softtabstop=2 " '``tab'' size
set cindent
set cinkeys-=0#
set indentkeys-=0#
set wrap          " wrap lines


" > UI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !exists("g:syntax_on")
  syntax enable           " enables syntax highlighting
endif
set background=dark 
colorscheme elflord
set number                " shows line number
set showcmd               " shows currently entered command
set laststatus=2          " all windows have status lines
set statusline=\ %F%y%m%r%h\ %w\ \ CWD:\ %{getcwd()}\ \ \ Line:\ %l\/%L\ Column:\ %c
let g:bufferline_echo = 1 "bufferline plugin

if has('gui_running')
  set guifont=Monospace\ 12
endif
set nohlsearch


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
" Remember info about open buffers on close
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
map 0 ^
" 0 moves to the beginning of line
nnoremap <F5> :make<CR>
nnoremap <F6> :make all<CR>
cmap w!! !sudo tee % > /dev/null

inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"


" > C++
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Don't indent access specifiers (public, private,...)
set cinoptions+=g0
set cinoptions+=N-s


" > Deoplete
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has( 'nvim' )
let g:deoplete#enable_at_startup = 1 
let g:deoplete#enable_refresh_always = 1

let g:deoplete#sources#clang#libclang_path='/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header ='/usr/lib/clang'
let g:deoplete#sources#clang#executable ='/usr/bin/clang-4.0'
let g:deoplete#sources#clang#std={'c': 'c99', 'cpp': 'c++14', 'objc': 'c11', 'objcpp': 'c++1z'}

let g:deoplete#sources#jedi#show_docstring = 1

" debugging mode
" let g:deoplete#enable_profile = 1
" call deoplete#enable_logging('DEBUG', 'deoplete.log')
" call deoplete#custom#set('jedi', 'debug_enabled', 1)

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
endif


" > Latex
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tex_flavor = "latex"
autocmd FileType tex let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete
let g:polyglot_disabled = ['latex']


" > Surround
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType cpp let g:surround_{char2nr("d")} = "#ifdef DEBUG\n\r\n#endif"
autocmd FileType c let g:surround_{char2nr("d")} = "#ifdef DEBUG\n\r\n#endif"


" > Commentary
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType c setlocal commentstring=//\ %s
autocmd FileType cpp setlocal commentstring=//\ %s

" > Julia
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:default_julia_version = '0.6'

" > LanguageClient
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
\   'julia': ['julia', '--startup-file=no', '--history-file=no', '-e', '
\       using LanguageServer;
\       server = LanguageServer.LanguageServerInstance(STDIN, STDOUT, false);
\       server.runlinter = true;
\       run(server);
\   '],
\ }
