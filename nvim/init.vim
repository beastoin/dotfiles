" PLUGIN
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate', 'tag': '0.9.2'}
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
call plug#end()

" LSP
lua require("lsp_config")

" FORMATER
lua require("treesitter_config")

" BASIC
let mapleader=";"
set completeopt-=preview
set autowrite
set ignorecase
set smartcase
set timeoutlen=320
set mmp=5000
set guicursor=i:block
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

" https://stackoverflow.com/a/1878983/10281177
set tabstop=4
set shiftwidth=4
set softtabstop=0 noexpandtab

let g:gradle_path = $GRADLE_HOME

" FZF
let g:fzf_layout = { 'down': '100%'}

" COMMAND
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--hidden --ignore .git --smart-case --color-path="0;33"', {'options': '--delimiter : --nth 4..'}, <bang>0)
command! -bang -nargs=* FZFAg call fzf#run(fzf#wrap({'source': 'ag --hidden --ignore .git --smart-case -g ""'}))

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
vnoremap <leader>y "+y
nnoremap <leader>p "+p

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

"hard, medium, soft
let g:gruvbox_contrast_dark = 'medium'
color gruvbox
set background=dark
set termguicolors
