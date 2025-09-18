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

-- Common on_attach function
local function on_attach(client, bufnr)
  if client.server_capabilities.semanticTokensProvider then
    client.server_capabilities.semanticTokensProvider = nil
  end
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end

  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', 'gR', '<cmd>Telescope lsp_references<cr>', opts)  -- Workspace references
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
end

-- Auto-start LSP servers
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "objc", "objcpp", "cuda" },
  callback = function()
    vim.lsp.start({
      name = "clangd",
      cmd = {
        "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu",
        "--completion-style=detailed", "--function-arg-placeholders", "--fallback-style=llvm",
        "--cross-file-rename", "--all-scopes-completion",
      },
      root_dir = vim.fs.dirname(vim.fs.find({'compile_commands.json', '.git', 'Makefile', 'CMakeLists.txt'}, { upward = true })[1]),
      capabilities = require('cmp_nvim_lsp').default_capabilities(),
      on_attach = on_attach,
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    vim.lsp.start({
      name = "pyright",
      cmd = { "pyright-langserver", "--stdio" },
      root_dir = vim.fs.dirname(vim.fs.find({'.git', 'pyproject.toml', 'setup.py'}, { upward = true })[1]),
      capabilities = require('cmp_nvim_lsp').default_capabilities(),
      on_attach = on_attach,
    })
  end,
})

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
