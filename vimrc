" ---------------------------------------------------------
" File: vimrc
" Maintainer: Ernie Lin
" {{{ --- Chronicles of major updates ---
" v.1: 2016/03/19 Dad back to Taiwan
" v.2: 2017/10/09 Clau in Cebu Holidays
" v.3: 2018/04/19 Watched Real Player One@Dot_Baires
" v.4: 2018/05/18 TGIF, learnt Vim8 new manager plugin
" v.5: 2018/09/21 Spring time in Argentina
" v.6: 2020/10/10 Taiwan National Day
" ---}}}
" ---------------------------------------------------------

" {{{ --- How to handle Vim ---

" Not compatible with the old-fashion VI mode.
set nocompatible

" Store some Vim info.
set viminfo='50,<1000,%,h,n$HOME/.vim/viminfo
"           |   |     | | + viminfo file path
"           |   |     | + disable 'hlsearch' loading viminfo
"           |   |     + save/restore buffer list
"           |   + lines saved each register
"           + files marks saved

" How to handle backup files.
set backupdir=$HOME/.vim/tmp//	" Where Vim stashes backup files.
set directory=$HOME/.vim/tmp//	" Where Vim stashes swap files.
set undodir=$HOME/.vim/undo//	" Where Vim stashes undo files.
set swapfile					" Save unsaved changes.
set undofile					" Save undo trees of the file edited for days.
set nobackup					" No backup before editing files.
set nowritebackup				" No need of backup file while editing.

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif

" Set Run-time path.
if has("unix")
	set runtimepath+=/usr/bin/fzf
elseif has("mac")
	set runtimepath+=/usr/local/opt/fzf
endif

" Filetype add-ons.
syntax on				" Load syntax files.
filetype on				" Load filetype detection.
filetype plugin on		" Load filetype-specific plugins.
filetype indent on		" Load filetype-specific indenting.

" --- }}}

" {{{ --- Encoding ---

" Multibyte must be at the beginning of '$VIMRC'
if has('multi_byte')
	if &termencoding == ""
		let &termencoding = &encoding
	endif
	" Detect UTF-8 and override CJK
	" 'BOMB' ('byte order mark' boolean) will put a BOM at the start
	"  of Unicode files and it conflicts with UTF-8.
	if v:lang =~ "UTF-8$" || v:lang =~ "utf8$"
		set encoding=utf-8
		setglobal fileencoding=utf-8
		" Note, this will not apply to the first, empty buffer created at Vim
		"  startup.
		set fileencodings=ucs-bom,utf-8,big5,big5-hkscs,gb2312,euc-ja,euc-kr,latin1
	" Traditional Chinese (TW)
	elseif v:lang =~ "^zh_TW"
		set encoding=big5
		setglobal fileencoding=big5
		set bomb
	" Traditional Chinese (HK)
	elseif v:lang =~ "^zh_HK"
		set encoding=big5-hkscs
		setglobal fileencoding=big5-hkscs
		set bomb
	" Simplified Chinese (use the oldest one due to overlap with Big5)
	elseif v:lang =~ "^zh_CN"
		set encoding=gb2312
		setglobal fileencoding=gb2312
		set bomb
	" Japanese
	elseif v:lang =~ "^ja_JP"
		set encoding=euc-jp
		setglobal fileencoding=euc-jp
		set bomb
	" Korean
	elseif v:lang =~ "^ko_KR"
		set encoding=euc-kr
		setglobal fileencoding=euc-kr
		set bomb
	endif
else
	echoerr 'This Vim has not been compiled with "multi-byte" support!'
endif

" --- }}}

"{{{ --- Features learnt throughout the years ---

" Indentation and spacing matters.
set tabstop=4			" Number of visual spaces per tab.
set shiftwidth=4		" Affects '>>', '<<' or '=='.
set softtabstop=4		" Number of spaces in tab when editing.
set list				" Show invisible.
set showbreak=↳			" Show for lines that have been wrapped.
set listchars=tab:→\ ,eol:↲,nbsp:␣
set listchars+=extends:»,precedes:«,trail:·
set backspace=indent,eol,start		" Allow backspacing over everything in insert mode.
set autoindent			" 1 - autoident: Uses the indent from previous line.
						" 2 - smartident: Regcognizes some C syntax to indent when appropiate.
						" 3 - cident: Stricter than previous two and more customizable.
						" 4 - indentexpr: When not empty overrides 'cindent' & 'smartident'.
