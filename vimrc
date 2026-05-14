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

" How to handle backup files.
set backupdir=$HOME/.vim/temp//         " Where Vim stashes backup files.
set directory=$HOME/.vim/temp/swap//    " Where Vim stashes swap files.
set undodir=$HOME/.vim/temp/undo//      " Where Vim stashes undo files.

" Make those folders automatically if they don't already exist.
for s:dir in [&backupdir, &directory, &undodir]
    if !isdirectory(expand(s:dir))
        call mkdir(expand(s:dir), 'p', 0700)
    endif
endfor

set swapfile            " Recover unsaved changes after a crash.
set writebackup         " Create a backup while editing.
set nobackup            " Delete backup once the write succeeds.
set undofile            " Persist undo history across sessions.

" Store Vim info.
" Marks (') -- remembers cursor positions in recently edited files
" Registers (<) -- saves yanked/deleted text
" Buffers (%) -- restores open files on next launch
" Search (h, /) -- saves search history and highlight state
" Commands (:) -- saves command-line history
" Variables (!) -- saves global variables
" File path (n) -- where to store the viminfo file
" Input (@) -- saves input line history
" Media (r) -- excludes removable drives from mark saving
" Size (s) -- limits register item size to prevent huge viminfo files
set viminfo='100,<50,h
if exists('&viminfofile')
    " This option is new in Vim 8.1+.
    let &viminfofile = expand('$HOME/.vim/viminfo')
else
    let &viminfo .= ',n' .. expand('$HOME/.vim/viminfo')
endif

" No intro message.
set shortmess+=I

" }}}

" {{{ Encoding, Filetype & Syntax

" BOM (Byte Order Mark) is a hidden marker at the start of a file that
" identifies its encoding. nobomb prevents Vim from writing it. It causes
" problems with UTF-8 files used in Linux/Unix tools, scripts, HTML, and XML.
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,big5-hkscs,gb2312,euc-jp,euc-kr,latin1
set nobomb

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
        set guiheadroom=0       " Ugly gap in gVim.
    elseif has("mac")
        set guifont=Hack\ Nerd\ Font:h13
    endif
    set guioptions-=meTlr       " Remove: menubar, tabbar, toolbar, scrollbars.
    set lines=50 columns=96
else                            " Terminal running.
    set t_ut=                   " Disable BCE to fix white flash in terminals.
    let s:os = join(readfile('/etc/os-release'), "\n")
    if s:os =~? "arch"
        colorscheme retrobox    " WSL2 Arch.
    elseif s:os =~? "debian"
        colorscheme snow        " WSL2 Debian.
    else
        colorscheme jellybeans  " Other.
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

set noexpandtab         " Keep real tabs; expandtab breaks shell 'cat' output.
set smarttab            " Insert tabs at line start based on shiftwidth.

set cursorcolumn        " Highlight current column.
set cursorline          " Highlight current line.
set hlsearch            " Highlight matches.
set incsearch           " Search as chars are entered.
set ignorecase          " Ignore case when searching.
set smartcase           " Case-sensitive if pattern contains uppercase.

