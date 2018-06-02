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
  Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
  Plug 'Shougo/neoinclude.vim'
  Plug 'zchee/deoplete-clang', {'for': ['cpp', 'c']}
  Plug 'zchee/deoplete-jedi', {'for': 'python'}
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
" remember cursor position when reopening a file
if has("autocmd")
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \ execute "normal! g'\"" |
        \ endif
endif


" > Editing
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmenu      " better command line completion
set wildmode=full " same as above
set expandtab     " tab insert spaces
set smarttab      " bs deletes a bunch of spaces like a tab
" set tabstop=2   " can't touch this
set shiftwidth=2  " tab size when indenting
set softtabstop=2 " ``tab'' size
set wrap          " wrap lines


" > Spell check
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set spelllang+=cs


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
set statusline=\ %f%y%m%r%h\ %w\ \ CWD:\ %{getcwd()}\ \ \ Line:\ %l\/%L\ Column:\ %c
set nohlsearch
hi Folded ctermbg=black

if has('gui_running')
  set guifont=Monospace\ 12
endif


" > Keybindings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = "<Space>"
let g:mapleader = "<Space>"
nnoremap 0 ^
" 0 moves to the beginning of line
nnoremap <F5> :make<CR>
nnoremap <F6> :make all<CR>
cmap w!! !sudo tee % > /dev/null 


" > C++
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" don't indent preprocessor directives
set cindent
set cinkeys-=0#
set indentkeys-=0#
" Don't indent access specifiers (public, private,...)
set cinoptions+=g0
set cinoptions+=N-s


" > Bufferline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:bufferline_echo = 1 "bufferline plugin


" > Deoplete
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('nvim')
 let g:deoplete#enable_at_startup = 1

 " C/C++
 let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
 let g:deoplete#sources#clang#clang_header = '/usr/lib/clang/6.0.0/include'
 let g:deoplete#sources#clang#std = {'c': 'c99', 'cpp': 'c++14'}

 " Python
 let g:deoplete#sources#jedi#show_docstring = 1
 let g:deoplete#sources#jedi#enable_cache = 1


"  " debugging mode
"  " let g:deoplete#enable_profile = 1
"  " call deoplete#enable_logging('DEBUG', 'deoplete.log')
"  " call deoplete#custom#set('jedi', 'debug_enabled', 1)

 if !exists('g:deoplete#omni#input_patterns')
   let g:deoplete#omni#input_patterns = {}
 endif
 " Tex
 augroup vimtex
   autocmd FileType tex let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete
 augroup END
endif


" > Latex
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tex_flavor = 'latex'
let g:polyglot_disabled = ['latex']

let g:vimtex_compiler_latexmk = {
      \ 'build_dir': '../build/',
      \ 'callback': 1,
      \ 'continuous': 1,
      \ 'executable': 'latexmk',
      \ 'options': [
      \   '-xelatex'
      \],
\}

" > Commentary
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup commentary
  autocmd FileType c setlocal commentstring=//\ %s
  autocmd FileType cpp setlocal commentstring=//\ %s
augroup END


" > Julia
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:default_julia_version = '0.6'