set noexpandtab			" Try not to expand tabs to spaces (works badly with CAT).
set smarttab			" Insert tabs at the start of a line according to context.

" UI preferences.
"set statusline=-		" Hide file name in statusline.
set laststatus=2		" Always show the statusline.
set fillchars=stl:\ ,stlnc:\			 " Remove the delimeters!
set fillchars+=vert:\ ,fold:\ ,diff:\ 	 " Remove the delimeters!
set autochdir			" Auto change the current working directory.
set belloff=all			" Mute all beeps.
set clipboard+=unnamed	" Makes y and p to the global buffer.
set hidden				" Buffer becomes hidden when abandoned.
set history=1000		" Command-line history saved.
set lazyredraw			" Do not redraw while executing macros.
set noshowmatch			" Disable jumping to matching bracket when typing.
set number				" Display line numbers.
set ruler				" Show the cursor position at all time.
set showcmd				" Show command in the bottom bar.
set showmode			" Show current mode.
set spell spelllang=en_us
set switchbuf=usetab	" When switching buffers, include tabs.
set title				" Set filename in terminal title.
set ttyfast				" Send more chars while redrawing.

" Autocomplete.
set wildmenu					" Visual autocomplete for command menu at the bottom bar.
set wildmode=list:longest,full	" Turn on wild mode huge list.
set wildignore=.DS_Store,*.git
set wildignore+=*/tmp/*

" Searching for the one that matters.
"set cursorcolumn		" Highlight current column.
set cursorline			" Highlight current line.
set hlsearch			" Highlight matches.
set incsearch			" Search as chars are entered.
set ignorecase			" Ignore case when searching.
set smartcase			" Ignore case if search pattern is all lowercase.

" Folding and wrapping.
set formatoptions=roq	" c=autrowrap comments, r=continue comment on <enter>,
						"  o=continue on 'o' or '0', q=allow format comment with gqgq.
set wrap				" Wrap lines.
set foldenable			" When off, all folds are open. Toggle with <zi> command.
set foldmethod=marker	" Fold method.
set foldcolumn=2		" Size of info column.
set foldlevel=0			" Fold all levels.

" --- }}}

" {{{ --- Advanced features ---

" Enable mouse.
if has('mouse')
	set mouse=a				" Mouse in all modes.
	set mousehide			" Hide mouse pointer while typing
	set ttymouse=xterm2		" Running mouse under tmux workaround conf.
	" Sensible horinzontal mouse scrolling wth Logitech Ultrathin Mouse.
	nmap <ScrollWheelLeft> <nop>
	imap <ScrollWheelLeft> <nop>
	nmap <ScrollWheelRight> <nop>
	imap <ScrollWheelRight> <nop>
endif

" Calling grep.
if executable("rg")
	set grepprg=rg\ --vimgrep\ --no-heading
	set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable("grep")
	set grepprg=grep -n $* /dev/null
	set grepformat=%f:%l:%m,%f:%l%m,%f %l%m
endif

" The infamous Powerline theme for Python.
if has('python3')
	set t_Co=256	" Used by the termcap system that Vim users for term colors.
	silent! python3 from powerline.vim import setup as powerline_setup
	python3 powerline_setup()
	python3 del powerline_setup
endif

" Different GUIs.
" Colors: badwolf, dracula, gruvbox, solarized8.
if has('gui_running')		" Emulator running.
	set guioptions-=T		" Remove toolbar.
	set guioptions-=e		" Remove tabbar.
	set guioptions+=m		" Remove menubar. 
	set guioptions-=l		" Remove left scrollbar.
	set guioptions-=r		" Remove right scrollbar.
	set guifont=Monofur\ Nerd\ Font\ 12
	set lines=36
	set columns=124
	colorscheme badwolf
	if has('unix')
		set guiheadroom=0
	endif
else						" Terminal running.
	set background=dark
	colorscheme gruvbox
endif

" --- }}}

" {{{ --- Source-in some other Vim's capabilities ---

if filereadable(expand("vimrc_extended"))
	source $HOME/.vim/vimrc_extended
endif

" --- }}}
