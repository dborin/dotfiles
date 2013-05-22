" Last-modified: Fri Mar 16, 2012 12:23:04 PDT

" Use Vim settings, rather then Vi settings (much better!).
set nocompatible

" Turn on the verboseness to see everything vim is doing.
" set verbose=9

" set the color scheme
colorscheme candycode2

" set the font
set guifont=Menlo\ Regular:h13"

" set line numbering on
set number

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Set 4 spaces for indenting
set shiftwidth=2

" Set 4 spaces for stops
set tabstop=2

" Spaces instead of tabs
set expandtab

" Always set auto indenting on
set autoindent

"When auto-indenting, use the indenting format of the previous line
set copyindent

" select when using the mouse
set selectmode=mouse

" set total line length
set textwidth=100

" For Python
autocmd FileType python set ts=4 sw=4 et textwidth=100

" For Text
autocmd FileType text set textwidth=100

" do not keep a backup files
" set nobackup
set nowritebackup

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

if has('gui_running')

endif

" keep 500 lines of command line history
set history=500

" show the cursor position all the time
set ruler

" show (partial) commands
set showcmd

" do incremental searches (annoying but handy);
set incsearch

" Show  tab characters. Visual Whitespace.
set list
set listchars=tab:>.

" Set ignorecase on
set ignorecase

" Don't ignore case when the search pattern has uppercase
set smartcase

" smart search (override 'ic' when pattern has uppers)
set scs

" Set 'g' substitute flag on
" set gdefault

" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
inoremap jk <Esc>
imap hh =>
imap uu _

nnoremap JJJJ <Nop>

" When I close a tab, remove the buffer
set nohidden

" Set status line
set statusline=%F%m%r%h%w\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [LEN=%L]\ %4l,%02c%2V\ %p%%

" now set it up to change the status line based on mode
au InsertEnter * hi statusline ctermfg=white ctermbg=darkred gui=bold
au InsertLeave * hi statusline ctermfg=black ctermbg=gray gui=bold

" Always display a status line at the bottom of the window
set laststatus=2

" Set vim to use 'short messages'.
" set shortmess=a

" Insert two spaces after a period with every joining of lines.
" set joinspaces

" showmatch: Show the matching bracket for the last ')'?
set showmatch

" allow tilde (~) to act as an operator -- ~w, etc.
set notildeop

set pastetoggle=<F2>

" Java specific stuff
let java_highlight_all=1
let java_highlight_debug=1
let java_ignore_javadoc=1
let java_highlight_functions=1
let java_mark_braces_in_parens_as_errors=1

" highlight strings inside C comments
let c_comment_strings=1

" Commands for :Explore
let g:explVertical=1    " open vertical split winow
let g:explSplitRight=1  " Put new window to the right of the explorer
let g:explStartRight=0  " new windows go to right of explorer window


if has("gui")
  " set the gui options to:
  "   g: grey inactive menu items
  "   m: display menu bar
  "   r: display scrollbar on right side of window
  "   b: display scrollbar at bottom of window
  "   t: enable tearoff menus on Win32
  "   T: enable toolbar on Win32
  set go=gmr
  set guifont=Menlo\ Regular:h13"
  au InsertEnter * hi statusline ctermfg=white ctermbg=darkred gui=bold
  au InsertLeave * hi statusline ctermfg=black ctermbg=gray gui=bold
endif

if has("gui_running")
  " 2 for the status line.
  set cmdheight=2
  " add columns for the Project plugin
  set columns=110
  " enable use of mouse
  set mouse=a
  " for the TOhtml command
  let html_use_css=1
  set guifont=Menlo\ Regular:h13"
  au InsertEnter * hi statusline ctermfg=white ctermbg=darkred gui=bold
  au InsertLeave * hi statusline ctermfg=black ctermbg=gray gui=bold
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" for cygwin
" set shell=C:/cygwin/bin/bash
" set shellcmdflag=--login\ -c
" set shellxquote=\"


" ************************************************************************
" C O M M A N D S
"

"switch to directory of current file
command! CD cd %:p:h

" ************************************************************************
" K E Y   M A P P I N G S
"
map <Leader>e :Explore<cr>
map <Leader>s :Sexplore<cr>

" pressing < or > will let you indent/unident selected lines
vnoremap < <gv
vnoremap > >gv

" Don't use Ex mode, use Q for formatting
map Q gq

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>

" Make tab in v mode work like I think it should (keep highlighting):
vmap <tab> >gv
vmap <s-tab> <gv

" map ,L mz1G/Last modified:/e<Cr>CYDATETIME<Esc>`z
map ,L    :let @z=TimeStamp()<Cr>"zpa
map ,datetime :let @z=strftime("%d %b %Y %X")<Cr>"zpa
map ,date :let @z=strftime("%d %b %Y")<Cr>"zpa

