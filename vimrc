let g:has_plugin_manager = !empty(glob('~/.vim/autoload/plug.vim'))

if g:has_plugin_manager
  call plug#begin()

  " Easy editing
  Plug 'machakann/vim-sandwich'
  Plug 'tpope/vim-commentary'
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
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  " Javascript
  Plug 'pangloss/vim-javascript'
  " Typescript
  Plug 'leafgarland/typescript-vim'
  Plug 'maxmellon/vim-jsx-pretty'
  " Julia
  Plug 'JuliaEditorSupport/julia-vim'
  " Editor config
  Plug 'editorconfig/editorconfig-vim'

  call plug#end()
endif


" > Behaviour
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set scrolloff=5 " lines above/below cursor
set ignorecase  " ignore case when searching
set smartcase   " cooperate with ignorecase
set hidden      " switch buffers without having to save the file being left
set incsearch   " incrementally shows searched pattern
set lazyredraw  " doesn't redraw screen when typing commands
set mouse=a     " mouse in terminal
set noeb        " no error bell
set vb          " visual bell
set t_vb=       " don't flash when scrolling past first/last line
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
nnoremap <F5> :make<CR>


" > C++
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" don't indent preprocessor directives
set cindent
set cinkeys-=0#
set indentkeys-=0#
" Don't indent access specifiers (public, private,...)
set cinoptions+=g0
set cinoptions+=N-s


" > Javascript
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('prettier')
  augroup javascript
    autocmd!
    autocmd FileType javascript setlocal formatprg=prettier
    autocmd FileType javascript.jsx setlocal formatprg=prettier
    autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript
    autocmd FileType typescript.tsx setlocal formatprg=prettier\ --parser\ typescript
    autocmd FileType html setlocal formatprg=prettier\ --type\ html
    autocmd FileType scss setlocal formatprg=prettier\ --parser\ css
    autocmd FileType css setlocal formatprg=prettier\ --parser\ css
  augroup end
endif


" > Typescript
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup typescript
  autocmd!
  autocmd Filetype typescriptreact set filetype=typescript.tsx
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" > PLUGIN CONFIGS BEGIN HERE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if g:has_plugin_manager


" > Vim-lsp
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lsp_diagnostics_enabled = 0
let g:lsp_highlight_references_enabled = 0
" Debugging
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')
" let g:asyncomplete_log_file = expand('~/asyncomplete.log')


" > Asyncomplete
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
imap <C-Space> <Plug>(asyncomplete_force_refresh)
set completeopt=menuone,noinsert,noselect,preview


" > Typescript LSP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('typescript-language-server')
  augroup lsp_typescript
    autocmd!
    autocmd! User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['javascript', 'javascript.jsx', 'typescript', 'typescript.tsx'],
        \ })
  augroup end
endif


" > C/C++ LSP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('clangd')
  augroup lsp_clangd
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'clangd',
          \ 'cmd': {server_info->['clangd', '-background-index']},
          \ 'whitelist': ['c', 'cpp'],
          \ })
  augroup end
endif


" > Julia LSP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('julia')
  augroup lsp_julia
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'LanguageServer.jl',
          \ 'cmd': {server_info->['julia', '--startup-file=no', '--history-file=no', '-e', '
          \ using LanguageServer;
          \ using Pkg;
          \ env_path = dirname(Pkg.Types.Context().env.project_file);
          \ server = LanguageServerInstance(stdin, stdout, env_path);
          \ server.runlinter = true;
          \ run(server);']},
          \ 'whitelist': ['julia'],
          \ })
  augroup end
endif


" > Commentary
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup commentary
  autocmd!
  autocmd FileType c setlocal commentstring=//\ %s
  autocmd FileType cpp setlocal commentstring=//\ %s
augroup END


" > vim-jsx-pretty
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vim_jsx_pretty_colorful_config = 1


endif
