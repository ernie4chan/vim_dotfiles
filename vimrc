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

" The menu language must go before ft detection.
if has("gui_macvim")
	set langmenu=zh_TW.UTF-8
else
	set langmenu=none
endif

" }}}

" {{{ Editing.

" Filetype detection, filetype-specific plugins and indenting.
filetype plugin indent on

" Load syntax files and can override default.
syntax on

" Spacing matters.
set backspace=indent,eol,start	" Backspacing over everything in insert mode.
set tabstop=4			" Number of visual spaces per tab.
set shiftwidth=4		" The size of an ident, affects '>>', '<<' or '=='.
set softtabstop=0		" Number of spaces in tab when editing.
" Enabling this will make the tab key (insert mode) insert spaces instead of
"  tab characters. Try not to expand tabs to spaces (works badly with CAT).
set noexpandtab
set smarttab			" Insert tabs at the start of a line according to context.
set autoindent			" Uses the indent from previous line.

" }}}

" {{{ Searching.

set hlsearch			" Highlight matches.
set incsearch			" Search as chars are entered.
set ignorecase			" Ignore case when searching.
set smartcase			" Ignore case if search pattern is all lowercase.

" }}}

" {{{ Display.

set foldcolumn=2		" Size of info column.
set foldenable			" When off, all folds are open. Toggle with <zi> command.
set foldlevel=0			" Fold all levels.
set foldmethod=marker	" Fold method.
set wrap				" Wrap lines.

set list				" Show invisible.
set listchars=tab:⇥\ \ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
set showbreak=↳			" Show for lines that have been wrapped.

set fillchars+=stl:\ ,stlnc:\
set laststatus=2		" Always display the statusline in all windows.
set showtabline=1		" Display the tabline when there are at least 2.

set autochdir			" Auto change the current working directory.
set belloff=all			" Mute all beeps.
set hidden				" Buffer becomes hidden when abandoned.
set switchbuf=usetab	" When switching buffers, include tabs.
"set ttyfast				" No-op in Vim 8+; removed.

set ambiwidth=single	" East Asian width class ambiguous characters.
set cursorcolumn		" Highlight current column.
set cursorline			" Highlight current line.
set noshowmatch			" Disable jumping to matching bracket when typing.
set noshowmode			" Hide the default mode text.
set notitle				" Disables setting the terminal title to the filename.
set number				" Display line numbers.
set ruler				" The ruler is displayed on the status line.

" Autocomplete.
set wildmenu			" Visual autocomplete for command menu at the bottom bar.
set wildmode=list:longest,full	" Turn on wild mode huge list.
set wildignore=.DS_Store,*.git
set wildignore+=*/tmp/*

" Enable mouse.
if has("mouse")
	set mouse=a			" Mouse in all modes.
	set mousehide		" Hide mouse pointer while typing.
	" Sensible horizontal scroll with Logitech Ultrathin Mouse.
	imap <ScrollWheelLeft> <nop>
	imap <ScrollWheelRight> <nop>
	nmap <ScrollWheelLeft> <nop>
	nmap <ScrollWheelRight> <nop>
endif

" Dictionary files for keyword completion.
if has('linux') && filereadable('/usr/share/dict/words')
	set dictionary=/usr/share/dict/words
endif

" }}}

" {{{ Copy & Paste.

if has('clipboard')
	set clipboard+=unnamedplus	" Makes y and p to the global buffer.
endif

" Additional support for WSL2.
if filereadable('/proc/version') && system('grep -i microsoft /proc/version') != ''
	" Copy to clipboard
	vnoremap <leader>y :w !clip.exe<CR><CR>

	" Paste from clipboard
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
