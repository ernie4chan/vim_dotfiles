" ---------------------------------------------
" File: ~/.vim/plugin/mappings.vim
" Maintainer: Ernie Lin
"
" Update: 2022-06-08
" ---------------------------------------------

" Clear highlights.
nnoremap <silent><C-l> :<C-u>nohlsearch<CR><C-l>

" Toggle list (display unprintable characters).
nnoremap <F2> :set list!<CR>

" Deploy rot13 encryption for people snooping over shoulder.
nnoremap <silent><F3> <ESC>ggVGg?

" Toggle auto-indenting on and off for code pasting.
set pastetoggle=<F4>

" Switching between buffers.
nnoremap <silent><F5> :tabprevious<CR>
nnoremap <silent><F6> :tabnext<CR>

" Ctags.
nnoremap <Leader>t :!ctags -R<CR>

" Remap for destroying trailing whitespace cleanly
nnoremap <Leader>w
	\ :let _save_pos=getpos(".")<Bar>
	\ :let _s=@/<Bar>
	\ :%s/\s\+$//e<Bar>
	\ :let @/=_s<Bar>
	\ :nohl<Bar>
	\ :unlet _s<Bar>
	\ :call setpos('.', _save_pos)<Bar>
	\ :unlet _save_pos<CR><CR>
