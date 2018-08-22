let mapleader=";"
call plug#begin()
" Java
Plug 'Dica-Developer/vim-jdb'

" Text exist
Plug 'triglav/vim-visual-increment'
" Code completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'fatih/vim-go'
Plug 'jodosha/vim-godebug'

" Plug 'zchee/nvim-go', { 'do': 'make'}
Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'zchee/deoplete-go', { 'do': 'make'}

" Javascript completion needs configuratio + Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
" spelling completion
Plug 'ujihisa/neco-look'
Plug 'vim-syntastic/syntastic'
Plug 'mhartington/nvim-typescript', { 'do': './install.sh' }
Plug 'mhartington/deoplete-typescript', { 'do': 'npm install -g typescript', 'for': 'typescript' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'Quramy/tsuquyomi'


" For async completion
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'artur-shaik/vim-javacomplete2'

" Async running make on save
Plug 'neomake/neomake'

" Organization
Plug 'tpope/vim-speeddating'
Plug 'jceb/vim-orgmode'

" Convinience
Plug 'kien/ctrlp.vim'

" Touchpeak plugins
Plug 'ghauerberg/vim-tplog'

" Colorscheme and UI
Plug 'vim-airline/vim-airline'
Plug 'Shougo/neco-syntax'
Plug 'vim-airline/vim-airline-themes'
Plug 'kaicataldo/material.vim'
Plug 'tomasiser/vim-code-dark'
Plug 'iCyMind/NeoSolarized'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tbastos/vim-lua'
Plug 'editorconfig/editorconfig-vim'

" Plantuml
Plug 'aklt/plantuml-syntax'

" json
Plug 'jiangmiao/auto-pairs'
Plug 'elzr/vim-json'

" AWS completion 
Plug 'm-kat/aws-vim'

call plug#end()
" Code completion
set omnifunc=syntaxcomplete#Complete
autocmd FileType java setlocal omnifunc=javacomplete#Complete

"" Go Lang configuration
let g:go_list_type = "quickfix"

"" Typing completion 
let g:deoplete#look#words = "/usr/local/dict/american-english"

" Colorscheme
set termguicolors
set background=dark
" colorscheme neosolarized
colorscheme codedark
let g:airline_theme = 'codedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#enabled = 1
" Completion configuration 
let g:deoplete#enable_at_startup = 1

""""" UI Configuration
map <C-n> :NERDTreeToggle<CR>
" using system clipboard to yank
set clipboard+=unnamed

" Required:
filetype plugin indent on

set relativenumber number
set backspace=indent,eol,start
set t_Co=256
" set termguicolors
set expandtab
set tabstop=2
set shiftwidth=2
set nowrap
set tw=80
syntax on

set ttimeoutlen=50
set autoindent
set cindent
" Syntastic 
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" let gradle generate the classpath and clean it up (bit slow)
let g:syntastic_java_javac_custom_classpath_command = "gradle -q classpath | grep ++++++++++++++ | awk '{print $1\":build/classes/java/main/:build/classes/java/test/\"}' | tr -d '++' | tr ':' '\n'"
" let g:syntastic_java_javac_custom_classpath_command = "gradle -q classpath | grep ++++++++++++++ | tr -d '++' | tr ':' '\n"

" Filetype assignment for odd types
autocmd BufRead,BufNewFile *.vm setlocal filetype html
" autocmd BufRead,BufNewFile *.ts setlocal filetype typescript
autocmd BufRead,BufNewFile *.java setlocal foldmethod=marker
autocmd BufRead,BufNewFile *.java vmap <leader>c dO/*<esc>o<backspace>/<esc>kp
" autocmd BufRead,BufNewFile *.pu setlocal filetype plantuml
autocmd BufRead,BufNewFile Jenkinsfile setlocal filetype groovy
autocmd BufRead,BufNewFile *.md set tw=80
autocmd BufRead,BufNewFile *.md set spell spelllang=en

" touchpeak tplogs
function! DetectTPLOG()
  if getline(1) =~ "CID" 
    set filetype=text
    set syntax=tplog
    nnoremap <leader>h :DecodeHEX<cr>
    nnoremap <leader>b :DecodeBase64<cr>
    nnoremap <leader>f :s/\%x1c/\r\n/g<cr>
    vnoremap <leader>f :'<,'>s/\%x1c/\r\n/g<cr>
    nmap <leader>s :SelectPBR<cr>
    call CollapsAllPBR()
  endif
endfunction

augroup filetypedetect
  au BufRead,BufNewFile * call DetectTPLOG()
augroup END

" folding
nnoremap <Space> za

" Key mappings 
" imap <Nul> <Space>
autocmd BufRead,BufNewFile *.cpp nmap <F3> :FufFile
autocmd BufRead,BufNewFile *.cpp nmap <F10> :make clean
autocmd BufRead,BufNewFile *.cpp nmap <F9> :make all

autocmd BufRead,BufNewFile *.go nmap <F2> :GoToggleBreakpoint<Enter>
autocmd BufRead,BufNewFile *.go nmap <leader>b :GoToggleBreakpoint<Enter>
autocmd BufRead,BufNewFile *.go nmap <F3> :GoDef<Enter>
autocmd BufRead,BufNewFile *.go nmap <F8> :GoDebug<Enter>
autocmd BufRead,BufNewFile *.go nmap <F10> :GoBuild<Enter>
autocmd BufRead,BufNewFile *.go nmap <F11> :GoTest<Enter>

" autocmd FileType java setlocal omnifunc=javacomplete#Complete
" autocmd FileType java call javacomplete#Start()

" Typescript
let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = ''
autocmd FileType typescript :nmap <F12> :TSDef<Enter>
autocmd FileType typescript :set makeprg=tsc
autocmd FileType typescript :call neomake#configure#automake('w')
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi'] " You shouldn't use 'tsc' checker.

" Auto completion
let g:UltiSnipsSnippetDirectories=["UltiSnips", "~/.vim/plugged/aws-vim/snips"]

" CTRL-p search
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|class)$',
  \ }
"
" if make has any errors auto display
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch

" nnoremap <leader><space> :noh<cr>
" nnoremap <tab> %
" vnoremap <tab> %
" Easy jump motions
nmap <C-h> b
nmap <C-j> 5j
nmap <C-k> 5k
nmap <C-l> e

vmap <C-h> b
vmap <C-j> 5j
vmap <C-k> 5k
vmap <C-l> e

" change tap
nmap <silent> ) :tabnext<CR>
nmap <silent> ( :tabprev<CR>

vmap > >gv
vmap < <gv

map <esc> :noh<cr>

" Tab control
nmap <silent> <A-Right> :wincmd l<cr>
nmap <silent> <A-Left> :wincmd h<cr>
nmap <silent> <A-Up> :wincmd k<cr>
nmap <silent> <A-Down> :wincmd j<cr>

let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'
