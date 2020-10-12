"--------------------------------------------------------------------------------------
" Maintainer: Ernie Lin
"{{{ --- Chronicles of major updates ---
" v.1: 2016/03/19 Dad back to Taiwan
" v.2: 2017/10/09 Clau in Cebu Holidays
" v.3: 2018/04/19 Watched Real Player One@Dot_Baires
" v.4: 2018/05/18 TGIF, learnt Vim8 new manager plugin
" v.5: 2018/09/21 Spring time in Argentina
" v.6: 2020/10/10 Taiwan National Day
"---}}}
"--------------------------------------------------------------------------------------

"{{{ --- How to handle Vim ---------------------------------------------------

" Not compatible with the old-fashion VI mode.
set nocompatible

" Store some Vim info.
set viminfo='100,<1000,s100,n$HOME/.vim/viminfo

" How to handle backup files.
set backupdir=$HOME/.vim/tmp//	" Where Vim stashes backup files
set directory=$HOME/.vim/tmp//	" Where Vim stashes swap files
set undodir=$HOME/.vim/tmp//	" Where Vim stashes undo files
"set noswapfile					" No need to save unsaved changes
set nobackup					" No need to backup before editing files
set nowritebackup				" No need of backup file while editing
set undofile					" Save undo trees of the file edited for days later

" Set Run-time path.
if has("mac")
	set runtimepath+=/usr/local/opt/fzf
elseif has("unix")
	set runtimepath+=/usr/bin/fzf
endif

" Load files.
syntax on					" Loads syntax files
filetype on					" Filetype detection
filetype plugin on			" Loads ftplugin files
filetype indent on			" Loads indent files

"--------------------------------------------------------------------------}}}

" Multibyte must be at the beginning of '$VIMRC'
"{{{ --- Encoding ------------------------------------------------------------

if has('multi_byte')
	if &termencoding == ""
		let &termencoding = &encoding
	endif
	if v:lang =~ "^zh_TW"		" Traditional Chinese (TW)
		set encoding=big5
		setglobal fileencoding=big5
		set bomb				" Conflicts with UTF-8
	elseif v:lang =~ "^zh_HK"	" Traditional Chinese (HK)
		set encoding=big5-hkscs
		setglobal fileencoding=big5-hkscs
		set bomb				" Conflicts with UTF-8
	elseif v:lang =~ "^zh_CN"	" Simplified Chinese
		set encoding=gb2312
		setglobal fileencoding=gb2312
		set bomb				" Conflicts with UTF-8
	elseif v:lang =~ "^ja_JP"	" Japanese
		set encoding=euc-jp
		setglobal fileencoding=euc-jp
		set bomb				" Conflicts with UTF-8
	elseif v:lang =~ "^ko_KR"	" Korean
		set encoding=euc-kr
		setglobal fileencoding=euc-kr
		set bomb				" Conflicts with UTF-8
	endif
	if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"	" Detect UTF-8 and override CJK
		set encoding=utf-8
		setglobal fileencoding=utf-8
		set fileencodings=ucs-bom,utf-8,big5,gb2312,big5-hkscs,euc-ja,euc-kr,latin1
	endif
else
	echoerr 'This Vim has not been compiled with "multi-byte" support!'
endif

"--------------------------------------------------------------------------}}}

"{{{ --- Features learnt throughout the years  -------------------------------

" Indentation andspacing matters.
set backspace=indent,eol,start
			\			" Allow backspacing over everything in insert mode
set shiftwidth=4		" Affects >>, << or ==
set softtabstop=4		" Number of spaces in tab when editing
set tabstop=4			" Number of visual spaces per tab
set autoindent			" 1 - Uses the indent from previous line
"set smartindent		" 2 - Regcognizes some C syntax to indent when appropiate
"set cindent			" 3 - Stricter than previous two and more customizable
"set indentexpr=		" 4 - When not empty overrides 'cindent' & 'smartident'
"set expandtab			" Try not to expand tabs to spaces (works badly with CAT)
"set smarttab			" Insert tabs at the start of a line according to context

" UI preferences.
set autochdir			" Auto change the current working directory
set belloff=all			" Mute all beeps
set clipboard+=unnamed	" Makes y and p to the global buffer
set cursorline			" Highlight current line
set fillchars=			" Remove the delimeters!
set hidden				" Buffer becomes hidden when abandoned
set history=2000		" Command-line history saved
set laststatus=2		" Always show the statusline
set lazyredraw			" Do not redraw while executing macros
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
			\			" Unicode characters
set noshowmatch			" Disable jumping to matching bracket when typing
set number				" Display line numbers
set ruler				" Show the cursor position at all time
set showbreak=			" Show for lines that have been wrapped, like Emacs
set showcmd				" Show command in the bottom bar
set title				" Set filename in terminal title
set ttyfast				" Send more chars while redrawing

" Folding.
set wrap				" Wrap lines
set foldenable
set foldmethod=marker
set foldcolumn=2
set foldlevel=1
set foldlevelstart=0

" Searching for the one that matters.
set hlsearch			" Highlight matches
set ignorecase			" Case insensitive
set incsearch			" Search as chars are entered
set smartcase			" Ignore case if search pattern is all lowercase

" Completion options.
if has('wildmenu')
	set wildmenu		" Visual autocomplete for command menu at the bottom bar
	set wildmode=list:longest,full				" Turn on wild mode huge list
	set wildignore=.DS_Store,*.git,*.svn
	set wildignore+=*/tmp/*,*.so,*.swp,*.zip	" macOS/Linux from CtrlP
endif

"--------------------------------------------------------------------------}}}

" --- Source in some other Vim's capabilities --------------------------------
source $HOME/.vim/vimrc_plugins
"-----------------------------------------------------------------------------

"{{{ --- Advanced features ---------------------------------------------------

" Enable mouse.
if has('mouse')
	set mouse=a				" Mouse in all modes
	set ttymouse=xterm2		" Running mouse under tmux workaround conf
	set mousehide			" Hide mouse pointer while typing
	" Sensible horinzontal mouse scrolling wth Logitech Ultrathin Mouse.
	nmap <ScrollWheelLeft> <nop>
	imap <ScrollWheelLeft> <nop>
	nmap <ScrollWheelRight> <nop>
	imap <ScrollWheelRight> <nop>
endif

" Calling grep.
if executable('rg')
	set grepprg="rg --vimgrep --no-heading"
	set grepformat="%f:%l:%c:%m,%f:%l:%m"
elseif executable('grep')
	set grepprg="grep -n $* /dev/null"
	set grepformat="%f:%l:%m,%f:%l%m,%f %l%m"
endif

" The infamous Powerline theme for Python.
if has('python3')
	silent! python3 from powerline.vim import setup as powerline_setup
	python3 powerline_setup()
	python3 del powerline_setup
	set t_Co=256
endif

" Different GUIs.
" Colors: badwolf, dracula, gruvbox, solarized8.
if has('gui_running')
	set guioptions-=T		" Remove toolbar
	"set guioptions-=L		" Remove left scrollbar
	"set guioptions-=r		" Remove right scrollbar
	set guioptions-=e		" Remove tabbar
	set guifont=Monofur\ Nerd\ Font\ 12
	set lines=36
	set columns=124
	colorscheme badwolf
else						" Terminal running
	"set bg=dark
	colorscheme gruvbox
endif

"--------------------------------------------------------------------------}}}
