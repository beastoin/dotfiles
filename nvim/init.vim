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
Plug 'hsanson/vim-android'
call plug#end()

" BASIC
let mapleader=";"
set completeopt-=preview
set autowrite
set ignorecase
set smartcase
set timeoutlen=160
set mmp=5000
set guicursor=i:block

" deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('auto_complete_delay', 500)
call deoplete#custom#source('_', 'smart_case', v:true)

let g:gradle_path = $GRADLE_HOME

" Tree sitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  },
}
EOF

" LSP
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>df', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>db', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<leader>d', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>aw', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap("n", "<leader>af", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "dartls", "tsserver"}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 500,
    }
  }
end

--Golang
nvim_lsp.gopls.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
      gopls = {
	allowModfileModifications = true,
      },
    },
}

EOF

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

let g:gruvbox_contrast_dark = 'soft'
color gruvbox
set background=dark
set termguicolors
