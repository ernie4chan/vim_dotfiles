" -------------------------------------------------------------
" vim: filetype=vim
" File: ~/.vim/vimrc
" Title: Vim Run Commands
" Maintainer: Ernie Lin
" {{{ Chronicles of major updates

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

" {{{ Startup

" Not compatible with the old-fashion VI mode.
set nocompatible

" No intro message.
set shortmess+=I

" How to handle backup files.
set backupdir=$HOME/.vim/temp//         " Where Vim stashes backup files.
set directory=$HOME/.vim/temp/swap//    " Where Vim stashes swap files.
set undodir=$HOME/.vim/temp/undo//      " Where Vim stashes undo files.
set swapfile            " Save unsaved changes.
set undofile            " Save undo trees of the file edited for days.
set writebackup         " Backup files while editing.
set nobackup            " No backup files before editing.

" Make those folders automatically if they don't already exist.
for i in [ &backupdir, &directory, &undodir ]
    if !isdirectory(expand(i))
        call mkdir(expand(i), "p", 0700)
    endif
endfor

" Remove '~/.viminfo'.
if filereadable(expand("$HOME/.viminfo"))
    silent !mv $HOME/.viminfo $HOME/.vim/temp/viminfo.old
endif

" Store Vim info.
" Marks (') — remembers cursor positions in recently edited files
" Registers (<) — saves yanked/deleted text
" Buffers (%) — restores open files on next launch
" Search (h, /) — saves search history and highlight state
" Commands (:) — saves command-line history
" Variables (!) — saves global variables
" File path (n) — where to store the viminfo file
" Input (@) — saves input line history
" Media (r) — excludes removable drives from mark saving
" Size (s) — limits register item size to prevent huge viminfo files
let &viminfo="'100,<50,h,n" .. expand("$HOME/.vim/viminfo")

" }}}

" {{{ Encoding

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
        setlocal bomb
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

" {{{ Filetype & Syntax

" Filetype detection, filetype-specific plugins and indenting.
filetype plugin indent on

" Load syntax files and can override default.
syntax on

" }}}

" {{{ Colors

" Enable true color.
if has("termguicolors")
    " Fix true color bug for Vim.
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

" Colorschemes.
if has("gui_running")
    colorscheme jellybeans
    if has("linux")
        set guifont=Hack\ Nerd\ Font\ 13
        set guiheadroom=0   " Ugly gap in gVim.
    elseif has("mac")
        set guifont=Hack\ Nerd\ Font:h13
    endif
    set guioptions-=m       " Remove menubar.
    set guioptions-=e       " Remove tabbar.
    set guioptions-=T       " Remove toolbar.
    set guioptions-=l       " Remove left scrollbar.
    set guioptions-=r       " Remove right scrollbar.
    set lines=50
    set columns=96
else                        " Terminal running.
    set t_ut=               " disable BCE, fixes white flash in Windows Terminal.
    let s:os = system("grep ^ID= /etc/os-release")
    if s:os =~? "arch"
        colorscheme retrobox        " WSL2 Arch.
    elseif s:os =~? "debian"
        colorscheme snow            " WSL2 Debian.
    else
        colorscheme jellybeans      " Other.
    endif
endif

" }}}

" {{{ Editing and Searching

set tabstop=4           " Number of visual spaces per tab.
set softtabstop=4       " Number of spaces a tab counts for in editing.
set shiftwidth=4        " Size of an ident, affects '>>', '<<' or '=='.

set ambiwidth=single            " Treat ambiguous-width East Asian chars as single-width.
set autoindent                  " Inherit indent from previous line.
set backspace=indent,eol,start  " Backspace over everything in insert mode.

set noexpandtab           " Keep real tabs (CAT tool compatibility).
set smarttab            " Insert tabs at line start based on context.

