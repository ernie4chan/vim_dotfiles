" ---------------------------------------------------------
" vim: filetype=vim
" File: ~/.vim/plugin/better-netrw.vim
" Title: Netrw
" Description: Making a more intuitive Netrw.
" Update: 2026/05/04
" Written: Ernie Lin
" Reference: https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/
" ---------------------------------------------------------

" {{{ Behavior

" Window size: 32% for narrow screens (<92 cols), 22% otherwise.
let g:netrw_winsize = &columns < 92 ? 32 : 22

" Hide banner.
let g:netrw_banner = 1

" Open files in:
" 0 Same window (default)
" 1 Horizontal split
" 2 Vertical split
" 3 New tab
" 4 Previous/existing window
let g:netrw_browse_split = 0

" Preview in vertical split instead of horizontal.
let g:netrw_preview = 0

" Vertical split opens to the right of Netrw.
let g:netrw_altv = 1

" Keep the current directory and the browsing directory synced.
" This helps you avoid the move files error.
let g:netrw_keepdir = 0

" Hide dotfiles by default (toggle with '.' mapping).
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

" Copy directories recursively.
let g:netrw_localcopydircmd = 'cp -r'

" Highlight marked files in the same way search matches are.
hi! link netrwMarkFile Search

" }}}

" {{{ Mappings

" Toggle the Netrw window and opens in the current working directory (pwd).
nnoremap <leader>e :call ToggleNetrw()<cr>

" Open Netrw in the current file's directory.
" Example: current file:  ~/projects/foo/bar.txt
"		%		→	bar.txt
"		%:p		→	/home/user/projects/foo/bar.txt
"		%:p:h	→	/home/user/projects/foo
nnoremap <leader>ee :Lexplore %:p:h<cr>:echo 'Netrw: opened at file location.'<cr>

" Better keymaps for Netrw.
function! NetrwMapping()

	" -----
	" Open a file and close Netrw.
	nmap <buffer> L <cr>:Lexplore<cr>:echo 'Netrw: closed.'<cr>

	" Go back in history.
	nmap <buffer> H u
	" Go up a directory and moves to the first non-blank character.
	nmap <buffer> h -^
	" Open a directory/file.
	nmap <buffer> l <cr>
	" Toggle hidden files.
	nmap <buffer> za gh

	" p — preview, cursor stays in Netrw, file opens in a new split.
	" P — opens file in previously used window, cursor moves to that window.
	" Open file and jump back to Netrw.
	nmap <buffer> pp <cr><c-w>p
	" Close the preview window.
	nmap <buffer> PP <c-w>z

	" -----
	" Mark a file in the current buffer.
	nmap <buffer> <tab> mf
	" Unmark all files in the current buffer.
	nmap <buffer> <s-tab> mF
	" Unmark all files.
	nmap <buffer> <leader><tab> mu

	" -----
	" Create a 'Bookmark'.
	nmap <buffer> bb mb
	" Remove the most recent 'bookmark'.
	nmap <buffer> bd mB
	" Jump to the most recent 'bookmark'.
	nmap <buffer> bl gb
	" Query 'bookmarks'.
	nmap <buffer> bq qb

	" -----
	" Create a file for real.
	nmap <buffer> F %:w<cr>:buffer #<cr>

	" Set the directory under the cursor as the current target.
	nmap <buffer> ft mtfq

	" Copy marked files to target directory.
	nmap <buffer> fc mc
	" Copy marked files to directory under cursor.
	nmap <buffer> fC mtmc
	" Move marked files to target folder.
	nmap <buffer> fm mm
	" Move marked files to directory under cursor.
	nmap <buffer> fM mtmm

	" Execute a command on marked files.
	nmap <buffer> fe mx
	" Query the list of marked files.
	nmap <buffer> fl :echo join(netrw#Expose("netrwmarkfilelist"), "\n")<cr>
	" Query target directory.
	nmap <buffer> fq :echo 'Target:' . netrw#Expose("netrwmftgt")<cr>

endfunction

" }}}

" {{{ Define functions

" Toggle Netrw window and echo its state.
function! ToggleNetrw()
	let l:before = winnr('$')
	Lexplore
	redraw
	if winnr('$') > l:before
		echo 'Netrw: opened at working directory.'
	else
		echo 'Netrw: closed.'
	endif
endfunction

" }}}

" {{{ Autocommands

augroup netrw_mapping
	autocmd!
	autocmd filetype netrw call NetrwMapping()
augroup END

augroup netrw_close
	autocmd!
	autocmd BufDelete * if winnr('$') == 1 && &filetype == 'netrw' | quit | endif
augroup END

" Hide airline tabline in Netrw, restore when leaving.
augroup netrw_tabline
	autocmd!
	autocmd FileType netrw set showtabline=0
	autocmd BufLeave * if &filetype != 'netrw' | set showtabline=2 | endif
	autocmd BufEnter * if &filetype == 'netrw' | set showtabline=0 | endif
augroup END

" }}}
