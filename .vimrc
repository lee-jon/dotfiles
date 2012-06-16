" File: .vimrc
" Author: Lee-Jon Ball
" Edited: 2012-06-16 07:21:04.0 +0100
"


" ****************************************************************************
" BASIC EDITING ENVIRONMENT

" General
set nocompatible    " use vim not vi settings
filetype off
set history=1000    " Keeps 1000 lines of history
set shell=bash      " 

" Editing
set backspace=indent,eol,start  "set backspace function to something better

" Formatting
set shiftwidth=2    " Sets the tab width to two spaces
set tabstop=4       "
set softtabstop=4   "
set autoindent      " sets autoindenting on
set numberwidth=5   "
set showtabline=2   "
set winwidth=75     " window width

" UI
set ruler           " shows current position in bottom right
set guioptions-=T   " Remove MacVim GUI
set cursorline      " highlight current line
set cmdheight=2     " 2 line command

" Command display
set showmode
set showcmd


" ****************************************************************************
" COLORING AND SYNTAX HIGHLIGHTING
" Solarized plugin: http://ethanschoonover.com/solarized

syntax enable
set background=dark
colorscheme solarized


" ****************************************************************************
" PLUGIN MANAGER IS Vimbundle
" Run this command if Rakefile fails
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'vim-ruby/vim-ruby'  
 


" ****************************************************************************
" AUTOCMDs

augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et
  autocmd FileType python set sw=4 sts=4 et

  autocmd! BufRead,BufNewFile *.sass setfiletype sass 
  autocmd BufRead *.md        set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.mkd       set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;

  " Indent p tags
  autocmd FileType html,eruby if g:html_indent_tags !~ '\\|p\>' | let g:html_indent_tags .= '\|p\|li\|dt\|dd' | endif

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()

  " detect filetypes
  au BufRead,BufNewFile {*.md,*.mkd,*.markdown}              set ft=markdown
  au BufRead,BufNewFile {Cap,Gem,Vagrant}file,.autotest,*.ru set ft=ruby
  au BufRead,BufNewFile *.rake                               set ft=ruby 
  au BufRead,BufNewFile Procfile,.bundle/config,.gemrc       set ft=yaml
  au BufRead,BufNewFile *.sbt                                set ft=scala
  au BufRead,BufNewFile *.json                               set ft=javascript
  au BufRead,BufNewFile *.hkl                                set ft=haskell
  au BufRead,BufNewFile {COMMIT_EDITMSG}                     set ft=gitcommit 
augroup END


" ****************************************************************************
" NAVIGATION & MOVEMENT

" Naughty use of arrow keys removed
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" Better natural movement
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk



" ****************************************************************************
" STATUS LINE

set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)


" ****************************************************************************
" InsertTime COMMAND
" from https://github.com/garybernhardt/dotfiles/blob/master/.vimrc

command! InsertTime :normal a<c-r>=strftime('%F %H:%M:%S.0 %z')<cr>
