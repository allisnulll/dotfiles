colorscheme koehler

set number
set relativenumber
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smartindent
set nowrap
set hlsearch
set scrolloff=4
set cursorline
set ignorecase
set smartcase
set termguicolors
set background=dark
set signcolumn=yes
set colorcolumn=80
set splitright
set splitbelow
set backspace=indent,eol,start
set noswapfile
set undodir=$HOME/.vim/undodir
set undofile
set updatetime=500

set listchars=space:◦,tab:»—,extends:→,precedes:←,nbsp:␣,trail:×,eol:⏎

let g:netrw_browse_split = 0
let g:netrw_winsize = 25

augroup HelpBuffer
  autocmd!
  autocmd FileType help only
augroup END

augroup TwoSpaceGroup
  autocmd!
  autocmd FileType dart,yaml,scheme setlocal tabstop=2 shiftwidth=2 softtabstop=2
augroup END

augroup TabGroup
  autocmd!
  autocmd FileType txt,go,makefile,haskell setlocal expandtab=no
augroup END

augroup HighlightYank
  autocmd!
augroup END

let g:conjure#highlight#enabled = 1

nnoremap <C-e> :Ex<CR>

nnoremap <leader>nh :nohlsearch<CR>
nnoremap <leader>ol :set list!<CR>
nnoremap <leader>ot :set expandtab!<CR>
nnoremap <leader>or :set relativenumber!<CR>
nnoremap <leader>oh :set hlsearch!<CR>
nnoremap <leader>ow :set wrap!<CR>

inoremap <C-Space> \u{00A0}

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv

nnoremap <C-w>< <C-w>5<
nnoremap <C-w>> <C-w>5>
nnoremap <C-w>+ <C-w>2+
nnoremap <C-w>- <C-w>2-

nnoremap <leader>j :cnext<CR>zz
nnoremap <leader>k :cprev<CR>zz
nnoremap <C-j> :lnext<CR>zz
nnoremap <C-k> :lprev<CR>zz

nnoremap Y y$

vnoremap <C-j> :move '>+1<CR>gv=gv
vnoremap <C-k> :move '<-2<CR>gv=gv

nnoremap <C-s> :s/\(\w.*\)//
nnoremap <leader>s :%s/<C-r><C-w>//g<Left><Left>
