" vim: set fdm=marker foldmarker=\"\ ‣,Plug\ \':


" ‣ Creating text objects
"   (needed for vim-latex text objects)
Plug 'kana/vim-textobj-user'

" ‣ SmartPairs - Visual selection
"     viv - start
"     v - expand
let g:smartpairs_uber_mode = 1
Plug 'gorkunov/smartpairs.vim'

" ‣ Comment Text Object
Plug 'glts/vim-textobj-comment'

" ‣ EasyMotion - Faster motion than the ordinary 5w and similar
nmap <Leader><Space>  <Plug>(easymotion-bd-jk)|  "" EasyMotion jump to lines
nmap <Leader>w        <Plug>(easymotion-bd-w)|    "" EasyMotion jump to words
nmap <Leader>f        <Plug>(easymotion-bd-f)|    "" EasyMotion jump to words starting with a specific letter
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_upper = 1
let g:EasyMotion_keys = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ;'
let g:EasyMotion_do_mapping = 0
Plug 'easymotion/vim-easymotion'

" ‣ CamelCaseMotion - ,w ,b ,e - word objects inside camel and snake-case variable names
" function! CamelCaseMotionInit()
"     call camelcasemotion#CreateMotionMappings(',')
" endfunction
Plug 'bkad/CamelCaseMotion'

" ‣ ArgTextObj - a - an argument object
Plug 'vim-scripts/argtextobj.vim'

" ‣ Vim-Indent-Object - i - indented block object
Plug 'michaeljsmith/vim-indent-object'

