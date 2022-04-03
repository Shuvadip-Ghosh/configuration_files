" plugins
call plug#begin()
"Plug 'dense-analysis/ale' for line correction
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
" Plug 'navarasu/onedark.nvim'
Plug 'shaunsingh/nord.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-lualine/lualine.nvim'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/indentpython.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'neoclide/coc.nvim'
":CocInstall coc-pyright
":CocInstall coc-java
":CocInstall coc-json
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug '907th/vim-auto-save'
Plug 'romgrk/barbar.nvim'
Plug 'preservim/nerdtree'
Plug 'mhinz/vim-startify'
call plug#end()


"all key mappings
imap jk <esc>
nmap <M-h>  <esc>0 h
imap <M-h>  <esc>0 h i
nmap <M-e>  <esc>$
imap <M-e>  <esc>$ 
"select all
imap <c-a> <esc> gg _ v G $ 
nmap <c-a> gg _ v G $
"NERDTreeToggle
imap <C-b> <esc>:NERDTreeToggle<right><CR> :wincmd l <CR>i
map <C-b> :NERDTreeToggle<CR> :wincmd l <CR>
"save
imap <C-s> <esc>:w<cr>li
map <C-s> :w<cr>i
"save and quit
imap <C-q> <esc>:wq <CR>
map <C-q> :wq <CR>

" only quit
map <M-q> :q! <CR>
imap <M-q> :q! <CR>

"undo
imap <c-z> <esc>u i
map <C-z> u 
"word wrap
imap <M-z> <esc>:call ToggleWrap()<CR>
map <M-z> :call ToggleWrap()<CR>
"create new file
imap <c-n> <esc> :!touch 
nmap <c-n> :!touch 
"comment
vmap <M-f> gcc <esc>
map <M-f> gcc <esc>
imap <M-f> <esc> gcc <esc> i
"uncomment
vmap <M-d> gc <esc> 
map <M-d> gc <esc> 
imap <M-d> <esc> gc <esc> i
"copy to next line
imap <C-d> <esc> yy p i
nmap <C-d> <esc> yy p
"NERDTreeRefreshRoot
imap <M-r> <esc> :NERDTreeRefreshRoot <cr>i
nmap <M-r> <esc> :NERDTreeRefreshRoot <cr>
"directly open vimrc
nmap <M-l> :vsplit $MYVIMRC<cr>
"run Python file
autocmd FileType python imap <F9> <esc> :!python % <cr>
autocmd FileType python map <F9> :!python % <cr>
"code shifting
vmap <tab> >
vmap <S-tab> <
vmap < <gv
vmap > >gv
" move through buffers
nmap <Tab> :bp <cr>
nmap <C-j> :wincmd j<CR>
nmap <C-k> :wincmd k<CR>
nmap <C-h> :wincmd h<CR>
nmap <C-l> :wincmd l<CR>

" move through buffers
nmap <leader>[ :bp!<CR>
nmap <leader>] :bn!<CR>
nmap <leader>x :bp<bar>bd#<CR>

" windows system clipboard
set clipboard=unnamed
autocmd TextYankPost * call system('win32yank.exe -i --crlf', @")
function! Paste(mode)
    let @" = system('win32yank.exe -o --lf')
    return a:mode
endfunction
map <expr> p Paste('p')
map <expr> P Paste('P')


"Themes Config
"let g:onedark_style = 'cool'
"colorscheme onedark
colorscheme nord
"theme = 'onedark'

" options = {theme = 'material'}
lua << EOF
require('lualine').setup {
  options = {
      theme = 'nord'
  }
}
EOF
syntax on
filetype on
filetype plugin indent on




"my set commands
set laststatus=2
set t_Co=256
set t_ut=
set number
set encoding=utf-8
set fileencoding=utf-8
set tabstop=4
set shiftwidth=4
set softtabstop=4
set colorcolumn=80
set expandtab
set mouse=a
set visualbell
set splitbelow splitright
set completeopt-=preview
set viminfo='25,\"50,n~/.viminfo
autocmd FileType html setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType css setlocal tabstop=2 shiftwidth=2 softtabstop=2
" auto-pairs
au FileType python let b:AutoPairs = AutoPairsDefine({"f'" : "'", "r'" : "'", "b'" : "'"})




" wrap toggle
setlocal nowrap
function ToggleWrap()
    if &wrap
        echo "Wrap OFF"
        setlocal nowrap
        set virtualedit=all
        silent! nunmap <buffer> <Up>
        silent! nunmap <buffer> <Down>
        silent! nunmap <buffer> <Home>
        silent! nunmap <buffer> <End>
        silent! iunmap <buffer> <Up>
        silent! iunmap <buffer> <Down>
        silent! iunmap <buffer> <Home>
        silent! iunmap <buffer> <End>
    else
        echo "Wrap ON"
        setlocal wrap linebreak nolist
        set virtualedit=
        setlocal display+=lastline
        noremap  <buffer> <silent> <Up>   gk
        noremap  <buffer> <silent> <Down> gj
        noremap  <buffer> <silent> <Home> g<Home>
        noremap  <buffer> <silent> <End>  g<End>
        inoremap <buffer> <silent> <Up>   <C-o>gk
        inoremap <buffer> <silent> <Down> <C-o>gj
        inoremap <buffer> <silent> <Home> <C-o>g<Home>
        inoremap <buffer> <silent> <End>  <C-o>g<End>
    endif
endfunction
" restore place in file from previous session
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif





"file browser
let NERDTreeMinimalUI = 1
let g:nerdtree_open = 0
function NERDTreeToggle()
    NERDTreeTabsToggle
    if g:nerdtree_open == 1
        let g:nerdtree_open = 0
    else
        let g:nerdtree_open = 1
        wincmd p
    endif
endfunction
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
 " Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" NERDTree Git Plugin
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
" startify
let g:startify_enable_special = 0
let g:startify_custom_header = [  
  \'  _________.__                             .___.__           ________.__                 .__     ',
  \' /   _____/|  |__  __ _____  _______     __| _/|__|_____    /  _____/|  |__   ____  _____|  |__  ',
  \' \_____  \ |  |  \|  |  \  \/ /\__  \   / __ | |  \____ \  /   \  ___|  |  \ /  _ \/  ___/  |  \ ',
  \' /        \|   Y  \  |  /\   /  / __ \_/ /_/ | |  |  |_> > \    \_\  \   Y  (  <_> )___ \|   Y  \ ',
  \'/_______  /|___|  /____/  \_/  (____  /\____ | |__|   __/   \______  /___|  /\____/____  >___|  /',
  \'        \/      \/                  \/      \/    |__|             \/     \/           \/     \/ ',
  \]
"Auto save lugin
let g:auto_save = 1 
let g:auto_save_events = ["InsertLeave", "TextChanged","TextChangedI"]

"start up config
function! StartUp()
    if 0 == argc()
        :call ToggleWrap()
        " :NERDTreeToggle
        " :vertical resize 23
    else
        " :NERDTreeToggle
        " :vertical resize 23
        " :wincmd l
    endif
endfunction
autocmd VimEnter * call StartUp()


