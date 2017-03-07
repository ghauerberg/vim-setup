" Skip if vim-tiny or vim-small
if 0 | endif

if &compatible
   set nocompatible               " Be iMproved
 endif

 " Required:
 set runtimepath+=~/.vim/bundle/neobundle.vim/

 " Required:
 call neobundle#begin(expand('~/.vim/bundle/'))

 " Let NeoBundle manage NeoBundle
 " Required:
 NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'SirVer/ultisnips'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'Quramy/tsuquyomi'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'Shougo/vimproc.vim', {
    \ 'build' : {
    \     'windows' : 'tools\\update-dll-mingw',
    \     'cygwin' : 'make -f make_cygwin.mak',
    \     'mac' : 'make -f make_mac.mak',
    \     'linux' : 'make',
    \     'unix' : 'gmake',
    \    },
    \ }
NeoBundle 'Valloric/YouCompleteMe', {
     \ 'build' : {
     \     'mac' : './install.sh --clang-completer --system-libclang --omnisharp-completer',
     \     'unix' : './install.sh --clang-completer --system-libclang --omnisharp-completer',
     \     'windows' : './install.sh --clang-completer --system-libclang --omnisharp-completer',
     \     'cygwin' : './install.sh --clang-completer --system-libclang --omnisharp-completer'
     \    }
     \ }

NeoBundle 'starcraftman/vim-eclim'
NeoBundle 'ghauerberg/vim-jdb'

 call neobundle#end()

 " Required:
 filetype plugin indent on

 " If there are uninstalled bundles found on startup,
 " this will conveniently prompt you to install them.
 NeoBundleCheck

set relativenumber number
colorscheme delek
set backspace=indent,eol,start
set t_Co=256
" set termguicolors
set expandtab
set tabstop=2
set nowrap
syntax on

" iterm cursor type
" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

