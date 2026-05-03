" ---------------------------------------------
" vim: filetype=vim
" File: ~/.vim/plugin/vim-airline.vim
" Title: Vim-Airline
" Maintainer: Ernie Lin
" Update: 2026/05/03
" ---------------------------------------------

" --- Tabline ---
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_close_button = 0  " Remove close button.
let g:airline#extensions#tabline#tab_nr_type = 1        " Show tab number.

" --- Tabs ---
"let g:airline#extensions#tabline#show_tabs = 1          " Always show tabs.
let g:airline#extensions#tabline#tab_min_count = 2      " Show when 2+ tabs open.

" --- Buffers ---
let g:airline#extensions#tabline#show_buffers = 1       " Show buffers in tabline.
"let g:airline#extensions#tabline#buffer_nr_show = 1     " Show buffer number.
let g:airline#extensions#tabline#buffer_min_count = 2   " Show when 2+ buffers open.
"let g:airline#extensions#tabline#buffers_label = 'B'    " Buffers section label.
"let g:airline#extensions#tabline#buf_label_first = 1    " Show label on left.

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
