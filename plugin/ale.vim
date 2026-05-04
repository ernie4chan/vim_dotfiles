" ---------------------------------------------
" vim: filetype=vim
" File: ~/.vim/plugin/ale.vim
" Title: ALE (Asynchronous Lint Engine)
" Maintainer: Ernie Lin
" Update: 2026/05/03
" ---------------------------------------------

" --- Fixers (cure) ---
" Reference: https://sourcery.ai/blog/python-best-practices/
let g:ale_fixers = {
	\ '*':          ['remove_trailing_lines', 'trim_whitespace'],
	\ 'python':     ['black'],
\ }
let g:ale_fix_on_save = 1					" Automatically fix files on save.

" --- Linters (diagnose) ---
let g:ale_linters = {
	\ 'python': ['flake8'],
\ }
let g:ale_linters_explicit = 1				" Only run explicitly defined linters.
let g:ale_lint_on_text_changed = 'never'	" Don't lint while typing.
let g:ale_lint_on_insert_leave = 0			" Don't lint when leaving insert mode.
let g:ale_lint_on_enter = 0					" Don't lint when opening a file.

" --- Display ---
let g:ale_warn_about_trailing_whitespace = 0				" Suppress whitespace warnings.
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'	" Error message format.
let g:ale_sign_error = '✗'									" Error sign in gutter.
let g:ale_sign_warning = '⚠'								" Warning sign in gutter.
let g:ale_virtualtext_cursor = 1							" Show errors inline next to code.

" --- Navigate between errors ---
nnoremap ]a :ALENextWrap<cr>
nnoremap [a :ALEPreviousWrap<cr>
