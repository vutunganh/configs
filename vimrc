call plug#begin()

" Easy editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'Raimondi/delimitMate'
Plug 'tommcdo/vim-lion'
" Additional keybindings
Plug 'tpope/vim-unimpaired'
" UI
Plug 'itchyny/vim-cursorword'
Plug 'raymond-w-ko/vim-niji'
" UNIX Helper
Plug 'tpope/vim-eunuch'
" Autocomplete
Plug 'prabirshrestha/async.vim'

Plug 'ajh17/vimcompletesme'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
" Julia
Plug 'JuliaEditorSupport/julia-vim', {'for': 'julia'}
" Javascript
Plug 'pangloss/vim-javascript', {'for': 'javascript'}

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
autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \ execute "normal! g'\"" |
      \ endif
runtime macros/matchit.vim " matchit plugin adds html tags matching
set path+=**    " fuzzy find from cwd


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
set statusline=\ %f%y%m%r%h\ %w\ L:\ %l\/%L\ C:\ %c
set nohlsearch
hi Folded ctermbg=black

if has('gui_running')
  set guifont=Monospace\ 12
endif


" > Keybindings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap 0 ^
nnoremap ^ 0
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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" > PLUGIN CONFIGS BEGIN HERE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" > Asyncomplete
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
imap <c-space> <Plug>(asyncomplete_force_refresh)

let g:asyncomplete_remove_duplicates = 1
let g:asyncomplete_smart_completion = 1 " fuzzy completion
let g:asyncomplete_auto_popup = 0
set completeopt+=preview " use preview window
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif " when done with completion close preview window


" > Javascript LSP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('~/node_modules/typescript-language-server/lib/cli.js')
  augroup lsp_javascript
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'typescript-language-server',
          \ 'cmd': {server_info->[&shell, &shellcmdflag','~/node_modules/typescript-language-server/lib/cli.js --stdio']},
          \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_directory(lsp#utils#get_buffer_path(), '.git/..'))},
          \ 'whitelist': ['typescript', 'javascript', 'javascript.jsx']
          \ })
    autocmd FileType js setlocal omnifunc=lsp#complete
  augroup end
endif


" > C/C++ LSP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('clangd')
  augroup lsp_clangd
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'clangd',
          \ 'cmd': {server_info->['clangd']},
          \ 'whitelist': ['c', 'cpp']
          \ })
    autocmd FileType c setlocal omnifunc=lsp#complete
    autocmd FileType cpp setlocal omnifunc=lsp#complete
  augroup end
endif


" > Commentary
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup commentary
  autocmd FileType c setlocal commentstring=//\ %s
  autocmd FileType cpp setlocal commentstring=//\ %s
augroup END
