" Full stack development.

if exists("did_load_filetypes")
	finish
endif

augroup filetype_detect
	au! BufRead,BufNewFile *.json		setfiletype=json
	au! BufRead,BufNewFile vimrc*		setfiletype=vim
augroup END
