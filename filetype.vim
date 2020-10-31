" Full stack development.

if exists("did_load_filetypes")
	finish
endif

augroup filetype_detect
	au!
	au BufRead,BufNewFile \w*rc$	setfiletype=vim
	au BufRead,BufNewFile zsh		setfiletype=sh
augroup END
