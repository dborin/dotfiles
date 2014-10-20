" Last-modified: Mon Oct 20, 2014 06:24:21 PDT

" set the color scheme
colorscheme candycode2
hi Normal guibg=NONE ctermbg=NONE

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

if has("gui")
  set go=gmr
  au InsertEnter * hi statusline guifg=white guibg=darkred gui=bold
  au InsertLeave * hi statusline guifg=black guibg=gray gui=bold
endif

if has("gui_running")
  " set size
  set lines=80 columns=250
  " 2 for the status line.
  set cmdheight=2
  " enable use of mouse
  set mouse=a
  " for the TOhtml command
  let html_use_css=1
  set guifont=Menlo\ Regular:h12"
  au InsertEnter * hi statusline guifg=white guibg=darkred gui=bold
  au InsertLeave * hi statusline guifg=black guibg=gray gui=bold
  map <C-S-V> "+gP
  imap <C-S-V> <ESC><C-S-V>a
  map <C-S-C> "+y
  imap <C-S-C> <ESC><C-S-C>a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
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


" Select all.
map <c-a> ggVG

" Undo in insert mode.
imap <c-z> <c-o>u

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

set showtabline=2 " always show tabs in gvim, but not vim
" set up tab labels with tab number, buffer name, number of windows
function! GuiTabLabel()
  let label = ''
  let bufnrlist = tabpagebuflist(v:lnum)
  " Add '+' if one of the buffers in the tab page is modified
  for bufnr in bufnrlist
    if getbufvar(bufnr, "&modified")
      let label = '+'
      break
    endif
  endfor
  " Append the tab number
  let label .= v:lnum.': '
  " Append the buffer name
  let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
  if name == ''
    " give a name to no-name documents
    if &buftype=='quickfix'
      let name = '[Quickfix List]'
    else
      let name = '[No Name]'
    endif
  else
    " get only the file name
    let name = fnamemodify(name,":t")
  endif
  let label .= name
  " Append the number of windows in the tab page
  let wincount = tabpagewinnr(v:lnum, '$')
  return label . '  [' . wincount . ']'
endfunction
set guitablabel=%{GuiTabLabel()}

" set up tab tooltips with every buffer name
function! GuiTabToolTip()
  let tip = ''
  let bufnrlist = tabpagebuflist(v:lnum)
  for bufnr in bufnrlist
    " separate buffer entries
    if tip!=''
      let tip .= " \n "
    endif
    " Add name of buffer
    let name=bufname(bufnr)
    if name == ''
      " give a name to no name documents
      if getbufvar(bufnr,'&buftype')=='quickfix'
        let name = '[Quickfix List]'
      else
        let name = '[No Name]'
      endif
    endif
    let tip.=name
    " add modified/modifiable flags
    if getbufvar(bufnr, "&modified")
      let tip .= ' [+]'
    endif
    if getbufvar(bufnr, "&modifiable")==0
      let tip .= ' [-]'
    endif
  endfor
  return tip
endfunction
set guitabtooltip=%{GuiTabToolTip()}

" Save screen location and size
"
"if has("gui_running")
"  function! ScreenFilename()
"    return $HOME.'/.vimsize'
"  endfunction
"
"  function! ScreenRestore()
"    " Restore window size (columns and lines) and position
"    " from values stored in vimsize file.
"    " Must set font first so columns and lines are based on font size.
"    let f = ScreenFilename()
"    if has("gui_running") && g:screen_size_restore_pos && filereadable(f)
"      let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
"      for line in readfile(f)
"        let sizepos = split(line)
"        if len(sizepos) == 5 && sizepos[0] == vim_instance
"          silent! execute "set columns=".sizepos[1]." lines=".sizepos[2]
"          silent! execute "winpos ".sizepos[3]." ".sizepos[4]
"          return
"        endif
"      endfor
"    endif
"  endfunction
"
"  function! ScreenSave()
"    " Save window size and position.
"    if has("gui_running") && g:screen_size_restore_pos
"      let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
"      let data = vim_instance . ' ' . &columns . ' ' . &lines . ' ' .
"            \ (getwinposx()<0?0:getwinposx()) . ' ' .
"            \ (getwinposy()<0?0:getwinposy())
"      let f = ScreenFilename()
"      if filereadable(f)
"        let lines = readfile(f)
"        call filter(lines, "v:val !~ '^" . vim_instance . "\\>'")
"        call add(lines, data)
"      else
"        let lines = [data]
"      endif
"      call writefile(lines, f)
"    endif
"  endfunction
"
"  if !exists('g:screen_size_restore_pos')
"    let g:screen_size_restore_pos = 1
"  endif
"  if !exists('g:screen_size_by_vim_instance')
"    let g:screen_size_by_vim_instance = 1
"  endif
"  autocmd VimEnter * if g:screen_size_restore_pos == 1 | call ScreenRestore() | endif
"  autocmd VimLeavePre * if g:screen_size_restore_pos == 1 | call ScreenSave() | endif
"endif
