" ---- core settings ----
set nocompatible
set encoding=utf-8
scriptencoding utf-8

" UI
set number
set relativenumber
set cursorline
set signcolumn=yes
set termguicolors
set background=dark
set title
set laststatus=2
set showmode
set showcmd

" Editing & files
set hidden
set undofile
if !isdirectory($HOME.'/.vim/undo')
  call mkdir($HOME.'/.vim/undo', 'p')
endif
set undodir=~/.vim/undo
set swapfile
set updatetime=300

" Search
set ignorecase
set smartcase
set incsearch
set hlsearch

" Indentation
set expandtab
set tabstop=2
set shiftwidth=2
set smartindent
filetype plugin indent on
syntax on

" Clipboard & mouse
if has('unnamedplus')
  set clipboard=unnamedplus
endif
set mouse=a

" Performance niceties
set lazyredraw
set ttyfast

" Leader
let mapleader=" "

" Quick quality-of-life maps
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>h :nohlsearch<CR>
nnoremap <leader>e :CocCommand explorer<CR>

" ===========================
" Plugins
" ===========================
call plug#begin('~/.vim/plugged')

" Colorscheme: Monokai
Plug 'sickill/vim-monokai'          " classic Monokai for Vim

" LSP-like IntelliSense via coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Git, file ops, motions, comments
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'

" Statusline
Plug 'itchyny/lightline.vim'

" Fuzzy find (requires ripgrep for :Rg)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Autopairs
Plug 'jiangmiao/auto-pairs'

" Icons (optional but nice if your terminal supports Nerd Font)
Plug 'ryanoasis/vim-devicons'

" Optional: file tree (you can also use coc-explorer instead)
Plug 'preservim/nerdtree'

call plug#end()

" ===========================
" Colors & theme
" ===========================
colorscheme monokai

" Lightline theme to match
let g:lightline = {
\ 'colorscheme': 'wombat',
\ 'active': { 'left': [ [ 'mode', 'paste' ], [ 'gitbranch', 'readonly', 'filename', 'modified' ] ] },
\ 'component_function': { 'gitbranch': 'FugitiveHead' }
\ }

" ===========================
" coc.nvim configuration
" ===========================
" Auto-install these extensions on first run
let g:coc_global_extensions = [
\ 'coc-json',
\ 'coc-yaml',
\ 'coc-snippets',
\ 'coc-pyright',
\ 'coc-go',
\ 'coc-tsserver',
\ 'coc-sh',
\ 'coc-prettier',
\ 'coc-explorer'
\ ]

" Completion behavior
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <silent><expr> <S-TAB>
      \ pumvisible() ? "\<C-p>" : coc#pum#prev(1)
inoremap <expr> <CR> pumvisible() ? coc#pum#confirm() : "\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Go-to & code actions
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>ca <Plug>(coc-codeaction)
xmap <leader>ca <Plug>(coc-codeaction-selected)
nmap <leader>f  <Plug>(coc-format)
nmap <leader>qf <Plug>(coc-fix-current)

" Diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> <leader>d :<C-u>CocList diagnostics<CR>

" Hover docs
nnoremap <silent> K :call CocActionAsync('doHover')<CR>

" Symbols & workspace
nnoremap <silent> <leader>o :CocOutline<CR>
nnoremap <silent> <leader>s :<C-u>CocList -I symbols<CR>

" Use Black for Python format-on-save (via coc)
autocmd FileType python nnoremap <buffer> <leader>bf :CocCommand python.sortImports<CR>|:CocCommand editor.action.formatDocument<CR>
" Use goimports via gopls format-on-save
autocmd BufWritePre *.go :silent! call CocAction('format')

" Snippets
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)
" (Add your own snippets in ~/.config/coc/ultisnips or use coc-snippets defaults)

" ===========================
" FZF convenience mappings
" ===========================
nnoremap <leader>p :Files<CR>
nnoremap <leader>rg :Rg<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>t :Tags<CR>

" Prefer ripgrep for :Rg
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
endif

" ===========================
" Language-specific niceties
" ===========================
" Python: 4 spaces
autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab
" Go: tabs width 4 (Go standard)
autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4

" ===========================
" Misc quality-of-life
" ===========================
" Toggle NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>

" Save file with sudo if needed
cmap w!! w !sudo tee % >/dev/null

" Remember last position
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Switch buffers with Ctrl-Left / Ctrl-Right
nnoremap <C-Left>  :bprevious<CR>
nnoremap <C-Right> :bnext<CR>
