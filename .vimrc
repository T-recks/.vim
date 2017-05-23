
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2016 Jul 28
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" backup file settings
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp
set undodir=~/.vim/un

" tab settings
set tabstop=4

" Line number settings
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE guifg=DarkGrey guibg=NONE
highlight CursorLineNr term=bold ctermfg=Blue

set relativenumber
set number
highlight cursorline cterm=none

function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
    highlight CursorLineNr ctermfg=Yellow
    set cursorline
  else
    highlight CursorLineNr ctermfg=Blue
    set nocursorline
    set relativenumber
  endif
endfunc

map <C-n> :call NumberToggle()<cr>
autocmd InsertEnter * call NumberToggle()
autocmd InsertLeave * call NumberToggle()

" Spell-check set to F6
map <F6> :setlocal spell! spelllang=en_us<CR>

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
if has('syntax') && has('eval')
  packadd matchit
endif
