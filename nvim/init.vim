" PLUGIN
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'nsf/gocode', { 'tag': 'v.20170907', 'rtp': 'vim' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
Plug 'scrooloose/nerdTree'
Plug 'flazz/vim-colorschemes'
call plug#end()

" BASIC
let mapleader=";"
set completeopt-=preview

" DEOPLETE
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 700
set completeopt+=noinsert
set completeopt+=noselect
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

" GOLANG
let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
if !exists("autocommands_loaded")
  let autocommands_loaded = 1
  autocmd BufWritePost *.go :GoBuild
endif

" MAP
nmap <C-n> :NERDTreeToggle<CR>
nmap <C-p> :FZF!<CR>
nmap <Space> <kDivide>
nmap <leader>b :e#<CR>

inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"


" COLOR
set termguicolors
set background=dark
color gruvbox
