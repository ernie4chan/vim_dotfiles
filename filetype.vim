" Full stack development.

if exists("did_load_filetypes")
	finish
endif

augroup filetype_detect
	au!
	" Vim help file
	au BufNewFile,BufRead $VIMRUNTIME/doc/*.txt	setf help
	au BufRead,BufNewFile \w*rc$				setf=vim
	au BufRead,BufNewFile zsh					setf=sh
	" Mutt setup file (also for Muttng)
	au BufNewFile,BufRead Mutt{ng,}rc			setf muttrc
augroup END
