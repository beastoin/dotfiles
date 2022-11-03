" PLUGIN
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdTree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'shougo/deoplete-lsp'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
call plug#end()

" BASIC
let mapleader=";"
set completeopt-=preview
set autowrite
set ignorecase
set smartcase
set timeoutlen=320
set mmp=5000
set guicursor=i:block

" deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('auto_complete_delay', 512)
call deoplete#custom#source('_', 'smart_case', v:true)

let g:gradle_path = $GRADLE_HOME

lua require("lsp_config")

lua require("treesitter_config")

" FZF
let g:fzf_layout = { 'down': '100%'}

" COMMAND
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--hidden --ignore .git --smart-case --color-path="0;33"', {'options': '--delimiter : --nth 4..'}, <bang>0)
command! -bang -nargs=* FZFAg call fzf#run(fzf#wrap({'source': 'ag --hidden --ignore .git --smart-case -g ""'}))

" AUTO-COMMAND
autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
autocmd BufWritePre *.css lua vim.lsp.buf.formatting()
autocmd BufWritePre *.js lua vim.lsp.buf.formatting()
autocmd BufWritePre *.dart lua vim.lsp.buf.formatting()
autocmd BufWritePre *.swift lua vim.lsp.buf.formatting()

" MAP
nmap <C-n> :NERDTreeToggle<CR>
nmap <C-p> :FZFAg!<CR>
nmap <Space> <kDivide>
nmap <leader>w <C-w>w
nmap <leader>t :vs<CR><C-w>w:terminal<CR>i
nmap <silent> <leader>m :History<CR>
nmap <leader>f :Ag<CR>
nmap <silent> <Space><Space> :noh<CR>
nmap <leader>d :LSClientEnable<CR>:lopen<CR>
nmap <leader>dd :LSClientDisable<CR>:lclose<CR>
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
tnoremap <leader>q <C-\><C-n>:q!<CR>

let g:gruvbox_contrast_dark = 'soft'
color gruvbox
set background=dark
set termguicolors
