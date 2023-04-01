" ---------------------------------------------
" File: ~/.vim/plugin/vim-on-steroids.vim
" Maintainer: Ernie Lin
"
" Update: 2022-06-08
" ---------------------------------------------

" {{{ 1. ALE (Asynchronous Lint Engine).

" Enable Global Linters and Fixers:
" Reference page for Python fixers:
" 'https://sourcery.ai/blog/python-best-practices/'
let g:ale_fixers = {
	\ '*': [ 'remove_trailing_lines', 'trim_whitespace' ],
	\ 'javascript': ['prettier', 'eslint'],
	\ 'python': [ 'black'],
\ }

" Automatically fix files when you save.
let g:ale_fix_on_save = 1

" Run linters when you save.
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0

" Don't run linters on opening a file.
let g:ale_lint_on_enter = 0

" Disable whitespace warnings
let g:ale_warn_about_trailing_whitespace = 0

" }}}

" {{{ 2. Vim-DevIcons.

if has("mac")
	let g:WebDevIconsOS = 'Darwin'
endif

" Adding to Vim-Airline's tabline.
let g:webdevicons_enable_airline_tabline = 1

" Adding to Vim-Airline's statusline.
let g:webdevicons_enable_airline_statusline = 1

" }}}

" {{{ 3. Vim-Fugitive.
" }}}

" {{{ 4. Vim-Surround.
" }}}

" {{{ 5. fzf for Vim.

" Set Run-time path.
if has("mac")
	set runtimepath+=/usr/local/opt/fzf
elseif has('linux')
	set runtimepath+=/usr/bin/fzf
endif

" Hide statusline while fzf-ing.
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

" fzf Mapping selecting mappings.
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" fzf Insert mode completion.
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

packadd fzf.vim

" }}}

" {{{ 6. vifm for Vim.

packadd vifm.vim

" }}}

" {{{ 7. Vim-Airline.

"let g:airline#extensions#tabline#enabled = 1

let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''

" }}}
