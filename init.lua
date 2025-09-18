-- Bootstrap lazy.nvim
require("lazy-bootstrap")

vim.g.mapleader = " "

-- Basic settings
vim.o.number = true
vim.o.relativenumber = false
vim.o.expandtab = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.smartindent = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.wrap = true
vim.opt.termguicolors = true
vim.opt.tags = { './tags', 'tags' }
vim.opt.clipboard = 'unnamedplus'

-- Setup lazy.nvim
require("lazy").setup("plugins-lazy")

-- LSP configuration with nvim-navic
local navic = require("nvim-navic")

-- Clangd setup
vim.lsp.config.clangd = {
  cmd = {
    "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu",
    "--completion-style=detailed", "--function-arg-placeholders", "--fallback-style=llvm",
  },
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  on_attach = function(client, bufnr)
    client.server_capabilities.semanticTokensProvider = nil
    if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, bufnr)
    end
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
  end
}

-- Pyright setup
vim.lsp.config.pyright = {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, bufnr)
    end
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
  end,
}

-- nvim-cmp setup
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
})

-- Statusline with navic
vim.o.statusline = "%f %m %= %{%v:lua.require'nvim-navic'.get_location()%} %l:%c"

-- Key mappings
vim.keymap.set('n', '<leader>no', ':tabnew | NERDTree<CR>')

-- Enhanced navigation
vim.keymap.set('n', '<C-u>', '<C-u>zz')  -- Center after half-page up
vim.keymap.set('n', '<C-d>', '<C-d>zz')  -- Center after half-page down
vim.keymap.set('n', 'n', 'nzzzv')        -- Center after search next
vim.keymap.set('n', 'N', 'Nzzzv')        -- Center after search prev
vim.keymap.set('n', '*', '*zzzv')        -- Center after search word
vim.keymap.set('n', '#', '#zzzv')        -- Center after search word back

-- Quick buffer navigation
vim.keymap.set('n', '<leader>bn', ':bnext<CR>')
vim.keymap.set('n', '<leader>bp', ':bprev<CR>')
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>')

-- Jump to start/end of line
vim.keymap.set({'n', 'v'}, 'H', '^')
vim.keymap.set({'n', 'v'}, 'L', '$')

-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

vim.cmd.colorscheme("robot")
