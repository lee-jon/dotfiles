" File:   .vimrc
" Author: Lee-Jon Ball


" ****************************************************************************
" BASIC EDITING ENVIRONMENT

" General
set nocompatible    " use vim not vi settings
filetype off
set history=1000    " Keeps 1000 lines of history
set shell=bash      "
filetype plugin indent on

" Editing
set backspace=indent,eol,start  "set backspace function to something better
set encoding=utf-8  " sets to UTF8

" Formatting
set autoindent      " sets autoindenting on
set expandtab       " converts tabs to spaces
set shiftwidth=2    " Sets the tab width to two spaces
set tabstop=4       "
set softtabstop=4   "
set numberwidth=5   "
set encoding=utf-8  " Necessary to show unicode glyphs

set nrformats=      " sets number formats to decimal for CTRL-A

" Visual and UI
set ruler           " shows current position in bottom right
set guioptions-=T   " Remove MacVim GUI
set cursorline      " highlight current line
set showtabline=2   "
set cmdheight=2     " 2 line command
set winwidth=75     " window width
set laststatus=2    " Always show the command line: help PowerLine plugin

" Command display
set showmode
set showcmd

" Search
set hlsearch
set incsearch

" ****************************************************************************
" COLORING AND SYNTAX HIGHLIGHTING
" Solarized plugin: http://ethanschoonover.com/solarized

syntax enable
set background=dark
set t_Co=16
let g:solarized_termcolors=16
colorscheme solarized


" ****************************************************************************
" PLUGIN MANAGER IS Vimbundle
" Run this command if Rakefile fails
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-commentary'
Bundle 'kchmck/vim-coffee-script'
Bundle 'Lokaltog/vim-powerline'
Bundle 'scrooloose/nerdtree'
Bundle 'lee-jon/vim-io'
Bundle 'vim-scripts/taglist.vim'
Bundle 'lukerandall/haskellmode-vim'

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
  au BufRead,BufNewFile *.coffee                             set ft=coffee
  au BufRead,BufNewFile *.hkl                                set ft=haskell
  au BufRead,BufNewFile {COMMIT_EDITMSG}                     set ft=gitcommit
  au BufRead,BufNewFile *.io                                 set ft=io
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

" set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
" Status line is now being driven by https://github.com/Lokaltog/vim-powerline

" TODO: Need a patched font to run the below with powerline
let g:Powerline_symbols = 'unicode'
let g:Powerline_stl_path_style = 'short' " default: relative


" ****************************************************************************
" InsertTime COMMAND
" from https://github.com/garybernhardt/dotfiles/blob/master/.vimrc

command! InsertTime :normal a<c-r>=strftime('%F %H:%M:%S.0 %z')<cr>


" ****************************************************************************
" NerdTree Plugin - open nerdtree if no file is specified
" from srooloose/nerdtree
autocmd vimenter * if !argc() | NERDTree | endif
map <F3> :NERDTreeToggle<cr>

" ****************************************************************************
" Taglist Plugin - configuration
" from vim-scripts/taglist.vim

let Tlist_Ctags_Cmd = "ctags"  "OSX ctags on /bin/usr/ctags has been overridden
let Tlist_WinWidth  = 50
map <F4> :TlistToggle<cr>


" ****************************************************************************
" Strip trailing whitespace

function! <SID>StripTrailingWhitespaces()
  let _s=@/
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  let @/=_s
  call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()


