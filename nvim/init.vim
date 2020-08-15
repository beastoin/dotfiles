" PLUGIN
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'nsf/gocode', { 'tag': 'v.20170907', 'rtp': 'vim' }
Plug 'scrooloose/nerdTree'
Plug 'sainnhe/gruvbox-material'
Plug 'morhetz/gruvbox'
Plug 'dart-lang/dart-vim-plugin'
Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" BASIC
let mapleader=";"
set completeopt-=preview
set autowrite
" set number

" GOLANG
let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_def_mode = "godef"
"let g:go_def_mode = "gopls"
if !exists("autocommands_loaded")
  let autocommands_loaded = 1
  autocmd BufWritePost *.go :GoBuild
endif

" COMMAND
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--color-path="0;33"', <bang>0)

" MAP
nmap <C-n> :NERDTreeToggle<CR>
nmap <C-p> :FZF!<CR>
nmap <Space> <kDivide>
nmap <leader>w <C-w>w
nmap <leader>t gt
nmap <leader>t :vs<CR><C-w>w:terminal<CR>i
nmap <silent> <leader>m :History<CR>
nmap <leader>f :Ag<CR>

inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
noremap <silent> <leader>s :call go#lsp#Exit()<cr>

tnoremap <leader>q <C-\><C-n>:q!<CR>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" COLOR
set termguicolors
set background=dark
color gruvbox-material
" color gruvbox
