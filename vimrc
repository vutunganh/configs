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
  Plug 'roxma/nvim-completion-manager'
  Plug 'Shougo/neoinclude.vim'
  Plug 'autozimu/LanguageClient-neovim', {'tag': 'binary-*-x86_64-unknown-linux-musl'}
  Plug 'JuliaEditorSupport/LanguageServer.jl', {'for': 'julia'}
endif
" Latex
Plug 'lervag/vimtex', {'for': ['tex', 'latex']}
" Julia
Plug 'JuliaEditorSupport/julia-vim', {'for': 'julia'}

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
set nobackup    " no backups at all
set noswapfile


" > Editing
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmenu       " better command line completion
set wildmode=full  " same as above
set expandtab      " tab insert spaces
set smarttab       " bs deletes a bunch of spaces like a tab
" set tabstop=2    " can't touch this
set shiftwidth=2   " tab size when indenting
set softtabstop=2  " ``tab'' size
set cindent
set cinkeys-=0#    " don't indent preprocessor directives
set indentkeys-=0# " same as above
set wrap           " wrap lines


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
let g:bufferline_echo = 1 " bufferline plugin
set shortmess+=c          " nvim completion manager

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
noremap 0 ^
nnoremap <F5> :make<CR>
nnoremap <F6> :make all<CR>
cmap w!! !sudo tee % > /dev/null 
" tab expands completion
inoremap <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"


" > C++
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set cinoptions+=g0  " don't indent access specifiers (public, private,...)
set cinoptions+=N-s " don't indent elements in namespaces


" > nvim-completion-manager
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let $NVIM_PYTHON_LOG_FILE="/tmp/nvim_log"
let $NVIM_NCM_LOG_LEVEL="DEBUG"
let $NVIM_NCM_MULTI_THREAD=0


" > Latex
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tex_flavor = "latex"
let g:polyglot_disabled = ['latex']


" > Commentary
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup commentary
  autocmd FileType c setlocal commentstring=//\ %s
  autocmd FileType cpp setlocal commentstring=//\ %s
augroup END


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
      \   ']
      \ }
let g:LanguageClient_loggingLevel = 'DEBUG'
