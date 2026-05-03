" ---------------------------------------------
" vim: filetype=vim
" File: ~/.vim/plugin/vim-airline.vim
" Title: Vim-Airline
" Maintainer: Ernie Lin
" Update: 2026/05/03
" ---------------------------------------------

" --- Tabline ---
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_close_button = 0	" Remove close button.
let g:airline#extensions#tabline#show_tab_type = 1 		" Show tab type (tab/buf).

" --- Tabs ---
let g:airline#extensions#tabline#tab_min_count = 2		" Show when 2+ tabs open.
let g:airline#extensions#tabline#tab_nr_type = 1		" Show tab number.

" --- Buffers ---
let g:airline#extensions#tabline#buffer_min_count = 2	" Show when 2+ buffers open.
let g:airline#extensions#tabline#buffer_nr_show = 1	" Show buffer number.

" --- Extensions ---
let g:airline#extensions#ale#enabled = 1				" Show ALE errors in statusline.
let g:airline#extensions#branch#enabled = 1				" Show git branch.
let g:airline#extensions#hunks#enabled = 1				" Show git diff stats.
let g:airline#extensions#whitespace#enabled = 0			" Disable whitespace warnings (ALE handles it).

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
