" File:   .vimrc
" Author: Lee-Jon Ball

" ****************************************************************************
" BASIC EDITING ENVIRONMENT

" General
set nocompatible    " use vim not vi settings
filetype off
set history=1000    " Keeps 1000 lines of history
set shell=zsh       " Sets shell used in :terminal
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
set number          " turns number lines on by default

" Visual and UI
set ruler           " shows current position in bottom right
set cursorline      " highlight current line
set showtabline=2   " Always shows the tabline
set cmdheight=2     " 2 line command
set winwidth=75     " window width
set laststatus=2    " Always show the command line: help PowerLine plugin

" Command display
set showmode
set showcmd

" Search
set hlsearch
set incsearch

" Leader key
let mapleader=","

" ****************************************************************************
" COLORING AND SYNTAX HIGHLIGHTING
" Solarized plugin: http://ethanschoonover.com/solarized

syntax enable
set background=dark
set t_Co=16
let g:solarized_termcolors=16
colorscheme solarized

" ****************************************************************************
" SPELLING AND HIGHLIGHTING
" turn on with :set spell spelllang=en_gb

set nospell
set spelllang=en_gb

" ****************************************************************************
" PLUGIN MANAGER IS Vimbundle
" Run this command if Rakefile fails
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Plugin 'gmarik/vundle'

Plugin 'dharanasoft/rtf-highlight'
Plugin 'elixir-lang/vim-elixir'
Plugin 'exu/pgsql.vim'
Plugin 'itmammoth/run-rspec.vim'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'lee-jon/vim-io'
Plugin 'lukerandall/haskellmode-vim'
Plugin 'mxw/vim-jsx'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-fireplace'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-ruby/vim-ruby'
Plugin 'vim-scripts/taglist.vim'
Plugin 'w0rp/ale'

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
  " autocmd FileType html,eruby if g:html_indent_tags !~ '\\|p\>' | let g:html_indent_tags .= '\|p\|li\|dt\|dd' | endif

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
  au BufRead,BufNewFile *.exs,*.ex                           set ft=elixir
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

set mouse=nicr

" ****************************************************************************
" STATUS LINE
" switched from statuslin -> powerline -> airline 2019

let g:airline#extensions#tabline#enabled = 1 "shows buffers
let g:airline_powerline_fonts = 1
let g:airline_solarized_bg='dark'


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

" ****************************************************************************
" RSpec mappings
" from: https://github.com/itmammoth/run-rspec.vim
" Navigate the spec window with
" e: jump to line
" n/q: next failure / previous
" q: close
let g:run_rspec_bin = 'bundle exec rspec'

nnoremap <leader>r :RunSpec<CR>
nnoremap <leader>l :RunSpecLine<CR>
nnoremap <leader>e :RunSpecLastRun<CR>
nnoremap <leader>cr :RunSpecCloseResult<CR>

" ****************************************************************************
" Git specific config

autocmd Filetype gitcommit setlocal spell textwidth=72

" ****************************************************************************
" Automatic Linting
"
" uses ALE
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'ruby': ['rubocop'],
\}
let g:ale_ruby_rubocop_executable = 'bundle'
let g:ale_linters_explicit = 1   "ensures ALE only runs specific linters
let g:ale_sign_column_always = 1 "Always marks problem column
"let g:ale_set_highlights = 0    "Ensures doesn't interfere with highlighting
