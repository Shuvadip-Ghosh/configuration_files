" plugins
call plug#begin()
"Plug 'dense-analysis/ale' for line correction
Plug 'tpope/vim-sensible'
Plug 'itchyny/lightline.vim'
Plug 'joshdick/onedark.vim'
Plug 'ap/vim-buftabline'
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jiangmiao/auto-pairs'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/indentpython.vim'
Plug 'lepture/vim-jinja'
Plug 'alvan/vim-closetag'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'davidhalter/jedi-vim'
"Plug 'vim-scripts/AutoComplPop' "this is for autocompletion
call plug#end()

filetype plugin indent on
syntax on

let g:jedi#completions_enabled = 1
let g:jedi#auto_initialization = 1
"all key mappings
imap <C-b> <esc>:NERDTreeToggle<right><CR>
map <C-b> :NERDTreeToggle<CR> i
imap <C-w> <esc>:w<cr>i
map <C-w> :w<cr>i
imap <C-n> <esc>:wq <CR>
map <C-n> :wq <CR>
imap <c-z> <esc>u i
map <C-z> u i
imap <C-a> <esc> gg v G
map <C-a> <esc> gg v G
vmap <C-c> y
map <C-v> :TagbarToggle<CR>
imap <F9> <esc> :!python3 % <cr>
map <F9> <esc> :!python3 % <cr>


imap <Left> <Esc>bi
nmap <Left> b
imap <Right> <Esc><Right>wi
nmap <Right> w

nmap <Tab> >>
nmap <S-tab> <<
imap <S-Tab> <Esc><<i

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

" color scheme
syntax on
colorscheme onedark
filetype on
filetype plugin indent on
set noshowmode
let g:lightline = { 'colorscheme': 'onedark' }

"code folding
set foldmethod=indent
set foldlevel=99

" wrap toggle
setlocal nowrap
noremap <silent> <Leader>w :call ToggleWrap()<CR>
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

" move through split windows
nmap <leader><Up> :wincmd k<CR>
nmap <leader><Down> :wincmd j<CR>
nmap <leader><Left> :wincmd h<CR>
nmap <leader><Right> :wincmd l<CR>

" move through buffers
nmap <leader>[ :bp!<CR>
nmap <leader>] :bn!<CR>
nmap <leader>x :bp<bar>bd#<CR>

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
        NERDTree
    end
endfunction
autocmd VimEnter * call StartUp()

" disable autoindent when pasting text
" source: https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
