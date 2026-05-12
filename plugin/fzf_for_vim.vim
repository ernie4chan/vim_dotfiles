" ---------------------------------------------
" vim: filetype=vim
" File: ~/.vim/plugin/fzf_for_vim.vim
" Title: fzf for Vim
" Maintainer: Ernie Lin
" Update: 20260503
" ---------------------------------------------

" Set Run-time path.
if has('linux')
    set runtimepath+=/usr/bin/fzf
elseif has("mac")
    set runtimepath+=/usr/local/opt/fzf
endif

" Load plugin.
packadd fzf.vim

" Hide statusline while fzf is active.
autocmd! FileType fzf set laststatus=0 noshowmode noruler
        \ | autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" Layout.  See `man fzf-tmux` for available options
let g:fzf_layout = { 'window': { 'width': 1.0, 'height': 0.7, }}

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--margin=1']}, <bang>0)

" Disable preview window.
let g:fzf_preview_window = []

" [Buffers] Jump to the existing window if possible.
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log'.
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" fzf Mapping selecting mappings.
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" fzf Insert mode completion.
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Fuzzy find files.
nnoremap <leader>ff     :Files<cr>

" Fuzzy find buffers.
nnoremap <leader>fb     :Buffers<cr>

" Fuzzy find in current file.
nnoremap <leader>fv     :BLines<cr>

" Fuzzy find command history.
nnoremap <leader>fh     :History:<cr>

" Fuzzy find search history.
nnoremap <leader>fs     :History/<cr>
