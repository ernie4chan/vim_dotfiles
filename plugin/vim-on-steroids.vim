" ---------------------------------------------------------
" File: vim-on-steroids.vim
" Maintainer: Ernie Lin
" ---------------------------------------------------------

" {{{ --- 1. ALE (Asynchronous Lint Engine). ---

" {{{2 --- Some explanations. ---

" Reference page:
"	https://sourcery.ai/blog/python-best-practices/
" * Flake8 ensures our code follows the standard python conventions
"    as defined in PEP8.
" * Black is the uncompromising Python code formatter.
" * isort your python imports for you so you don't have to.
" * Mypy is an optional static type checker for Python that aims to combine
"    the benefits of dynamic (or 'duck') typing and static typing.
" * Writing tests with pytest and pytest-cov are incredibly easy and removing
"    any friction to writing tests means we will write more of them!

" 2}}}

" Enable Global Linters and Fixers:
let g:ale_fixers = {
	\ '*': [ 'remove_trailing_lines', 'trim_whitespace' ],
	\ 'python': [ 'black', 'isort' ],
	\ 'javascript': ['eslint'],
\ }

" Automatically fix files when you save.
let g:ale_fix_on_save = 1
" Run linters when you save.
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
" Don't run linters on opening a file.
let g:ale_lint_on_enter = 0
" Enable completion where available. This setting must be set before ALE is loaded.
let g:ale_completion_enabled = 1

" }}}

" {{{ --- 2. Vim-DevIcons. ---

if has("mac")
	let g:WebDevIconsOS = 'Darwin'
endif

" }}}

" {{{ --- 3. Vim-Fugitive. ---
" }}}

" {{{ --- 4. Vim-Surround. ---
" }}}

" {{{ --- 5. FZF for Vim. ---

" Set Run-time path.
if has("mac")
	set runtimepath+=/usr/local/opt/fzf
elseif has('linux')
	set runtimepath+=/usr/bin/fzf
endif

packadd fzf.vim

" Hide statusline while FZFing.
au! FileType fzf set laststatus=0 noshowmode noruler
			\ | au BufLeave <buffer> set laststatus=2 showmode ruler

" Layout.  See `man fzf-tmux` for available options
let g:fzf_layout = { 'down': '40%' }

" Preview window.
let g:fzf_preview_window = []

" [Buffers] Jump to the existing window if possible.
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log'.
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" FZF Mapping selecting mappings.
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" FZF Insert mode completion.
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

" }}}

" {{{ --- 6. Vifm for Vim. ---

packadd vifm.vim

" }}}
