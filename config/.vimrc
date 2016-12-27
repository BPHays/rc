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

" #############################################################################
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

" auto completion
Bundle 'Valloric/YouCompleteMe'
    " Prevent compatability issues with syntasic
    let g:ycm_show_diagnostics_ui = 0
    " make YCM compatible with UltiSnips (using supertab)
    let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
    let g:SuperTabDefaultCompletionType = '<C-n>'

" code snippets
Bundle 'sirver/ultisnips'
    " better key bindings for UltiSnipsExpandTrigger
    let g:UltiSnipsExpandTrigger = "<tab>"
    let g:UltiSnipsJumpForwardTrigger = "<tab>"
    let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" syntax checking
Bundle 'scrooloose/syntastic'

" pair parens, qoutes, etc
Plugin 'Rainmondi/delimitMate'

" change the bottom bar
Bundle 'bling/vim-airline'
    set laststatus=2
    let g:airline_powerline_fonts=1
    let g:airline_theme="monokai"

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

" vulndle footer boulderplate start
call vundle#end()
filetype plugin indent on
" vulndle footer boulderplate stop

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
set tabstop=4
set shiftwidth=4
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
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
set encoding=utf-8

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

" clear highlighting until next search
nnoremap <C-L> :nohl<CR><C-L>

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

" python tabs
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4

" Set correct syntax highlighting for different filetypes
au BufRead,BufNewFile *.def set filetype=c " use c syntax highlighting for gcc def files

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

" More efficient macros
set lazyredraw
