set nocompatible             " not compatible with the old-fashion vi mode
filetype off                 " required!
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle
" required!
Plugin 'VundleVim/Vundle.vim'
" My Bundles here:
"
" original repos on github
Plugin 'JSON.vim'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'othree/html5.vim'
Plugin 'ap/vim-css-color' "css 顏色
Plugin 'evgenyzinoviev/vim-vendetta' "colorscheme
Plugin 'itchyny/lightline.vim' "statusline
Plugin 'ervandew/supertab'
Plugin 'L9'
Plugin 'othree/vim-autocomplpop'
Plugin 'tpope/vim-fugitive' "status git branch
Plugin 'junegunn/vim-easy-align' " 自動對齊工具
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
set nomodeline
set bs=2
" remove ''\xef\xbb\xbf' marks (UTF-8 BOM)
set nobomb
" 不要過長顯示 @
set display=lastline
" 自動換行
set textwidth=0
" 搜尋keyword highlight
set hlsearch
set incsearch
" 紀錄
set history=50
filetype on
" syntax highlight開啟
syntax on
" 支援256色
set t_Co=256
set number
set cindent
set title
" tab間格 以四個space代替
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
" :sp打開檔案時，列出所有檔案
set wildmenu
" 可以用縮排
set foldmethod=marker
" html indent 支援在 *.php
filetype indent on
filetype plugin indent on
"只有在是PHP文件时，才启用PHP补全
au FileType php call AddPHPFuncList()
function! AddPHPFuncList()
    set dictionary-=~/.vim/php-funclist.txt dictionary+=~/.vim/php-funclist.txt
    set complete-=k complete+=k
endfunction

set list
set listchars=tab:->,trail:.
" {{{ syntax highlight格式 
colorscheme vendetta
"set background=dark
hi Comment term=standout cterm=bold ctermfg=0
hi Search term=reverse ctermbg=3 ctermfg=0
hi Folded ctermbg=black ctermfg=darkcyan
hi Identifier term=underline  cterm=bold  ctermfg=83
hi Cursor ctermbg=Gray ctermfg=Blue
hi clear SpellBad
hi SpellBad term=underline cterm=underline ctermfg=red
" }}}
" {{{ set status using lightline plugin
set laststatus=2
let g:lightline = {
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
\ },
\ 'component_function': {
\   'fugitive': 'LightLineFugitive',
\   'readonly': 'LightLineReadonly',
\   'modified': 'LightLineModified'
\ },
\ 'separator': { 'left': '⮀', 'right': '⮂' },
\ 'subseparator': { 'left': '⮁', 'right': '⮃' }
\ }
" }}}
" {{{ Line highlight 有一列
set cursorline
highlight CursorLine cterm=bold ctermbg=4
" insert時拿掉
au InsertEnter * set nocul
au InsertLeave * set cul
" }}}
" {{{ 自動把檔案轉換成utf-8編碼
set fileencoding=utf-8
set fileencodings=utf-8,big5,euc-jp,gbk,euc-kr,utf-bom,iso8859-1
set encoding=utf8
set tenc=utf8
" }}}
" {{{ 自動恢復到最後離開編輯的位置
if has("autocmd")
    autocmd BufRead *.txt set tw=78
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal g'\"" |
    \ endif
endif
" }}}
" Tab顏色設定
highlight TabLine ctermbg=white ctermfg=black
highlight TabLineFill ctermbg=black
highlight TabLineSel ctermbg=blue ctermfg=white
" {{{ 自動load session
function! AutoLoadSession()
    let g:sessionfile = getcwd() . "/Session.vim"
    if (argc() == 0 && filereadable(g:sessionfile))
        echohl WarningMsg
        echo "Session file exists. Load this? (y/n): "
        echohl None
        while 1
            let c = getchar()
            if c == char2nr("y")
                so Session.vim
                return
            elseif c == char2nr("n")
                return
            endif
        endwhile
    endif
endfunction

function! AutoSaveSession()
    if exists(g:sessionfile)
        exe "mks! " .
        g:sessionfile
    endif
endfunction

augroup AutoLoadSettion
    au!
    au VimEnter * call AutoLoadSession()
    au VimLeave * call AutoSaveSession()
augroup END
" }}}
" {{{ 存檔.vimrc ，所有效果立刻成立
autocmd! bufwritepost .vimrc source %
" }}}
" 自動去掉不必要的空白
map \ :%s/\s*$//g
" 存檔自動去除空白
autocmd FileType c,cpp,java,php,css,js,perl,python,ruby,sh autocmd BufWritePre  :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