set wildmenu                    " Enable visual autocomplete in the command bar.
set wildmode=list:longest,full  " Show full list, then cycle matches.
set wildignore+=.DS_Store,*.git
set wildignore+=*/tmp/*

" Spell check language.
" The Spanish is Mexican Spanish.
set spelllang=en_us,es

" Word list for keyword completion.
if has('unix') && filereadable('/usr/share/dict/words')
    set dictionary=/usr/share/dict/words
endif

" }}}

" {{{ Behavior

"set noshowmatch            " Disable jumping to matching bracket when typing.
set noshowmode              " Hide the default mode text (e.g. -- INSERT --).
set notitle                 " Do not set the terminal title to the filename.
set number                  " Display line numbers.
set ruler                   " The ruler is displayed on the status line.

" Replace the glyphs below with your preferred Nerd Font symbols.
set listchars=tab:⇥\ \ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
set laststatus=2            " Always show the status line.
set list                    " Show invisible characters.
set showbreak=↳             " Marker shown at the start of a wrapped line.
set wrap                    " Wrap long lines.

set belloff=all             " Mute all bell sounds.
set hidden                  " Allow switching buffers without saving.
set switchbuf=usetab        " Include tabs when switching buffers.
"set autochdir              " !! It may conflicts with Netrw.
"set ttyfast                " No-op in Vim 8+; removed.
"
" The following will be overrided by Vim-Airline.
" Fill characters in the status line:
"   stl:\  — fills the active window's status line with spaces
"   stlnc:\ — fills inactive windows' status lines with backslashes
"set fillchars+=stl:\ ,stlnc:\
"set showtabline=1          " Show tabline when at least 2 tabs are open.

set foldcolumn=2            " Show fold indicator column (width 2).
set foldenable              " Enable folding.
set foldlevel=0             " Fold all levels on open.
set foldmethod=marker       " Use markers for folding.

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
if executable('wslpath')
    " Copy to clipboard which solves Unicode support.
    if executable('wl-copy')
        vnoremap <leader>y :w !wl-copy<CR><CR>:echo 'Yanked to clipboard'<CR>
        nnoremap <leader>p :r !wl-paste<CR>
    else
        " Fallback: temp file via PowerShell for Unicode support.
        function! CopyToClipboard() range
            let tmpfile = tempname()
            execute a:firstline . ',' . a:lastline . 'w ' . tmpfile
            call system('powershell.exe -command "Get-Content -Encoding UTF8 ''\\\\wsl.localhost\\' . $WSL_DISTRO_NAME . '\\' . substitute(tmpfile, '/', '\\\\', 'g')[1:] . ''' | Set-Clipboard"')
            call delete(tmpfile)
        endfunction
        vnoremap <leader>y :call CopyToClipboard()<CR>:echo 'Yanked to clipboard'<CR>
        nnoremap <leader>p :r !powershell.exe Get-Clipboard<CR>
    endif
endif

" }}}

" {{{ Mappings

" Pane manipulation.
nnoremap <leader>h <C-W>h
nnoremap <leader>j <C-W>j
nnoremap <leader>k <C-W>k
nnoremap <leader>l <C-W>l
nnoremap <leader>w <C-W>w

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
nnoremap <F2>   :set paste!<CR>:echo 'PASTE mode ' . (&paste ? 'on' : 'off')<CR>
" Toggle scroll binding.
nnoremap <F3> :set scrollbind! \| echo (&scrollbind ? 'Scroll binding on' : 'Scroll binding off')<CR>

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

" Toggle ruler.
nnoremap <F4>   :call ToggleNumbers()<CR>
" Toggle tabs/spaces.
nnoremap <F6>   :set expandtab!<CR>
    \:echom 'expandtab ' . (&expandtab ? 'on (spaces)' : 'off (tabs)')<CR>
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
nnoremap <F12>  :let g:rot13_on = !get(g:, 'rot13_on', 0)<CR>ggVGg?
    \:echo 'ROT13 ' . (g:rot13_on ? 'on' : 'off')<CR>

" Clear search highlights.
nnoremap <C-L>  :nohlsearch<CR><C-L>
    \:echo 'All cleared.'<CR>

" Yank fold title.
nnoremap yt     :let @"=matchstr(getline('.'), '\v\{\{\{ \zs.*')<CR>
    \:echo 'Yanked: ' . @"<CR>

" Generate tags recursively from current directory.
nnoremap <leader>ct :!ctags -R<CR>
    \:echo 'Tags generated.'<CR>

" Trim trailing whitespace.
function! TrimWhitespace()
    let [l:pos, l:search] = [getpos('.'), @/]
    %s/\s\+$//e
    let [@/, l:_] = [l:search, setpos('.', l:pos)]
endfunction

nnoremap <leader>tw  :call TrimWhitespace()<CR>
    \:echo 'Trailing whitespace trimmed'<CR>

" Apply transparent background.
function! ApplyTransparentBG()
    highlight Normal guibg=NONE ctermbg=NONE
endfunction

nnoremap <leader>tb :call ApplyTransparentBG()<CR>
    \:echo 'Transparent background applied'<CR>

" Dump all mappings to file.
nnoremap <leader>m  :redir! > ~/vim-mappings.txt<CR>:silent map<CR>:redir END<CR>
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
" Set Run-time path.
if has('linux')
    if isdirectory('/usr/share/fzf')
        set runtimepath+=/usr/share/fzf
    elseif isdirectory('/usr/share/doc/fzf/examples')
        set runtimepath+=/usr/share/doc/fzf/examples
    endif
elseif has("mac")
    set runtimepath+=/usr/local/opt/fzf
endif

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
