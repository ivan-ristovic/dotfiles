" vim: set fdm=marker foldmarker=\"\ ‣,Plug\ \':

cabbrev gst Gstatus
cabbrev gcm Gcommit
cabbrev gcommit Gcommit
cabbrev gpush Gpuch
Plug 'tpope/vim-fugitive'

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-c-d>"
let g:UltiSnipsEditSplit="horizontal"
set runtimepath+=~/.vimrc.d/common_runtime
Plug 'SirVer/ultisnips'

let g:ctrlp_extensions = ['switcher','modified','cscope']
let g:ctrlp_switch_buffer = 0
nnoremap <Leader>a    <Esc>:CtrlPSwitch<CR>|    "" Switch between .h .cpp
inoremap <S-Leader>a  <Esc>:CtrlPSwitch<CR>
nnoremap <S-Leader>a  <Esc>:CtrlPSwitch<CR>
nnoremap <Leader>o    <Esc>:CtrlP<CR>|          "" Open file
inoremap <S-Leader>o  <Esc>:CtrlP<CR>
nnoremap <S-Leader>o  <Esc>:CtrlP<CR>
nnoremap <Leader>O    <Esc>:CtrlP .<CR>|        "" Open file starting from the current directory
inoremap <S-Leader>O  <Esc>:CtrlP .<CR>
nnoremap <S-Leader>O  <Esc>:CtrlP .<CR>
nnoremap <Leader>b    <Esc>:CtrlPBuffer<CR>|    "" Open a buffer
inoremap <S-Leader>b  <Esc>:CtrlPBuffer<CR>
nnoremap <S-Leader>b  <Esc>:CtrlPBuffer<CR>
nnoremap <Leader>m    <Esc>:CtrlPBranch<CR>|    "" Open file modified in the current branch
inoremap <S-Leader>m  <Esc>:CtrlPBranch<CR>
nnoremap <S-Leader>m  <Esc>:CtrlPBranch<CR>
nnoremap <Leader>M    <Esc>:CtrlPModified<CR>|  "" Open a modified file
inoremap <S-Leader>M  <Esc>:CtrlPModified<CR>
nnoremap <S-Leader>M  <Esc>:CtrlPModified<CR>
nnoremap <Leader>t    <Esc>:CtrlPBufTagAll<CR>| "" Show current buffer tags
inoremap <S-Leader>t  <Esc>:CtrlPBufTagAll<CR>
nnoremap <S-Leader>t  <Esc>:CtrlPBufTagAll<CR>

function! CpsmBuildBinary(info)
    if a:info.status == 'installed' || a:info.force
        !PY3=ON ./install.sh
    endif
endfunction
Plug   'nixprime/cpsm', { 'as': 'vim-ctrlp-cpsm', 'do': function('CpsmBuildBinary') }
Plug   'ivan-cukic/vim-ctrlp-switcher'
Plug   'ivan-cukic/vim-ctrlp-cscope'
Plug   'jasoncodes/ctrlp-modified.vim'
Plug   'tacahiroy/ctrlp-funky'
Plug 'ctrlpvim/ctrlp.vim'

vmap t: :Tabularize/:<cr>
vmap t= :Tabularize/=<cr>
vmap t, :Tabularize/,<cr>
Plug 'godlygeek/tabular'

let g:tcomment_opleader1='_'
Plug 'tomtom/tcomment_vim'

let g:local_vimrc = {'names':['vim-extrarc'],'hash_fun':'LVRHashOfFile'}
Plug 'MarcWeber/vim-addon-local-vimrc'

let g:airline_powerline_fonts = 1
let g:airline_theme='bubblegum'
Plug   'vim-airline/vim-airline-themes'
Plug 'bling/vim-airline'

Plug 'airblade/vim-gitgutter'
Plug 'dietsche/vim-lastplace'

let g:leaderlist_show_all_mappings = 1
let g:leaderlist_command_separator = ' '
let g:leaderlist_leader_disable_conceal = 0
Plug 'ivan-cukic/vim-leader-list'

Plug 'aperezdc/vim-template'

if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
let g:ack_autoclose = 1
cabbrev Ack Ack!
Plug 'mileszs/ack.vim'

function TrimWhiteSpace()
  %s/\s*$//
  ''
endfunction

autocmd FileWritePre   * :call TrimWhiteSpace()
autocmd FileAppendPre  * :call TrimWhiteSpace()
autocmd FilterWritePre * :call TrimWhiteSpace()
autocmd BufWritePre    * :call TrimWhiteSpace()

autocmd BufNewFile,BufRead *.qml set filetype=qml
autocmd BufWritePost *.coffee silent CoffeeMake! -b | cwindow

