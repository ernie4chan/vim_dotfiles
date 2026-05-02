" ---------------------------------------------
" vim: filetype=vim
" Title: Vim-DevIcons
" File: vim-devicons.vim
" Maintainer: Ernie Lin
" Update: 2026/05/03
" ---------------------------------------------

" Adding to Vim-Airline's tabline.
let g:webdevicons_enable_airline_tabline = 1

" Adding to Vim-Airline's statusline.
let g:webdevicons_enable_airline_statusline = 1

" Enable in NERDTree.
let g:webdevicons_enable_nerdtree = 1

" Enable in fzf.
let g:webdevicons_enable_fzf = 1

" Force re-render after colorscheme change.
autocmd ColorScheme * if exists("*WebDevIconsReloadAfterColorSchemeChange")
    \ | call WebDevIconsReloadAfterColorSchemeChange()
    \ | endif
