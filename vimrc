" ---- core settings ----
set nocompatible
set encoding=utf-8
scriptencoding utf-8


" UI
set number
set relativenumber
set cursorline
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

set nu
set shiftwidth=2 expandtab
set tabstop=8 softtabstop=0

" Clipboard & mouse
if has('unnamedplus')
  set clipboard=unnamedplus
endif
set mouse=a

call plug#begin()

" List your plugins here
Plug 'tpope/vim-sensible'
Plug 'prabirshrestha/vim-lsp'
Plug 'tpope/vim-sleuth'
Plug 'scrooloose/nerdcommenter'
Plug 'jbgutierrez/vim-better-comments'
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'valloric/youcompleteme'
Plug 'crusoexia/vim-monokai'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'preservim/vim-markdown'


" Autopairs
Plug 'jiangmiao/auto-pairs'

" Icons (optional but nice if your terminal supports Nerd Font)
Plug 'ryanoasis/vim-devicons'

" Optional: file tree (you can also use coc-explorer instead)
Plug 'preservim/nerdtree'


" Git, file ops, motions, comments
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'


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


let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

" lua stuff
set autoread
autocmd BufWritePost *.lua silent! !python3 ~/.config/lua-format.py <afile>
autocmd BufWritePost *.lua redraw!
autocmd BufWritePost *.c silent! !clang-format -i --style=google <afile>
autocmd BufWritePost *.c redraw!
autocmd BufWritePost *.h silent! !clang-format -i --style=google <afile>
autocmd BufWritePost *.h redraw!
autocmd BufWritePost *.cpp silent! !clang-format -i --style=google <afile>
autocmd BufWritePost *.cpp redraw!

" ctrl + l/r moves tabs
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

let g:vim_markdown_folding_disabled = 1
let g:ycm_gopls_binary_path = '/home/zns/go/bin/gopls'
let g:ycm_show_diagnostics_ui = 0
let g:lsp_diagnostics_enabled = 0
let g:lsp_diagnostics_echo_cursor = 0
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_math = 1

" lsp
au User lsp_setup call lsp#register_server({
    \ 'name': 'zuban',
    \ 'cmd': ['zuban', 'server'],
    \ 'allowlist': ['python'],
\ })
