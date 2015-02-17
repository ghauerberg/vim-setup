" Init pathogen and plugins
execute pathogen#infect()
set number
set ttimeoutlen=50
set autoindent
set cindent
" Key mappings
" imap <Nul> <Space>
let mapleader=","
nmap <F3> :FufFile
nmap <F10> :make clean
nmap <F9> :make all

" Commenting line
let @e='0i//j'
let @r='0xxj'
nnoremap <leader>c @e
nnoremap <leader>x @r

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
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_use_ultisnips_completer = 1
let g:ycm_key_list_select_completion=['<C-j>', '<Down>']
let g:ycm_key_list_previous_completion=['<C-k>', '<Up>'] 
let g:ycm_key_invoke_completion = '<S-Tab>'
let g:ycm_key_detailed_diagnostics = '<leader>d'

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
