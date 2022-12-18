set number
set tabstop=2
set belloff=all

syntax on

# Auto complete brackets
inoremap { {}<Esc>ha
inoremap ( ()<Esc>ha
inoremap [ []<Esc>ha
inoremap " ""<Esc>ha
inoremap ' ''<Esc>ha
inoremap ` ``<Esc>ha

# Plugins for vim 
call plug#begin('~/.vim/plugged')

Plug 'elzr/vim-json'
Plug 'bluz71/vim-moonfly-colors', { 'branch': 'cterm-compat' }
Plug 'tpope/vim-fugitive'

call plug#end()

