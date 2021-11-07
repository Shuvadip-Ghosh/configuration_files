" plugins
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'navarasu/onedark.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/indentpython.vim'
Plug 'neoclide/coc.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'glepnir/dashboard-nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'romgrk/barbar.nvim'
call plug#end()


"all key mappings
imap <C-b> <esc>:NERDTreeToggle<right><CR> :wincmd l <CR>i
map <C-b> :NERDTreeToggle<CR> :wincmd l <CR>i
imap <C-s> <esc>:w<cr>i
map <C-s> :w<cr>i
imap <C-q> <esc>:wq <CR>
map <C-q> :wq <CR>
imap <c-z> <esc>u i
map <C-z> u i
imap <C-d> <esc>:call ToggleWrap()<CR>
map <C-d> :call ToggleWrap()<CR>
imap <c-n> <esc> :!touch
map <c-n> :!touch
map <c-r> :NERDTreeRefreshRoot <cr>
imap <c-r> :NERDTreeRefreshRoot <cr>
autocmd FileType python imap <F9> <esc> :!python % <cr>
autocmd FileType python map <F9> :!python % <cr>

vmap <Tab> >>
vmap <S-tab> <<
nmap <Tab> :bp <cr>
" move through split windows
nmap <C-Up> :wincmd k<CR>
nmap <C-Down> :wincmd j<CR>
nmap <C-Left> :wincmd h<CR>
nmap <C-Right> :wincmd l<CR>

" move through buffers
nmap <leader>[ :bp!<CR>
nmap <leader>] :bn!<CR>
nmap <leader>x :bp<bar>bd#<CR>

" color scheme
syntax on
filetype on
filetype plugin indent on

let g:dashboard_default_executive ='telescope'
nmap <Leader>ss :<C-u>SessionSave<CR>
nmap <Leader>sl :<C-u>SessionLoad<CR>
nnoremap <silent> <Leader>fh :DashboardFindHistory<CR>
nnoremap <silent> <Leader>ff :DashboardFindFile<CR>
nnoremap <silent> <Leader>tc :DashboardChangeColorscheme<CR>
nnoremap <silent> <Leader>fa :DashboardFindWord<CR>
nnoremap <silent> <Leader>fb :DashboardJumpMark<CR>
nnoremap <silent> <Leader>cn :DashboardNewFile<CR>



let g:onedark_style = 'cool'
colorscheme onedark


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

let g:is_mouse_enabled = 1
noremap <silent> <Leader>m :call ToggleMouse()<CR>
function ToggleMouse()
    if g:is_mouse_enabled == 1
        echo "Mouse OFF"
        set mouse=
        let g:is_mouse_enabled = 0
    else
        echo "Mouse ON"
        set mouse=a
        let g:is_mouse_enabled = 1
    endif
endfunction


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

" file browser
let NERDTreeMinimalUI = 1
let g:nerdtree_open = 0
map <leader>n :call NERDTreeToggle()<CR>
function NERDTreeToggle()
    NERDTreeTabsToggle
    if g:nerdtree_open == 1
        let g:nerdtree_open = 0
    else
        let g:nerdtree_open = 1
        wincmd p
    endif
endfunction

function! StartUp()
    if 0 == argc()
        ":NERDTreeToggle
        :vertical resize 23
    else
        ":NERDTreeToggle
        :vertical resize 23
        :wincmd l
    endif
endfunction
autocmd VimEnter * call StartUp()