set cursorcolumn        " Highlight current column.
set cursorline          " Highlight current line.
set hlsearch            " Highlight matches.
set incsearch           " Search as chars are entered.
set ignorecase          " Ignore case when searching.
set smartcase           " Case-sensitive if pattern contains uppercase.

" }}}

" {{{ Display

"set noshowmatch            " Disable jumping to matching bracket when typing.
set noshowmode          " Hide the default mode text (e.g. -- INSERT --).
set notitle             " Do not set the terminal title to the filename.
set number              " Display line numbers.
set ruler               " The ruler is displayed on the status line.

set foldcolumn=2        " Show fold indicator column (width 2).
set foldenable          " Enable folding.
set foldlevel=0         " Fold all levels on open.
set foldmethod=marker   " Use markers for folding.
set wrap                " Wrap long lines.

" Fill characters in the status line (it will be overrided by airline):
" stl:\  — fills the active window's status line with spaces
" stlnc:\ — fills inactive windows' status lines with backslashes
"set fillchars+=stl:\ ,stlnc:\
"set showtabline=1      " Show tabline when at least 2 tabs are open.
set laststatus=2        " Always show the status line.
set list                " Show invisible characters.
" Replace the glyphs below with your preferred Nerd Font symbols.
set listchars=tab:⇥\ \ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
set showbreak=↳         " Marker shown at the start of a wrapped line.

" }}}

" {{{ Behavior

set belloff=all         " Mute all bell sounds.
set hidden              " Allow switching buffers without saving.
set switchbuf=usetab    " Include tabs when switching buffers.
"set autochdir          " !! It may conflicts with Netrw.
"set ttyfast                " No-op in Vim 8+; removed.

