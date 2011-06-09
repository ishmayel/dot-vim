" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
"runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
"    \| exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules according to the
" detected filetype. Per default Debian Vim only load filetype specific
" plugins.
"if has("autocmd")
"  filetype indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden         " Hide buffers when they are abandoned
set hlsearch		" Highlight search matches

"set mouse=a			" Enable mouse usage (all modes) in terminals
set showcmd			" Show (partial) command in status line.
set ruler			" Show line, column, etc. in status line
set number			" Show line numbers
set showmatch		" Show matching brackets/braces/parantheses.
set cinwords=if,else,while,do,for,switch,case	" Which keywords should indent 
set cindent		" indent on cinwords
set fileencodings=utf-8	" UTF-8 encoding
set encoding=utf-8 " UTF-8 encoding
set laststatus=2    " Show info in ruler
set wildmode=longest,list,full " Let TAB completion behave like bash's

set showtabline=2	" Always show tab line
set tabstop=4		" TAB is actually 4 spaces
set shiftwidth=4	" Doing >> on a block whill shift it one tab (based on ts setting above)
set softtabstop=4   " makes the spaces feel like real tabs
set expandtab		" Treat TAB as spacesa

" tab navigation
:nmap <A-PageUp> :tabprevious<CR>
:nmap <A-PageDown> :tabnext<CR>
:map <A-PageUp> :tabprevious<CR>
:map <A-PageDown> :tabnext<CR>
:imap <A-PageUp> <Esc>:tabprevious<CR>i
:imap <A-PageDown> <Esc>:tabnext<CR>i
:nmap <C-t> :tabnew<CR>
:imap <C-t> <Esc>:tabnew<CR>
:map <C-x> :tabclose<CR>
:nmap <C-a> :w<CR>
:imap <C-a> <Esc>:w<CR>

" "sudo" save:
:cmap w!! w !sudo tee % >/dev/null

" buffer navigation
:nnoremap <F2> :buffers<CR>:buffer<Space>

" Split window navigation
:nmap <silent> <A-Up> :wincmd k<CR>
:imap <silent> <A-Up> <Esc>:wincmd k<CR>i
:nmap <silent> <A-Down> :wincmd j<CR>
:imap <silent> <A-Down> <Esc>:wincmd j<CR>i
:nmap <silent> <A-Left> :wincmd h<CR>
:imap <silent> <A-Left> <Esc>:wincmd h<CR>i
:nmap <silent> <A-Right> :wincmd l<CR>
:imap <silent> <A-Right> <Esc>:wincmd l<CR>i
:nmap <silent> <C-Left> <C-w><
:nmap <silent> <C-Right> <C-w>>
:nmap <silent> <C-Up> <C-w>-
:nmap <silent> <C-Down> <C-w>+

" copen/ccl toggle

" toggles the quickfix window.
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
  else
    execute "copen " . 10
  endif
endfunction

" used to track the quickfix window
augroup QFixToggle
 autocmd!
 autocmd BufWinEnter quickfix let g:qfix_win = bufnr("$")
 autocmd BufWinLeave * if exists("g:qfix_win") && expand("<abuf>") == g:qfix_win | unlet! g:qfix_win | endif
augroup END

:inoremap <F4> <Esc>:call QFixToggle(0)<CR>
:nnoremap <F4> :call QFixToggle(0)<CR>

" NERDTree navigation
:nmap <silent> <F3> :NERDTreeToggle<CR>

" remove trailing spaces
autocmd FileType c,cpp,java,php autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

" Pathogen
filetype off
call pathogen#runtime_append_all_bundles()
"call pathogen#helptags() "call this when installing new plugins 
filetype plugin on

" themes
set background=dark
set t_Co=256
colorscheme solarized

" NERDTree
:let NERDChristmasTree=1
:let NERDTreeCaseSensitiveSort=1
:let NERDTreeChDirMode=2
:let NERDTreeBookmarksFile = $HOME . "/.vim/NERDTreeBookmarks"
:let NERDTreeShowBookmarks=1
:let NERDTreeShowHidden=1
:let NERDTreeQuitOnOpen=1

" Syntastic
let g:syntastic_auto_loc_list=1 " Auto-open error window if errors are detected

" JSLint
let g:JSLintHighlightErrorLine=1

" Current line highlighting only for current window
"set cursorline
"autocmd WinEnter * setlocal cursorline
"autocmd WinLeave * setlocal nocursorline
"hi Cursorline ctermbg=grey
