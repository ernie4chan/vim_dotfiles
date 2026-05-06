" ---------------------------------------------
" vim: filetype=vim
" File: ~/.vim/plugin/vim-devicons.vim
" Title: Vim-DevIcons
" Maintainer: Ernie Lin
" Update: 2026/05/03
" ---------------------------------------------

" Adding to Vim-Airline's tabline.
let g:webdevicons_enable_airline_tabline = 1
" Adding to Vim-Airline's statusline.
let g:webdevicons_enable_airline_statusline = 1

" Enable in fzf.
let g:webdevicons_enable_fzf = 1

" Customize icon padding.
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
" Decorate folder nodes with icons.
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

" Force re-render after colorscheme change.
autocmd ColorScheme * if exists("*WebDevIconsReloadAfterColorSchemeChange")
	\ | call WebDevIconsReloadAfterColorSchemeChange()
	\ | endif