set wildmenu                    " Enable visual autocomplete in the command bar.
set wildmode=list:longest,full  " Show full list, then cycle matches.
set wildignore+=.DS_Store,*.git
set wildignore+=*/tmp/*

" Spell check language.
" It's Mexican Spanish.
set spelllang=en_us,es

" Word list for keyword completion.
if has('linux') && filereadable('/usr/share/dict/words')
    set dictionary=/usr/share/dict/words
endif

if has("mouse")
    set mouse=a         " Enable mouse in all modes.
    set mousehide       " Hide mouse pointer while typing.
    " Disable sensible horizontal scroll with Logitech Ultrathin Mouse.
    imap <ScrollWheelLeft> <nop>
    imap <ScrollWheelRight> <nop>
    nmap <ScrollWheelLeft> <nop>
    nmap <ScrollWheelRight> <nop>
endif

" }}}

" {{{ Copy & Paste

if has('clipboard')
    set clipboard+=unnamedplus  " Makes y and p to the global buffer.
endif

" Additional support for WSL2.
if !empty($WSL_DISTRO_NAME)
    " Copy to clipboard.
    vnoremap <leader>y :w !clip.exe<CR><CR>:echo 'Copied to clipboard'<CR>
    " Paste from clipboard.
    nnoremap <leader>p :r !powershell.exe -command "Get-Clipboard"<CR>
endif

" }}}

" {{{ Mappings

" Pane manipulation.
nnoremap <leader>h <C-W>h
nnoremap <leader>j <C-W>j
nnoremap <leader>k <C-W>k
nnoremap <leader>l <C-W>l

" Tab manipulation.
nnoremap <leader>q :tabclose<CR>        " Close tab.
nnoremap <leader>t :tabnew<CR>          " New tab.
nnoremap <leader>; :tabprevious<CR>     " Previous tab.
nnoremap <leader>' :tabnext<CR>         " Next tab.

" Buffer manipulation.
nnoremap <leader>x :bdelete<CR>         " Delete buffer.
nnoremap <leader>b :enew<CR>            " New buffer.
nnoremap <leader>[ :bprevious<CR>       " Previous buffer.
nnoremap <leader>] :bnext<CR>           " Next buffer.

" Pane resizing.
nnoremap <leader>1 5<C-W><              " Decrease pane width (h).
nnoremap <leader>2 5<C-W>>              " Increase pane width (l).
nnoremap <leader>3 5<C-W>-              " Decrease pane height (j).
nnoremap <leader>4 5<C-W>+              " Increase pane height (k).
nnoremap <leader>= <C-W>=               " Equalize pane sizes.
nnoremap <leader>- :only<CR>            " Zoom to single pane.

" Focus Resize.
function! FocusResizeVertical(side)
    " Require exactly 2 panels.
    if winnr('$') != 2
        redraw
        echo 'Need exactly 2 vertical panels'
        return
    endif
    " Check if split is vertical (different columns).
    let w1 = win_screenpos(1)
    let w2 = win_screenpos(2)
    if w1[1] == w2[1]
        redraw
        echo 'Need exactly 2 vertical panels'
        return
    endif
    " Resize the target pane to 35 columns.
    noautocmd execute 'wincmd ' . a:side
    noautocmd vertical resize 35
    noautocmd execute 'wincmd ' . (a:side == 'h' ? 'l' : 'h')
    redraw
    echo 'Wide ' . (a:side == 'h' ? 'right' : 'left') . ' vertical split applied'
endfunction

function! FocusResizeHorizontal(side)
    " Require exactly 2 panels.
    if winnr('$') != 2
        redraw
        echo 'Need exactly 2 horizontal panels'
        return
    endif
    " Check if split is horizontal (different rows).
    let w1 = win_screenpos(1)
    let w2 = win_screenpos(2)
    if w1[0] == w2[0]
        redraw
        echo 'Need exactly 2 horizontal panels'
        return
    endif
    " Resize the target pane to 10 rows.
    noautocmd execute 'wincmd ' . a:side
    noautocmd resize 10
    noautocmd execute 'wincmd ' . (a:side == 'k' ? 'j' : 'k')
    redraw
    echo 'Tall ' . (a:side == 'k' ? 'bottom' : 'top') . ' horizontal split applied'
endfunction

" Resize left/right vertical panes.
nnoremap <leader>5 :call FocusResizeVertical('h')<CR>
nnoremap <leader>6 :call FocusResizeVertical('l')<CR>
" Resize top/bottom horizontal panes.
nnoremap <leader>7 :call FocusResizeHorizontal('j')<CR>
nnoremap <leader>8 :call FocusResizeHorizontal('k')<CR>

" Function Keys.
" Toggle PASTE mode (disable auto-indent and others when pasting).
nnoremap <F2>   :set paste!<CR>
    \:echo 'PASTE mode ' . (&paste ? 'on' : 'off')<CR>
" Toggle ruler.
nnoremap <F3>   :call ToggleNumbers()<CR>

function! ToggleNumbers()
    if !&number && !&relativenumber
        set number
        echo 'Absolute line numbers'
    elseif &number && !&relativenumber
        set relativenumber
        echo 'Relative line numbers'
    else
        set nonumber norelativenumber
        echo 'Line numbers off'
    endif
endfunction

" Toggle tabs/spaces.
nnoremap <F6>   :set expandtab! \|
    \ if &expandtab \| echo 'expandtab on (insert spaces)' \|
    \ else \| echo 'expandtab off (insert tabs)' \| endif<CR>
" Toggle spell check.
nnoremap <F7>   :set spell!<CR>
    \:echo 'Spell check ' . (&spell ? 'on' : 'off')<CR>
" Toggle unprintable characters.
nnoremap <F8>   :set list!<CR>
    \:echo 'Invisibles ' . (&list ? 'on' : 'off')<CR>
" Toggle line wrap.
nnoremap <F9>   :set wrap!<CR>
    \:echo 'Wrap ' . (&wrap ? 'on' : 'off')<CR>
" Quit program.
nnoremap <F10>  :q<CR>
" ROT13 encoding.
let g:rot13_on = 0
nnoremap <F12>  ggVGg?
    \:let g:rot13_on = !g:rot13_on<CR>
    \:echo 'ROT13 ' . (g:rot13_on ? 'on' : 'off')<CR>

" Clear search highlights.
nnoremap <C-L> :nohlsearch<CR><C-L>
    \:echo 'All cleared.'<CR>

" Yank fold title.
nnoremap yt :let @"=matchstr(getline('.'), '\v\{\{\{ \zs.*')<CR>
    \:echo 'Yanked: ' . @"<CR>

" Generate tags recursively from current directory.
nnoremap <leader>ct :!ctags -R<CR>
    \:echo 'Tags generated.'<CR>

" Trim trailing whitespace.
function! TrimWhitespace()
    let l:save_pos = getpos('.')
    let l:save_search = @/
    %s/\s\+$//e
    let @/ = l:save_search
    call setpos('.', l:save_pos)
endfunction

nnoremap <leader>w :call TrimWhitespace()<CR>
    \:echo 'Trailing whitespace trimmed'<CR>

" Apply transparent background.
function! ApplyTransparentBG()
    highlight Normal guibg=NONE ctermbg=NONE
endfunction

nnoremap <leader>tb :call ApplyTransparentBG()<CR>
    \:echo 'Transparent background applied'<CR>

" Dump all mappings to file.
nnoremap <leader>m :redir! > ~/vim-mappings.txt<CR>:silent map<CR>:redir END<CR>
    \:echo 'Mappings dumped to ~/vim-mappings.txt'<CR>

" Edit and reload vimrc.
nnoremap <leader>ce :edit $MYVIMRC<CR>
    \:echo 'Editing vimrc'<CR>
nnoremap <leader>cs :source $MYVIMRC<CR>
    \:echo 'vimrc reloaded'<CR>

" }}}

" {{{ Autocommands

augroup transparent_bg
    autocmd!
    au ColorScheme * call ApplyTransparentBG()
augroup END
call ApplyTransparentBG()   " Apply once on startup.

" Resize splits when window is resized.
augroup resize_ui
    autocmd!
    autocmd VimResized * wincmd =
augroup END

" Return to last cursor position when reopening a file.
augroup cursor_position
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \ | exe "normal! g'\""
        \ | endif
augroup END

" Set spell check for text files.
augroup spell_check
    autocmd!
    autocmd FileType markdown,text,gitcommit setlocal spell
augroup END

augroup help_fullscreen
    autocmd!
    " When any buffer window is entered, check if it's a help page
    " opened from an empty/unnamed buffer, then make it fullscreen
    autocmd BufWinEnter * if &filetype == 'help' && bufname('#') == '' | only | endif
augroup END

augroup whitespace_trailing
    autocmd!
    highlight whitespace_trailing ctermbg=red guibg=red
    autocmd BufWinEnter * match whitespace_trailing /\s\+$/
    autocmd ColorScheme * highlight whitespace_trailing ctermbg=red guibg=red
augroup END

" }}}

" {{{ Plugins

" --- The following files are loaded at startup. ---

" Netrw (The Unloved Directory Browser).
" '~/.vim/plugin/better-netrw.vim'

" ALE (Asynchronous Lint Engine).
" '~/.vim/plugin/ale.vim'

" Vim-Fugitive.
" No file!
"
" Vim-Surround.
" No file!

" Vim-Repeat.
" No file!
" This plugin supports: surround.vim, speeddating.vim, unimpaired.vim,
" vim-easyclip, vim-radical.

" Vim-DevIcons.
" '~/.vim/plugin/vim-devicons.vim'

" Vim-Airline.
" '~/.vim/plugin/vim-airline.vim'

" fzf for Vim.
" '~/.vim/plugin/fzf_for_vim.vim'

" vifm for Vim.
" '~/.vim/plugin/vifm_for_vim.vim'

" --- Put these at the very end of your '$VIMRC'. ---

" Load all plugins now. Plugins need to be added to runtimepath
" before helptags can be generated.
packloadall!

" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL

" }}}
