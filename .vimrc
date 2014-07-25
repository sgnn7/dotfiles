set cindent
set smartindent
set autoindent
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
" let NERDTreeIgnore = ['\.pyc$']
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

hi Comment ctermfg=2

if !empty(matchstr($MY_RUBY_HOME, 'jruby'))
  let g:ruby_path = join(split(glob($MY_RUBY_HOME.'/lib/ruby/*.*')."\n".glob($MY_RUBY_HOME.'/lib/rubysite_ruby/*'),"\n"),',')
endif
