" Full stack development.

if exists("did_load_filetypes")
	finish
endif
let did_load_filetypes = 1

augroup filetype_detect
	au BufRead,BufNewFile *.json	setfiletype=json
	au BufRead,BufNewFile vimrc*	setfiletype=vim
	au BufRead,BufNewFile *rc		setfiletype=vim
	au BufRead,BufNewFile zsh		setfiletype=sh
augroup END
