" ---------------------------------------------
" vim: filetype=vim
" File: ~/.vim/plugin/vim-airline.vim
" Title: Vim-Airline
" Maintainer: Ernie Lin
" Update: 20260503
" ---------------------------------------------

" --- Tabline ---
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1				" Show ALE errors in statusline.
let g:airline#extensions#branch#enabled = 1				" Show git branch.
let g:airline#extensions#hunks#enabled = 1				" Show git diff stats.
let g:airline#extensions#tabline#formatter = 'unique_tail'	" Smarter filename display (shows parent dir on conflict).
let g:airline#extensions#whitespace#enabled = 0			" Disable whitespace warnings (ALE handles it).
let g:airline#extensions#tabline#fnamecollapse = 1		" Collapse long paths.
let g:airline#extensions#tabline#fnamemod = ':p'		" Show full path.

" --- Tabs ---
let g:airline#extensions#tabline#show_close_button = 0	" Remove close button.
let g:airline#extensions#tabline#show_tab_count = 0		" Don't show tab numbers on the right.
let g:airline#extensions#tabline#show_tab_nr = 1		" Enable tab number display.
let g:airline#extensions#tabline#show_tab_type = 1 		" Show tab type (tab/buf).
let g:airline#extensions#tabline#show_tabs = 1			" Show tabs.
let g:airline#extensions#tabline#tab_min_count = 2		" Show when 2+ tabs open.
let g:airline#extensions#tabline#tab_nr_type = 1		" Show both tab index.

" --- Buffers ---
let g:airline#extensions#tabline#show_buffers = 1		" Display buffers.
let g:airline#extensions#tabline#buffer_min_count = 2	" Show when 2+ buffers open.
let g:airline#extensions#tabline#buffer_nr_show = 1		" Show buffer number.
let g:airline#extensions#tabline#buffer_nr_format = '%s:' " Format: '1: filename'
	" '%s: '	→ 1: filename
	" '[%s] '	→ [1] filename
	" '%s '		→ 1 filename

" --- Powerline fonts ---
let g:airline_powerline_fonts = 1

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