if has('mac') && ($TERM == 'xterm-256color' || $TERM == 'screen-256color')
  map <Esc>OP <F1>
  map <Esc>OQ <F2>
  map <Esc>OR <F3>
  map <Esc>OS <F4>
  map <Esc>[16~ <F5>
  map <Esc>[17~ <F6>
  map <Esc>[18~ <F7>
  map <Esc>[19~ <F8>
  map <Esc>[20~ <F9>
  map <Esc>[21~ <F10>
  map <Esc>[23~ <F11>
  map <Esc>[24~ <F12>
endif

map <F12> :echo 'mapped'<CR>
map <F12> :echo 'mapped ctrl'<CR>


filetype plugin indent on
set ttimeoutlen=50
set autoindent
set cindent
" Filetype assignment for odd types
au BufRead,BufNewFile *.vm setfiletype html
au BufRead,BufNewFile *.java setlocal foldmethod=syntax
au BufRead,BufNewFile *.pu setfiletype plantuml
au BufRead,BufNewFile Jenkinsfile setfiletype groovy
au BufRead,BufNewFile *.md set tw=80

" Key mappings
" imap <Nul> <Space>
let mapleader=","
au BufRead,BufNewFile *.cpp nmap <F3> :FufFile
au BufRead,BufNewFile *.cpp nmap <F10> :make clean
au BufRead,BufNewFile *.cpp nmap <F9> :make all

au BufRead,BufNewFile *.java nnoremap <F11> :JDBDebugProcess<cr>
au BufRead,BufNewFile *.java nnoremap <F10> :JDBAttach localhost:5005<cr>
au BufRead,BufNewFile *.java nnoremap <F9> :JDBCommand locals<cr>
au BufRead,BufNewFile *.java nnoremap <F8> :JDBContinue<cr>
au BufRead,BufNewFile *.java nnoremap <F5> :JDBStepIn<cr>
au BufRead,BufNewFile *.java nnoremap <F6> :JDBStepOver<cr>
au BufRead,BufNewFile *.java nnoremap <F7> :JDBStepUp<cr>
au BufRead,BufNewFile *.java nnoremap <F4> :JDBBreakpointOnLine<cr>
au BufRead,BufNewFile *.java nnoremap <F3> :JDBClearBreakpointOnLine<cr>
au BufRead,BufNewFile *.java nnoremap <F12> :!gradle classes testClasses<cr>
au BufRead,BufNewFile *.java set makeprg=gradle

" Commenting line
let @e='0i//j'
let @r='0xxj'
nnoremap <leader>c @e
nnoremap <leader>x @r

" Folding
nnoremap <space> za
" Quit all
nnoremap <leader>q :qa!<cr>
nnoremap <leader>s :w<cr>

" Settings for UltiSnips
function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            call UltiSnips#JumpForwards()
            " return '\<C-n>'
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

let g:UltiSnipsExpandTrigger = "<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<C-Tab>"
let g:UltiSnipsListSnippets="<c-e>"

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-r>=g:UltiSnips_Complete()<cr>"
" vmap <Tab> g:UltiSnipsExpandTrigger
" xnoremap <Tab> :call UltiSnips#SaveLastVisualSelection()<CR>gvs
" let g:UltiSnipsListSnippets = "<C-l>"
" let g:UltiSnipsJumpForwardTrigger = "<Tab>"
" let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"

" Settings for You complete me
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_autoclose_preview_window_after_insertion = 1
" let g:ycm_use_ultisnips_completer = 1
" let g:ycm_key_list_select_completion=['<C-j>', '<Down>']
" let g:ycm_key_list_previous_completion=['<C-k>', '<Up>'] 
" let g:ycm_key_invoke_completion = '<S-Tab>'
" let g:ycm_key_detailed_diagnostics = '<leader>d'

" Eclim settings
let g:EclimCompletionMethod = 'omnifunc'
" Settings for searching and moving
" nnoremap / /\v
" vnoremap / /\v
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

function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline guibg=yellow
  elseif a:mode == 'r'
    hi statusline guibg=magenta
  else
    hi statusline guibg=red
  endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertChange * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline guibg=green

" default the statusline to green when entering Vim
hi statusline guibg=green

if $TMUX == ''
    set clipboard+=unnamed
endif


set statusline=
set statusline+=%7*\[%n]                                  "buffernr
set statusline+=%1*\ %<%F\                                "File+path
set statusline+=%2*\ %y\                                  "FileType
set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
set statusline+=%4*\ %{&ff}\                              "FileFormat (dos/unix..) 
set statusline+=%5*\ %{&spelllang}\%{HighlightSearch()}\  "Spellanguage & Highlight on?
set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
set statusline+=%9*\ col:%03c\                            "Colnr
set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly? Top/bot

function! HighlightSearch()
  if &hls
    return 'H'
  else
    return ''
  endif
endfunction

hi User1 guifg=#ffdad8  guibg=#880c0e
hi User2 guifg=#000000  guibg=#F4905C
hi User3 guifg=#292b00  guibg=#f4f597
hi User4 guifg=#112605  guibg=#aefe7B
hi User5 guifg=#051d00  guibg=#7dcc7d
hi User7 guifg=#ffffff  guibg=#880c0e gui=bold
hi User8 guifg=#ffffff  guibg=#5b7fbb
hi User9 guifg=#ffffff  guibg=#810085
hi User0 guifg=#ffffff  guibg=#094afe
hi CursorIM ctermfg=15

set laststatus=2

function! FormatDocument(mode) 
	if &filetype == 'xml'
		if a:mode == 'visual'
			silent! exe ":'<,'>!xmllint --format -"
		else 
			silent! exe ':%!xmllint --format -'
		endif
		exec 'echom "Formatted XML message"'
	elseif &filetype == 'javascript'
		if a:mode == 'visual'
			silent! exe ":'<,'>!python -m json.tool'"
		else 
			silent! exe ":%!python -m json.tool"
		endif
		exe 'echom "Formatted JSON message"'
	else
		exec 'echom "Supported filetypes: javascript, xml - current is " . &filetype' 
	endif
endfunction
:noremap <C-f> :call FormatDocument('normal')<cr>
:vmap <C-f> :call FormatDocument('visual')<cr>

function! Comment(mode)
	if &filetype == 'xml' 
		if a:mode == 'visual'
			exec ""di<!-- <C-r>" -->
		endif
	endif
endfunction

"" Completion configuration
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"" Terminal mode for nvim
" tnoremap <Esc> <c-\><c-n>
if !exists("g:ycm_semantic_triggers")
	let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']
