set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin()

Plug 'edkolev/tmuxline.vim'
Plug 'VundleVim/Vundle.vim'
Plug 'christoomey/vim-system-copy'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tomasiser/vim-code-dark'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'

set rtp+=~/.fzf
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Setup completion
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
let g:python3_host_prog='/bin/python3'
Plug 'ncm2/ncm2-bufword'       " general
Plug 'ncm2/ncm2-jedi'          " Python
Plug 'ncm2/ncm2-path'          " paths
Plug 'ncm2/ncm2-pyclang'       " C/C++
Plug 'ncm2/ncm2-vim'           " vimscript
Plug 'ObserverOfTime/ncm2-jc2' " Java

" Map TAB to completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Map vim-commentary to cm
if !hasmapto('<Plug>Commentary') || maparg('gc','n') ==# ''
  xmap cm  <Plug>Commentary
  nmap cm  <Plug>Commentary
  omap cm  <Plug>Commentary
  nmap cmm <Plug>CommentaryLine
  nmap cmu <Plug>Commentary<Plug>Commentary
endif

call plug#end()
filetype plugin indent on    " required

nnoremap <SPACE> <Nop>
let mapleader = " "

" Setup airline
let g:airline_powerline_fonts = 1
let g:airline_theme='bubblegum'
let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let airline#extensions#tmuxline#snapshot_file = "~/.tmux-status.conf"

set tabstop=4
set shiftwidth=4
set expandtab

set number
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

syntax on
set t_Co=256
colors codedark 
set enc=utf-8
set guifont=Powerline_Consolas:h11
"set renderoptions=type:directx,gamma:1.5,contrast:0.5,geom:1,renmode:5,taamode:1,level:0.5

" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
" Exit Vim if NERDTre is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Go to tab by number
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>0 <Plug>AirlineSelectTab0
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab

" Set automatic absolute/relative line numbers
:set number
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END

