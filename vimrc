let g:has_plugin_manager = !empty(glob('~/.vim/autoload/plug.vim'))

if g:has_plugin_manager
  call plug#begin()

  " Easy editing
  Plug 'machakann/vim-sandwich'
  Plug 'tpope/vim-commentary'
  Plug 'tommcdo/vim-lion'
  " Additional keybindings
  Plug 'tpope/vim-unimpaired'
  " UI
  Plug 'itchyny/vim-cursorword'
  Plug 'raymond-w-ko/vim-niji'
  " UNIX Helper
  Plug 'tpope/vim-eunuch'
  " Wayland clipboard anywhere
  Plug 'jasonccox/vim-wayland-clipboard'
  " Autocomplete
  Plug 'prabirshrestha/async.vim'
  Plug 'prabirshrestha/vim-lsp'
  " Javascript
  Plug 'pangloss/vim-javascript'
  " Typescript
  Plug 'leafgarland/typescript-vim'
  Plug 'maxmellon/vim-jsx-pretty'
  " Julia
  Plug 'JuliaEditorSupport/julia-vim'
  " LaTeX
  Plug 'lervag/vimtex'
  " Editor config
  Plug 'editorconfig/editorconfig-vim'
  " Colorscheme
  Plug 'NLKNguyen/papercolor-theme'

  call plug#end()
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" > Constants
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let vimDir = '$HOME/.vim'
let &runtimepath .= ',' . vimDir


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
set completeopt=menuone,preview,noinsert,noselect,popup


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
" persistent undo
if has('persistent_undo')
  let myUndoDir = expand(vimDir . '/undo')
  call system('mkdir ' . vimDir)
  call system('mkdir ' . myUndoDir)
  let &undodir = myUndoDir
  set undofile
  set undolevels=1000
  set undoreload=1000
end


" > Spell check
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set spelllang+=cs


" > UI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !exists("g:syntax_on")
  syntax enable           " enables syntax highlighting
endif
set t_Co=256
set background=light 
colorscheme PaperColor
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

" > Python
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup python
  autocmd!
  autocmd FileType python set softtabstop=4 shiftwidth=4
  autocmd FileType python let g:pyindent_open_paren = 'shiftwidth()'
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" > PLUGIN CONFIGS BEGIN HERE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if g:has_plugin_manager


" > Vim-lsp
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lsp_diagnostics_enabled = 1
let g:lsp_highlight_references_enabled = 1
let g:asyncomplete_auto_completeopt = 0
" Debugging
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
endfunction

augroup lsp_install
  autocmd!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup end

" > Typescript LSP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('typescript-language-server')
  augroup lsp_typescript
    autocmd!
    autocmd! User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'allowlist': ['javascript', 'javascript.jsx', 'typescript', 'typescript.tsx'],
        \ })
  augroup end
endif


" > C/C++ LSP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('ccls')
  augroup lsp_ccls
    autocmd!
    autocmd! User lsp_setup call lsp#register_server({
          \ 'name': 'ccls',
          \ 'cmd': {server_info->['ccls']},
          \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
          \ 'initialization_options': { 'cache': { 'directory': '/tmp/ccls/cache' }},
          \ 'allowlist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
          \ 'config': { 'diagnostics': v:false },
          \})
  augroup end
endif


" > Julia LSP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('julia')
  augroup lsp_julia
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'LanguageServer.jl',
          \ 'cmd': {server_info->[
          \   'julia',
          \   '--startup-file=no',
          \   '--history-file=no',
          \   '--project=' . lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'Project.toml'),
          \   '-e',
          \   '
          \     using LanguageServer;
          \     using Pkg;
          \     import SymbolServer;
          \     import StaticLint;
          \     env_path = dirname(Pkg.Types.Context().env.project_file);
          \     server = LanguageServerInstance(stdin, stdout, env_path);
          \     server.runlinter = true;
          \     run(server);
          \ ']},
          \ 'allowlist': ['julia'],
          \ })
  augroup end
endif


" > Python LSP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('pylsp')
  augroup lsp_python
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'pylsp',
          \ 'cmd': {server_info->['pylsp']},
          \ 'whitelist': ['python'],
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


" > vim-sandwich
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
runtime macros/sandwich/keymap/surround.vim


" > vimtex
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tex_flavor = 'latex'

" Custom keybindings to work with vim-sandwich
nmap sde <plug>(vimtex-env-delete)
nmap sdc <plug>(vimtex-cmd-delete)
nmap sd$ <plug>(vimtex-env-delete-math)
nmap sdd <plug>(vimtex-delim-delete)
nmap sre <plug>(vimtex-env-change)
nmap src <plug>(vimtex-cmd-change)
nmap sr$ <plug>(vimtex-env-change-math)
nmap srd <plug>(vimtex-delim-change-math)

endif
