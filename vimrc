" -------------------------------------------------------------
" File: ~/.vim/vimrc
" Maintainer: Ernie Lin
"
" {{{ Chronicles of major updates.

" v.1: 2016/03/19 Dad back to Taiwan. MBP2015 @TXG.
" v.2: 2017/10/09 Clau in Cebu Holidays. MBP2015 @BUA.
" v.3: 2018/04/19 Watched Real Player One @Dot_Baires. MBP2015 @BUA.
" v.4: 2018/05/18 Learning Vim8 new manager plugin. MBP2015 @BUA.
" v.5: 2020/10/10 TW National Day and using Lenovo T430s again. @BUA.
" v.6: 2021/11/08 MBP2015 is back after being down for 2 yrs. @BUA.
" v.7: 2023/03/31 Ubuntu on WSL2. Zephyrus @BUA.
" v.8: 2026/05/02 Arch on WSL2. Zephyrus @TNN.

" }}}
" -------------------------------------------------------------

" {{{ Startup.

" Not compatible with the old-fashion VI mode.
set nocompatible

" Store some Vim info.
set viminfo='100,<50,%,h,n$HOME/.vim/viminfo
"           |    |   | | + viminfo file path
"           |    |   | + disable 'hlsearch' loading viminfo
"           |    |   + save/restore buffer list
"           |    + lines saved each register
"           + files marks saved

" Remove '~/.viminfo'.
if filereadable(expand("$HOME/.viminfo"))
	silent !mv $HOME/.viminfo $HOME/.vim/temp/viminfo.old
endif

" How to handle backup files.
set backupdir=$HOME/.vim/temp//			" Where Vim stashes backup files.
set directory=$HOME/.vim/temp/swap//	" Where Vim stashes swap files.
set undodir=$HOME/.vim/temp/undo//		" Where Vim stashes undo files.
set swapfile			" Save unsaved changes.
set undofile			" Save undo trees of the file edited for days.
set writebackup			" Backup files while editing.
set nobackup			" No backup files before editing.

" Make those folders automatically if they don't already exist.
for i in [ &backupdir, &directory, &undodir ]
	if !isdirectory(expand(i))
		call mkdir(expand(i), "p", 0700)
	endif
endfor

" No intro message.
set shortmess+=I

" The menu language must go before ft detection.
if has("gui_macvim")
	set langmenu=zh_TW.UTF-8
else
	set langmenu=none
endif

" }}}

" {{{ Encoding.

" Multibyte must be at the beginning of '$VIMRC'.
if has("multi_byte")
	" Traditional Chinese (TW).
	if v:lang =~ "^zh_TW"
		" Caveats: 'setglobal' will not apply to the first, empty buffer
		"  created at Vim startup. But I am not loading the first buffer.
		set encoding=big5
		setlocal bomb
	" Traditional Chinese (HK).
	elseif v:lang =~ "^zh_HK"
		set encoding=big5-hkscs
		setl bomb
	" Simplified Chinese (use the oldest one due to overlap with Big5).
	elseif v:lang =~ "^zh_CN"
		set encoding=gb2312
		setlocal bomb
	" Japanese.
	elseif v:lang =~ "^ja_JP"
		set encoding=euc-jp
		setlocal bomb
	" Korean.
	elseif v:lang =~ "^ko_KR"
		set encoding=euc-kr
		setlocal bomb
	endif
	if &fileencoding == ""
		let &fileencoding = &encoding
	endif
	" Detect UTF-8 locale and override CJK setting if needed.
	if v:lang =~ "UTF-8$" || v:lang =~ "utf8$"
		" 'BOMB' ('byte order mark' boolean) is put at the start of
		"  Unicode files and works badly with UTF-8/Latex/HTML/XML.
		set nobomb
		set encoding=utf-8
		set fileencodings=ucs-bom,utf-8,big5,big5-hkscs,gb2312,euc-ja,euc-kr,latin1
	endif
	if &termencoding == ""
		let &termencoding = &encoding
	endif
else
	echoerr 'This version of Vim has not been compiled with "multi-byte" support!'
endif

" }}}

" {{{ Display.

" Filetype detection, filetype-specific plugins and indenting.
filetype plugin indent on

" Load syntax files and can override default.
syntax on

set backspace=indent,eol,start	" Backspace over everything in insert mode.
set shiftwidth=4				" Size of an ident, affects '>>', '<<' or '=='.
set softtabstop=0				" Number of spaces a tab counts for in editing.
set tabstop=4					" Number of visual spaces per tab.

