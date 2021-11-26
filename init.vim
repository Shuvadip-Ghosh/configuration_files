" plugins
call plug#begin()
"Plug 'dense-analysis/ale' for line correction
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'navarasu/onedark.nvim'
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
call plug#end()


"all key mappings
imap jk <esc>
imap <C-b> <esc>:NERDTreeToggle<right><CR> :wincmd l <CR>i
map <C-b> :NERDTreeToggle<CR> :wincmd l <CR>i
imap <C-s> <esc>:w<cr>li
map <C-s> :w<cr>i
imap <C-q> <esc>:wq <CR>
map <C-q> :wq <CR>
imap <c-z> <esc>u i
map <C-z> u i
imap <C-d> <esc>:call ToggleWrap()<CR>
map <C-d> :call ToggleWrap()<CR>
imap <c-n> <esc> :!touch
nmap <c-n> :!touch
map <c-R> :NERDTreeRefreshRoot <cr>
vmap <c-h> gcc <esc> i
map <c-h> gcc <esc> i
vmap <c-g> gc <esc> i
map <c-g> gc <esc> i
imap <c-R> <esc> :NERDTreeRefreshRoot <cr>
nnoremap <C-l> :vsplit $MYVIMRC<cr>
autocmd FileType python imap <F9> <esc> :!python % <cr>
autocmd FileType python map <F9> :!python % <cr>

vmap <Tab> >>
vmap <S-tab> <<
nmap <Tab> :bp <cr>
nmap <C-Up> :wincmd k<CR>
nmap <C-Down> :wincmd j<CR>
nmap <C-Left> :wincmd h<CR>
nmap <C-Right> :wincmd l<CR>

" move through buffers
nmap <leader>[ :bp!<CR>
nmap <leader>] :bn!<CR>
nmap <leader>x :bp<bar>bd#<CR>





"Themes Config
let g:onedark_style = 'cool'
colorscheme onedark
" options = {theme = 'material'}
lua << EOF
require('lualine').setup {
  options = {
    theme = 'onedark',
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
set fileformat=unix
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


"Auto save lugin
let g:auto_save = 1
let g:auto_save_events = ["InsertLeave", "TextChanged","TextChangedI"]

"start up config
function! StartUp()
    if 0 == argc()
        :NERDTreeToggle
        :vertical resize 23
    else
        :NERDTreeToggle
        :vertical resize 23
        :wincmd l
    endif
endfunction
autocmd VimEnter * call StartUp()
