set runtimepath^=~/.vim/bundle/nerdtree
set runtimepath^=~/.vim/bundle/syntastic
set runtimepath^=~/.vim/bundle/vim-buftabline
set runtimepath^=~/.vim/bundle/vim-go
set runtimepath^=~/.vim/bundle/vim-mucomplete

" Ugh.. OSX
" set term=builtin_ansi

" Try out FuzzyFinder
set rtp+=/usr/local/opt/fzf
nnoremap <Leader>, :FZF!<CR>

scriptencoding utf-8
set encoding=utf-8

set cindent
set autoindent
filetype plugin indent on
" let &scrolloff=999-&scrolloff
set tabstop=4
filetype on
set shiftwidth=2
set expandtab
set hlsearch
set incsearch
set modeline
set ruler

syntax on
colorscheme default

set number
let NERDTreeIgnore = ['\.pyc$']

" VIM buftabline Map
set hidden
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

" Buffer destroy
nnoremap <C-Q> :bp<cr>:bd #<cr>

" vim-go
" :GoUpdateBinaries to install deps
let g:go_version_warning = 0
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_doc_popup_window = 1

" Disable annoying ex mode
map Q <Nop>

nnoremap <Leader>s :%s/\<<C-r><C-w>\>
nnoremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>
nnoremap <Leader>a :Ack <C-r><C-w>
nnoremap <Leader>. :NERDTreeToggle<CR>

" vim-mucomplete
set completeopt+=menuone
set shortmess+=c   " Shut off completion messages
set belloff+=ctrlg " If Vim beeps during completion
" let g:mucomplete#enable_auto_at_startup = 1

" Some custom colors
hi Comment ctermfg=2
hi StatusLineNC ctermfg=7 ctermbg=0 cterm=underline
hi StatusLine ctermfg=7 ctermbg=0 cterm=undercurl,bold
hi VertSplit ctermfg=7 ctermbg=0 cterm=NONE

" Better highlight for trailing spaces
" but add exclusions for sucky Golang
hi ExtraWhitespace ctermfg=white
match ExtraWhitespace /\s\+$\|\t/

let blacklist = ['go']
au InsertEnter * if index(blacklist, &ft) < 0 | match ExtraWhitespace /$^/ | endif
au InsertLeave * if index(blacklist, &ft) < 0 | match ExtraWhitespace /\s\+$\|\t/ | endif
au BufWinEnter * if index(blacklist, &ft) < 0 | match ExtraWhitespace /\s\+$\|\t/ | endif
au BufWinLeave * call clearmatches()

au BufWinEnter * if index(blacklist, &ft) < 0 | setlocal listchars=tab:>-,trail:·,nbsp:␣ | endif
set list

" Golang sucks
au FileType go setlocal noexpandtab
au FileType go setlocal shiftwidth=4
au FileType go setlocal softtabstop=4
au FileType go setlocal tabstop=4
au FileType go setlocal listchars=tab:»\ ,trail:·,space:\ ,nbsp:␣
au FileType go setlocal fileformat=unix

" Common Go commands - vim-go
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage-toggle)
au FileType go nmap <Leader>e <Plug>(go-rename)
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>ae <Plug>(go-alternate-edit)
au FileType go nmap <Leader>av <Plug>(go-alternate-vertical)

" Python3 support for syntastic
let g:syntastic_python_python_exec = 'python3'

let g:go_fmt_options = {
\ 'goimports': '-local github.com/DataDog/datadog-agent',
\ }

function Py2()
  let g:syntastic_python_python_exec = 'python'
endfunction