set ambiwidth=single	" Treat ambiguous-width East Asian chars as single-width.
set autoindent			" Inherit indent from previous line.
set noexpandtab			" Keep real tabs (CAT tool compatibility).
set smarttab			" Insert tabs at line start based on context.

set hlsearch			" Highlight matches.
set incsearch			" Search as chars are entered.
set ignorecase			" Ignore case when searching.
set smartcase			" Case-sensitive if pattern contains uppercase.

set cursorcolumn		" Highlight current column.
set cursorline			" Highlight current line.
set noshowmatch			" Disable jumping to matching bracket when typing.
set noshowmode			" Hide the default mode text (e.g. -- INSERT --).
set notitle				" Do not set the terminal title to the filename.

set number				" Display line numbers.
set ruler				" The ruler is displayed on the status line.

set foldcolumn=2		" Show fold indicator column (width 2).
set foldenable			" Enable folding.
set foldlevel=0			" Fold all levels on open.
set foldmethod=marker	" Use markers for folding.
set wrap				" Wrap long lines.

" Fill characters in the status line:
" stl:\  — fills the active window's status line with spaces
" stlnc:\ — fills inactive windows' status lines with backslashes
set fillchars+=stl:\ ,stlnc:\
set laststatus=2		" Always show the status line.
set showtabline=1		" Show tabline when at least 2 tabs are open.

set list				" Show invisible characters.
" Replace the glyphs below with your preferred Nerd Font symbols.
set listchars=tab:⇥\ \ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
set showbreak=↳			" Marker shown at the start of a wrapped line.

set autochdir			" Automatically change to the directory of the current file.
set belloff=all			" Mute all bell sounds.
set hidden				" Allow switching buffers without saving.
set switchbuf=usetab	" Include tabs when switching buffers.
"set ttyfast				" No-op in Vim 8+; removed.

set wildmenu					" Enable visual autocomplete in the command bar.
set wildmode=list:longest,full	" Show full list, then cycle matches.
set wildignore+=.DS_Store,*.git
set wildignore+=*/tmp/*

" Word list for keyword completion.
if has('linux') && filereadable('/usr/share/dict/words')
	set dictionary=/usr/share/dict/words
endif

if has("mouse")
	set mouse=a			" Enable mouse in all modes.
	set mousehide		" Hide mouse pointer while typing.
	" Disable sensible horizontal scroll with Logitech Ultrathin Mouse.
	imap <ScrollWheelLeft> <nop>
	imap <ScrollWheelRight> <nop>
	nmap <ScrollWheelLeft> <nop>
	nmap <ScrollWheelRight> <nop>
endif

" }}}

" {{{ Copy & Paste.

if has('clipboard')
	set clipboard+=unnamedplus	" Makes y and p to the global buffer.
endif

" Additional support for WSL2.
if filereadable('/proc/version') && system('grep -i microsoft /proc/version') != ''
	" Copy to clipboard.
	vnoremap <leader>y :w !clip.exe<CR><CR>

	" Paste from clipboard.
	nnoremap <leader>p :r !powershell.exe -command "Get-Clipboard"<CR>
endif

" }}}

" {{{ Terminal & Colors.

if has("termguicolors")
	" Fix true color bug for Vim.
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	" Enable true color.
	set termguicolors
endif

" True Color.
if has("gui_running")		" Emulator running.
	if has("linux")
		set guifont=Hack\ Nerd\ Font\ 13
		set guiheadroom=0	" Ugly gap in gVim.
	elseif has("mac")
		set guifont=Hack\ Nerd\ Font:h13
	endif
	set guioptions-=T		" Remove toolbar.
	set guioptions-=e		" Remove tabbar.
	set guioptions-=m		" Remove menubar.
	set guioptions-=l		" Remove left scrollbar.
	set guioptions-=r		" Remove right scrollbar.
	set lines=50
	set columns=96
	colorscheme jellybeans
else						" Terminal running.
	colorscheme deus
	if has("linux")
		hi Normal guibg=NONE ctermbg=NONE
	endif
endif

" }}}

" {{{ Plugins.

" --- The following files are loaded at startup without convoking. ---

" Netrw (The Unloved Directory Browser).
" File located in '~/.vim/plugin/better-netrw.vim'

" Vim Addons.
" File located in '~/.vim/plugin/vim-on-steroids.vim'

" --- Put these at the very end of your '$VIMRC'. ---

" Load all plugins now. Plugins need to be added to runtimepath
" before helptags can be generated.
packloadall!

" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL

" }}}
