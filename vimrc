set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Sensible defaults
" implemented by neovim
" Plugin 'tpope/vim-sensible'
" Bufferline
Plugin 'bling/vim-bufferline'
" Sick statusbar
Plugin 'itchyny/lightline.vim'
" Sick sick sick colorscheme
Plugin 'jacoborus/tender'
"
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
" Snippets
Plugin 'honza/vim-snippets'
Plugin 'SirVer/ultisnips'
" Autocompletion 
Plugin 'Valloric/YouCompleteMe'
Plugin 'rdnetto/YCM-Generator'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
runtime! plugin/sensible.vim

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
set foldmethod=indent


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
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_server_python_interpreter = '/usr/bin/python'
let g:ycm_python_binary_path = '/usr/bin/python'

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
