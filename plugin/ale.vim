" ---------------------------------------------
" vim: filetype=vim
" File: ~/.vim/plugin/ale.vim
" Title: ALE (Asynchronous Lint Engine)
" Maintainer: Ernie Lin
" Update: 2026/05/03
" ---------------------------------------------

" Global fixers:
" Reference page for Python fixers:
" 'https://sourcery.ai/blog/python-best-practices/'
let g:ale_fixers = {
	\ '*': [ 'remove_trailing_lines', 'trim_whitespace' ],
	\ 'javascript': ['prettier', 'eslint'],
	\ 'python': [ 'black'],
\ }

" Fix on save.
let g:ale_fix_on_save = 1

" Lint on save only, not while typing.
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0

" Suppress whitespace warnings (handled by fixers).
let g:ale_warn_about_trailing_whitespace = 0

" Show errors in the statusline.
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" Navigate between errors.
nnoremap ]a :ALENextWrap<cr>
nnoremap [a :ALEPreviousWrap<cr>
