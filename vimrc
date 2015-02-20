" Last-modified: Fri Feb 20, 2015 05:30:22 PST

" Use Vim settings, rather then Vi settings (much better!).
set nocompatible

" Tell VIM that my terminal supports 256 colors
set t_Co=256

" https://github.com/tpope/vim-pathogen
execute pathogen#infect()

" Turn on the verboseness to see everything vim is doing.
" set verbose=9

" make sure that things show up in color
syntax enable

" set the color scheme
if has("gui_running")
  colorscheme candycode2
else
  colorscheme candycode2
endif

hi Normal guibg=NONE ctermbg=NONE

" set the font
set guifont=Menlo\ Regular:h12"

" set line numbering on
set number

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Make double-<Esc> clear search highlights
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>

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
set textwidth=140

" For Python
autocmd FileType python set ts=4 sw=4 et textwidth=140

" For Ruby
autocmd FileType ruby set ts=2 sw=2 et textwidth=140

" For Text
autocmd FileType text set textwidth=140

" For Gherkin
au Bufread,BufNewFile *.feature set filetype=gherkin

" Use Node.js for JavaScript interpretation
let $JS_CMD='node'

" do not keep a backup files
" set nobackup
set nowritebackup

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

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

inoremap jk <Esc>
imap hh =>
imap jj ->
imap uu _

" Setup NERDtree
let NERDTreeShowHidden=1
let g:NERDTreeWinSize = 30

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

" Turn on/off autoformatting (don't indent cascade when pasting)
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


if has("gui_running")
  set go=gmr
  au InsertEnter * hi statusline ctermfg=white ctermbg=darkred gui=bold
  au InsertLeave * hi statusline ctermfg=black ctermbg=gray gui=bold
  " 2 for the status line.
  set cmdheight=2
  " add columns for the Project plugin
  set columns=110
  " enable use of mouse
  set mouse=a
  " for the TOhtml command
  let html_use_css=1
  au InsertEnter * hi statusline ctermfg=white ctermbg=darkred gui=bold
  au InsertLeave * hi statusline ctermfg=black ctermbg=gray gui=bold
  " Switch syntax highlighting on, when the terminal has colors
  " Also switch on highlighting the last used search pattern.
  syntax on
  set hlsearch
endif

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

map <C-Left> <Esc>:tabprev<CR>
map <C-Right> <Esc>:tabnext<CR>
map <C-n> <Esc>:tabnew <Enter>

" Select all.
map <c-a> ggVG

" Undo in insert mode.
imap <c-z> <c-o>u

" Map CTRL-X to open/close NERDTree.  Still seems to also use CTRL-N in MacVIM
map <C-x> :NERDTreeToggle<CR>


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
  " with comments, at 140 characters.
  au BufNewFile,BufEnter *.c,*.h,*.java,*.jsp,*.sh,*.bash,*.pl,*.cgi,*.rb,*.py set formatoptions-=t tw=140

  " add an autocommand to update an existing time stamp when writing the file
  " It uses the functions above to replace the time stamp and restores cursor
  " position afterwards (this is from the FAQ)
  autocmd BufWritePre,FileWritePre *   ks|call UpdateTimeStamp()|'s

endif " has("autocmd")

" Close vim even if NERDTree is the only thing open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Reload the .vimrc or .gvimrc if it is edited
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so ~/.vimrc | if has('gui_running') | so ~/.gvimrc | endif
augroup END

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

" abbreviation to manually enter a timestamp. Just type LMTS in insert mode
iab LMTS <C-R>=TimeStamp()<CR>

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

" Highlight lines over 140 columns
function! LongLines()
    if has('matchadd')
        :au BufWinEnter * let w:m1=matchadd('Search', '\%<101v.\%>140v', -1)
        :au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>140v.\+', -1)
    else
        :au BufRead,BufNewFile * syntax match Search /\%<101v.\%>140v/
        :au BufRead,BufNewFile * syntax match ErrorMsg /\%>140v.\+/
    endif
endfunction

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
command! -bar LongLines call LongLines()
command! -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()
