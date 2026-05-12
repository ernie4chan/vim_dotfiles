" ---------------------------------------------
" vim: filetype=vim
" File: ~/.vim/plugin/vifm_for_vifm.com
" Title: vifm for Vim
" Maintainer: Ernie Lin
" Update: 20260503
" ---------------------------------------------

packadd vifm.vim

" Vifm file picker.
nnoremap <leader>vv :EditVifm<cr>       " Open in current window.
nnoremap <leader>vh :SplitVifm<cr>      " Open in horizontal split.
nnoremap <leader>vs :VsplitVifm<cr>     " Open in vertical split.
nnoremap <leader>vt :TabVifm<cr>        " Open in new tab.
nnoremap <leader>vd :DiffVifm<cr>       " Open diff view.
