" ---------------------------------------------
" vim: filetype=vim
" File: ~/.vim/plugin/vim-airline.vim
" Title: Vim-Airline
" Maintainer: Ernie Lin
" Update: 2026/05/03
" ---------------------------------------------

" Hide tabline when only one tab is open.
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#tab_nr_type = 1

" Enable extensions.
let g:airline#extensions#ale#enabled = 1        " Show ALE errors in statusline.
let g:airline#extensions#branch#enabled = 1     " Show git branch.
let g:airline#extensions#hunks#enabled = 1      " Show git diff stats.
let g:airline#extensions#whitespace#enabled = 0 " Disable whitespace warnings (ALE handles it).

" Use powerline fonts.
let g:airline_powerline_fonts = 1

" Powerline symbols.
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
