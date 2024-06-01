local nvim_lsp = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attach = function(_, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	--Enable completion triggered by <c-x><c-o>
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap = true, silent = true }
	buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', '<leader>dd', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.goto_next({float = true,})<CR>', opts)
	buf_set_keymap('n', '<leader>de', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
	buf_set_keymap("n", "<leader>df", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_set_keymap('n', '<leader>aw', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	buf_set_keymap("n", "<leader>af", "<cmd>lua vim.lsp.buf.format()<CR>", opts) -- format
	buf_set_keymap("n", "<leader>ar", "<cmd>LspRestart<CR>", opts)            -- restart lsp
end

-- Setup
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {
	"vimls",
	"lua_ls",
	"bashls",
	"gopls",
	"dartls",
	"tsserver",
	"html",
	"kotlin_language_server",
	"sourcekit",
	"jsonls",
}
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup {
		on_attach = on_attach,
		capabilities = capabilities,
	}
end

-- Diagnostic
vim.diagnostic.config({
	underline = false,
	virtual_text = {
		spacing = 4,
		prefix = '',
		format = function(diagnostic)
			if diagnostic.severity == vim.diagnostic.severity.ERROR then
				return string.format("👻", diagnostic.message)
			end
			if diagnostic.severity == vim.diagnostic.severity.WARN then
				return string.format("😬", diagnostic.message)
			end
			if diagnostic.severity == vim.diagnostic.severity.INFO then
				return string.format("🧐", diagnostic.message)
			end
			if diagnostic.severity == vim.diagnostic.severity.HINT then
				return string.format("🤩", diagnostic.message)
			end
			return "🙃"
		end,
	},
	float = false,
	signs = false,
	update_in_insert = false,
	severity_sort = true,
})

-- Autocomplete
local cmp = require 'cmp'
cmp.setup({
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
	}, {
		{ name = 'buffer' },
	})
})
