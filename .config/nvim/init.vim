set number
set tabstop=4
set shiftwidth=4
set autoindent
set expandtab

let mapleader = "\<Space>"

nmap <C-z> :UndotreeShow<CR>:UndotreeFocus<CR>

call plug#begin('~/.vim/plugged')
    Plug 'preservim/nerdcommenter'
    Plug 'phanviet/vim-monokai-pro'
    Plug 'itchyny/lightline.vim'
    Plug 'Yggdroot/indentLine'
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    Plug 'junegunn/fzf', { 'dir': '~/.config/nvim/fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-rooter'
    Plug 'dense-analysis/ale'
    Plug 'xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
    Plug 'sheerun/vim-polyglot'
    Plug 'tpope/vim-commentary'
    Plug 'mbbill/undotree'
    Plug 'easymotion/vim-easymotion'
    Plug 'tpope/vim-surround'
    Plug 'jiangmiao/auto-pairs'
    Plug 'maximbaz/lightline-ale'
call plug#end()

colorscheme monokai_pro

" nerdtree
nmap <silent> <C-e> :NERDTreeToggle<CR>

" easy motion
map s <Plug>(easymotion-bd-f2)
nmap s <Plug>(easymotion-overwin-f2)

" ale
let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ }
let g:ale_fix_on_save = 1

" lightline
let g:lightline = {'colorscheme': 'monokai_pro'}
let g:lightline.component_expand = {
  \   'linter_checking': 'lightline#ale#checking',
  \   'linter_warnings': 'lightline#ale#warnings',
  \   'linter_errors': 'lightline#ale#errors',
  \   'linter_ok': 'lightline#ale#ok',
  \ }
let g:lightline.component_type = {
  \   'linter_checking': 'left',
  \   'linter_warnings': 'warning',
  \   'linter_errors': 'error',
  \   'linter_ok': 'left',
  \ }
let g:lightline.active = {
  \   'left': [
  \     ['mode', 'paste'],
  \     ['readonly', 'filename', 'modified'],
  \     ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok'],
  \   ]
  \ }
