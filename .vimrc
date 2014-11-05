set cindent
set autoindent
filetype plugin indent on
" let &scrolloff=999-&scrolloff
set tabstop=4
filetype on
set shiftwidth=4
set expandtab
set hlsearch
set incsearch
set modeline

" syntax on
colorscheme default

set listchars=tab:>-,trail:·
set list

set number
let NERDTreeIgnore = ['\.pyc$']
" map <F3> :FufRenewCache<CR>

map <F4> :FufCoverageFile<CR>
map <F6> :only<CR>
map <F7> <C-w>^
map <F12> :NERDTreeToggle<CR>

" Disable annoying ex mode
map Q <Nop>

nnoremap <Leader>s :%s/\<<C-r><C-w>\>
nnoremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>
nnoremap <Leader>a :Ack <C-r><C-w>

" Some custom colors
hi Comment ctermfg=2
hi StatusLineNC ctermfg=7 ctermbg=0 cterm=underline
hi StatusLine ctermfg=7 ctermbg=0 cterm=undercurl,bold
hi VertSplit ctermfg=7 ctermbg=0 cterm=NONE

" Better highlight for trailing spaces
hi ExtraWhitespace ctermfg=white
match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /$^/
au InsertLeave * match ExtraWhitespace /\s\+$/
au BufWinEnter * match ExtraWhitespace /\s\+$/
au BufWinLeave * call clearmatches()

if !empty(matchstr($MY_RUBY_HOME, 'jruby'))
  let g:ruby_path = join(split(glob($MY_RUBY_HOME.'/lib/ruby/*.*')."\n".glob($MY_RUBY_HOME.'/lib/rubysite_ruby/*'),"\n"),',')
endif