" Map <c-s> to write current buffer.
map <c-s> :w<cr>
imap <c-s> <c-o><c-s>

" Buffer naviation
map <M-Left> :bprevious<CR>
map <M-Right> :bnext<CR>


" Select all.
map <c-a> ggVG

" Undo in insert mode.
imap <c-z> <c-o>u


" ************************************************************************
" B E G I N  A U T O C O M M A N D S
"
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Normally don't automatically format 'text' as it is typed, only do this
  " with comments, at 79 characters.
  au BufNewFile,BufEnter *.c,*.h,*.java,*.jsp,*.sh,*.bash,*.pl,*.cgi set formatoptions-=t tw=100

  " add an autocommand to update an existing time stamp when writing the file
  " It uses the functions above to replace the time stamp and restores cursor
  " position afterwards (this is from the FAQ)
  autocmd BufWritePre,FileWritePre *   ks|call UpdateTimeStamp()|'s

endif " has("autocmd")

" GUI ONLY type stuff.
if has("gui")
  :menu &MyVim.Current\ File.Convert\ Format.To\ Dos :set fileformat=dos<cr> :w<cr>
  :menu &MyVim.Current\ File.Convert\ Format.To\ Unix :set fileformat=unix<cr> :w<cr>
  :menu &MyVim.Current\ File.Remove\ Trailing\ Spaces\ and\ Tabs :%s/[	]*$//g<cr>
  :menu &MyVim.Current\ File.Remove\ Ctrl-M :%s/^M//g<cr>
  :menu &MyVim.Current\ File.Remove\ All\ Tabs :retab<cr>
  :menu &MyVim.Current\ File.To\ HTML :runtime! syntax/2html.vim<cr>
  :amenu &MyVim.Insert.Last\ &Modified<Tab>,L <Esc><Esc>:let @z=TimeStamp()<CR>"zpa
  :amenu &MyVim.-SEP1- <nul>
  :amenu &MyVim.&Global\ Settings.Toggle\ Display\ Unprintables<Tab>:set\ list!	:set list!<CR>
  :amenu &MyVim.-SEP2- <nul>
  :amenu &MyVim.&Project :Project<CR>

  " hide the mouse when characters are typed
  set mousehide
endif

" Highlight lines over 100 columns
if has('matchadd')
    :au BufWinEnter * let w:m1=matchadd('Search', '\%<101v.\%>100v', -1)
    :au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>100v.\+', -1)
else
    :au BufRead,BufNewFile * syntax match Search /\%<101v.\%>100v/
    :au BufRead,BufNewFile * syntax match ErrorMsg /\%>100v.\+/
endif

" Show trailing whitespace or tag/space in blinding red
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufWinEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/
au BufWinLeave * call clearmatches()

" ************************************************************************
" A B B R E V I A T I O N S
"
abbr #b /************************************************************************
abbr #e  ************************************************************************/

" abbr hosts C:\WINNT\system32\drivers\etc\hosts

" abbreviation to manually enter a timestamp. Just type YTS in insert mode
" iab LMTS <C-R>=TimeStamp()<CR>
iab YTS <C-R>=TimeStamp()<CR>

" Date/Time stamps
" %a - Day of the week
" %b - Month
" %d - Day of the month
" %Y - Year
" %H - Hour
" %M - Minute
" %S - Seconds
" %Z - Time Zone
iab YDATETIME <c-r>=strftime(": %a %b %d, %Y %H:%M:%S %Z")<cr>


" ************************************************************************
"  F U N C T I O N S
"

" first add a function that returns a time stamp in the desired format
if !exists("*TimeStamp")
    fun TimeStamp()
        return "Last-modified: " . strftime("%a %b %d, %Y %H:%M:%S %Z")
    endfun
endif

" searches the first ten lines for the timestamp and updates using the
" TimeStamp function
if !exists("*UpdateTimeStamp")
function! UpdateTimeStamp()
   " Do the updation only if the current buffer is modified
   if &modified == 1
       " go to the first line
       exec "1"
      " Search for Last modified:
      let modified_line_no = search("Last-modified:")
      if modified_line_no != 0 && modified_line_no < 10
         " There is a match in first 10 lines
         " Go to the : in modified:
         exe "s/Last-modified: .*/" . TimeStamp()
     endif
 endif
 endfunction
endif

function! ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function! TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

command! -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command! -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()
nnoremap <F12>     :ShowSpaces 1<CR>
nnoremap <S-F12>   m`:TrimSpaces<CR>``
vnoremap <S-F12>   :TrimSpaces<CR>

" autocmd BufWritePre *.py :TrimSpaces

" autocmd BufWritePost .vimrc source %
