call plug#begin()

" Sensible defaults
" implemented by neovim
" Plugin 'tpope/vim-sensible'
" Bufferline
Plug 'bling/vim-bufferline'
" Sick statusbar
Plug 'itchyny/lightline.vim'
" Sick sick sick colorscheme
Plug 'jacoborus/tender'
"
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
" Snippets
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
" Autocompletion 
if has("nvim")
  Plug 'Shougo/deoplete.nvim'
  Plug 'zchee/deoplete-clang'
  Plug 'Shougo/neoinclude.vim'
  Plug 'neomake/neomake'
endif
if !has("nvim")
Plug 'Valloric/YouCompleteMe'
Plug 'rdnetto/YCM-Generator'
endif

call plug#end()

" > Behaviour
""""""""""""""""""""""""""""""""""""""""
set scrolloff=5
set ignorecase
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
colorscheme tender
set foldcolumn=1
set number
set relativenumber
set t_Co=256
set cursorline
set showcmd


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

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
endif


" > Ultisnips
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:UltiSnipsExpandTrigger="<c-t>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"



" > Lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" disable bufferline echoing
let g:bufferline_echo = 0
set laststatus=2
let g:tender_lightline = 1
let g:lightline = {
      \ 'colorscheme': 'tender',
      \ 'mode_map': { 'c' : 'NORMAL' },
      \ 'active' : {
      \   'left': [ [ 'mode', 'paste' ], [ 'filename', 'fugitive' ], [ 'bufferline' ] ],
      \   'right' : [ [ 'lineinfo' ] ]
      \ },
      \ 'component_function' : {
      \   'bufferline' : 'LightlineBufferline',
      \   'fugitive' : 'LightlineFugitive'
      \ }
      \ }

function! LightlineBufferline( )
  call bufferline#refresh_status() 
  let b = g:bufferline_status_info.before
  let c = g:bufferline_status_info.current
  let a = g:bufferline_status_info.after
  return b . c . a
endfunction
function! LightlineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? ''._ : ''
  endif
  return ''
endfunction
