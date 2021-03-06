" #############################################################################
" # CONTENTS                                                                  #
" #############################################################################
" #                                                                           #
" # SECPLUG PLUGINS                                                           #
" # SEC0001 BASIC EDITOR SETTINGS                                             #
" # SEC0002 LOOK AND FEEL                                                     #
" # SEC0003 KEYBINDINGS                                                       #
" # SEC0004 KEYBOUND MECHANICS                                                #
" # SEC0005 LANGUAGE SETTINGS                                                 #
" # SECMISC MISC                                                              #
" #############################################################################

" l############################################################################# 
" # PLUGINS                                                           SECPLUG #
" #############################################################################

" vulndle header boulderplate start
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

Bundle 'gmarik/vundle'
" vulndle header boulderplate stop

" make tabs play nice
Bundle 'ervandew/supertab'

" syntax checking
Bundle 'w0rp/ale'
  let g:ale_completion_enabled = 0
  let g:ale_linters = {'cpp': ['clang', 'gcc']}
  let g:ale_cpp_clang_options = '-std=c++17 -Wall -Wextra'
  let g:ale_cpp_gcc_options = '-std=c++17 -Wall -Wextra'

Bundle 'godlygeek/tabular'

Bundle 'let-def/vimbufsync'
Bundle 'trefis/coquille'

" auto completion
Bundle 'Valloric/YouCompleteMe'
    let g:ycm_global_ycm_extra_conf = '~/rc/utilities/.ycm_extra_conf.py'
    " Prevent compatability issues with syntasic
    let g:ycm_show_diagnostics_ui = 0
    " make YCM compatible with UltiSnips (using supertab)
    let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
    let g:SuperTabDefaultCompletionType = '<C-n>'

" code snippets
Bundle 'sirver/ultisnips'
    " better key bindings for UltiSnipsExpandTrigger
    let g:UltiSnipsExpandTrigger = "<s-tab>"
    let g:UltiSnipsJumpForwardTrigger = "<s-tab>"
    "let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" syntax checking
"Bundle 'scrooloose/syntastic'
"    let g:syntastic_cpp_compiler = 'clang++'
"    let g:syntastic_cpp_compiler_options = '-std=c++15'

" pair parens, qoutes, etc
"Plugin 'Rainmondi/delimitMate'

" change the bottom bar
Bundle 'bling/vim-airline'
    set laststatus=2
    let g:airline_powerline_fonts=1
    " Themes migrated
    "let g:airline_theme="monokai"

" popout menu with code tags
Bundle 'majutsushi/tagbar'
    nmap <F3> :TagbarToggle<CR>

    " Allow toggling to the tagbar with a keyboard shortcut
    set switchbuf+=useopen
    nmap <C-e> :sb Tagbar<CR>

"popout menu with file explorer Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdtree'
    map <F2> :NERDTreeToggle<CR>
    " open nerdtree if no files opened
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    " close vim if nerdtree is the only open buffer
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Add multiline comment support for more languages
Bundle 'scrooloose/nerdcommenter'

" Doxygen comment generation
Bundle 'vim-scripts/DoxygenToolkit.vim'

" Rust integration
Plugin 'rust-lang/rust.vim'

" yankstack
"Plugin 'maxbrunsfeld/vim-yankstack'

" vulndle footer boulderplate start
call vundle#end()
filetype plugin indent on
" vulndle footer boulderplate stop
"
set rtp+=~/.vim

" #############################################################################
" # 1: BASIC EDITOR SETTINGS                                          SEC0001 #
" #############################################################################
" # Turn on basic editor functionality in vim                                 #
" #############################################################################

" display line numbers
set relativenumber
set number
set ruler

" set indents and tabs to 4 spaces
set tabstop=2
set shiftwidth=2
set autoindent
set expandtab
set smarttab

" highlight search results
set hlsearch

" start search without having to submit
set incsearch

" allow use of system clipboard
set clipboard=unnamed

" allow mouse for pasting etc
set mouse=a

" folding settings
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

" #############################################################################
" # 2: LOOK AND FEEL                                                  SEC0002 #
" #############################################################################
" # Basic font and color settings                                             #
" #############################################################################

"set 7 lines to cursor when scrolling
set so=7

" show whitespace
"set list
"set listchars=tab:>.,trail:.

" error bells
set noerrorbells
set visualbell

" set the default colorscheme
set t_Co=256
colors monokai
"set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
"set encoding=utf-8

" #############################################################################
" # 3: KEYBINDINGS                                                    SEC0003 #
" #############################################################################
" # Convenient keybindings                                                    #
" #############################################################################

" ues space to center the screen on the current line
nmap <space> zz

" Navigate buffers without needing W
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" Make Q and W work like their lowercase versions
cmap Q q
cmap W w

" build the project and show errors if any were found
map <f9> :make<bar>cw<CR>

" lookup assembly instructions
"autocmd Filetype asm map K :
autocmd Filetype asm map K :!x86doc <cword><CR>

" Run the current file
command R !./%

" #############################################################################
" # 4: KEYBOUND MECHANICS                                           # SEC0004 #
" #############################################################################
" # Keybindings which change default behavior                                 #
" #############################################################################

" :w!! to sudo save file
command Sw w !sudo tee % > /dev/null

" Make Y act like D and C to yank to the EOL
map Y y$

" Navigate editor lines and not file lines
nnoremap j gj
nnoremap k gk

" use n and N to center the next search result on the screen
nmap n nzz
nmap N Nzz

" #############################################################################
" # 5: LANGUAGE SETTINGS                                              SEC0005 #
" #############################################################################
" # Set any specific language settings here                                   #
" #############################################################################

" #############################################################################
" # PYTHON                                                                    #
" #############################################################################
" python tabs
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4

" #############################################################################
" # C                                                                         #
" #############################################################################
" Set correct syntax highlighting for different filetypes
au BufRead,BufNewFile *.def set filetype=c " use c syntax highlighting for gcc def files

" #############################################################################
" # CPP                                                                       #
" #############################################################################

" #############################################################################
" # Rust                                                                      #
" #############################################################################
" Set correct compiler for rust
au BufRead,BufNewFile Cargo.toml,Cargo.lock,*.rs compiler cargo

" #############################################################################
" # IMPCORE                                                                   #
" #############################################################################
" Use scheme syntax highlighting
au BufRead,BufNewFile *.imp set filetype=scheme

" #############################################################################
" # JAVACC                                                                    #
" #############################################################################
au BufRead,BufNewFile *.jj so ~/.vim/syntax/javacc.vim

" #############################################################################
" # SCHEME                                                                    #
" #############################################################################
" Prevent quote matching in scheme as a single quote marks a literal
autocmd Filetype scheme let b:delimitMate_quotes="\""

" #############################################################################
" # MISC                                                              SECMISC #
" #############################################################################
" # Use random vim features                                                   #
" #############################################################################

" wildmenu
set wildmode=longest:full,full
set wildmenu

" Persistent undo
try
    set undodir=~/.vim_runtime/temp_dirs/undodir
    set undofile
catch
endtry

set shell=/bin/zsh

" use the first tags file on a path to the root directory
set tags=./tags;

" easier access to go to insert mode, just use the nub keys
imap jf <Esc>
imap fj <Esc>

" set up better folding
set foldmethod=syntax

" More efficient macros
set lazyredraw

" Set python support
"let g:python3_host_prog = 'usr/bin/python3'
"let g:python_host_prog = 'usr/bin/python2'
