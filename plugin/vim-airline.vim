" ---------------------------------------------
" vim: filetype=vim
" File: Vim-Airline
" Maintainer: Ernie Lin
" Update: 2026/05/03
" ---------------------------------------------

" Enable tabline.
let g:airline#extensions#tabline#enabled = 1

" Use tabline for buffer switching.
let g:airline#extensions#tabline#buffer_nr_show = 1

" Use powerline fonts.
let g:airline_powerline_fonts = 1

" Enable extensions.
let g:airline#extensions#ale#enabled = 1        " Show ALE errors in statusline.
let g:airline#extensions#branch#enabled = 1     " Show git branch.
let g:airline#extensions#hunks#enabled = 1      " Show git diff stats.
let g:airline#extensions#whitespace#enabled = 0 " Disable whitespace warnings (ALE handles it).

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
