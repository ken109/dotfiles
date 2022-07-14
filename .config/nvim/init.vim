set number
set tabstop=4
set shiftwidth=4
set autoindent
set expandtab

let mapleader = "\<Space>"

call plug#begin('~/.vim/plugged')
    Plug 'preservim/nerdcommenter'
    Plug 'phanviet/vim-monokai-pro'
    Plug 'itchyny/lightline.vim'
    Plug 'maximbaz/lightline-ale'
    Plug 'Yggdroot/indentLine'
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    Plug 'xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
    Plug 'ryanoasis/vim-devicons'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-rooter'
    Plug 'dense-analysis/ale'
    Plug 'sheerun/vim-polyglot'
    Plug 'mbbill/undotree'
    Plug 'easymotion/vim-easymotion'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'jiangmiao/auto-pairs'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'rust-lang/rust.vim'
    Plug 'github/copilot.vim'
call plug#end()

colorscheme monokai_pro

" nnoremap d "_d
" xnoremap d "_d
" xnoremap p "_dP

" undotree
nmap <C-z> :UndotreeShow<CR>:UndotreeFocus<CR>

" nerdtree
let NERDTreeShowHidden=1
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
