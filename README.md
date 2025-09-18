# Neovim Fresh Install Guide for C/C++/Python Development

## Prerequisites

### Install Neovim
```bash
# Ubuntu/Debian
sudo apt install neovim

# Arch Linux
sudo pacman -S neovim

# macOS
brew install neovim
```

### Install Language Servers
```bash
# C/C++ - clangd
sudo apt install clangd-12  # Ubuntu/Debian
sudo pacman -S clang        # Arch Linux
brew install llvm           # macOS

# Python - pyright
npm install -g pyright
```

### Install Dependencies
```bash
# Required tools
sudo apt install git curl nodejs npm ripgrep fd-find  # Ubuntu/Debian
sudo pacman -S git curl nodejs npm ripgrep fd         # Arch Linux
brew install git curl node ripgrep fd                 # macOS
```

## Configuration Setup

### 1. Create Config Directory
```bash
mkdir -p ~/.config/nvim/lua
cd ~/.config/nvim
```

### 2. Create lazy-bootstrap.lua
```bash
cat > lua/lazy-bootstrap.lua << 'EOF'
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
EOF
```

### 3. Create plugins-lazy.lua
```bash
cat > lua/plugins-lazy.lua << 'EOF'
return {
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
  },

  -- nvim-navic for breadcrumbs
  {
    "SmiteshP/nvim-navic",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      highlight = true,
      separator = " > ",
      depth_limit = 5,
    },
  },

  -- Jump to any location with 2 keystrokes
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end },
    },
  },

  -- Enhanced f/F/t/T motions
  {
    "rhysd/clever-f.vim",
    keys = { "f", "F", "t", "T" },
  },

  -- Jump between function arguments, array elements
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = {},
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
    },
  },

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    event = "InsertEnter",
  },

  -- File Explorer
  {
    "preservim/nerdtree",
    cmd = "NERDTree",
    keys = {
      { "<C-n>", "<cmd>NERDTreeToggle<cr>" },
      { "<leader>nf", "<cmd>NERDTreeFind<cr>" },
    },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      ensure_installed = { "c", "cpp", "python", "lua", "bash", "json", "yaml", "vim", "markdown" },
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
          },
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>" },
      { "<leader>gg", "<cmd>Telescope git_files<cr>" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>" },
      { "<leader>fw", "<cmd>Telescope lsp_workspace_symbols<cr>" },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      defaults = {
        layout_config = { horizontal = { prompt_position = "top" } },
      },
    },
  },
}
EOF
```

### 4. Create init.lua
```bash
cat > init.lua << 'EOF'
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
EOF
```

## First Launch

1. Start Neovim: `nvim`
2. Wait for plugins to install automatically
3. Restart Neovim
4. Run `:checkhealth` to verify setup

## Key Bindings

| Key | Action |
|-----|--------|
| `<Space>` | Leader key |
| `<C-n>` | Toggle NERDTree |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Find buffers |
| `<leader>gg` | Git files |
| `<leader>fs` | Find symbols in file |
| `<leader>fw` | Find workspace symbols |
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Hover documentation |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename symbol |
| `s` | Flash jump (2 keystrokes to anywhere) |
| `S` | Flash treesitter jump |
| `]f` / `[f` | Next/prev function |
| `]c` / `[c` | Next/prev class |
| `af` / `if` | Select around/inside function |
| `ac` / `ic` | Select around/inside class |
| `<C-u>` / `<C-d>` | Half-page scroll (centered) |
| `n` / `N` | Search next/prev (centered) |
| `H` / `L` | Jump to line start/end |
| `<C-hjkl>` | Window navigation |
| `<leader>bn/bp/bd` | Buffer next/prev/delete |

## Features

- **LSP**: Full language server support for C/C++/Python
- **Autocompletion**: Intelligent code completion
- **Breadcrumbs**: Navigation context in statusline
- **File Explorer**: NERDTree for file management
- **Fuzzy Finding**: Telescope for quick file/text search
- **Syntax Highlighting**: Treesitter for accurate highlighting
- **No Dimming**: Disabled inactive code dimming
- **Flash Navigation**: Jump anywhere with 2 keystrokes
- **Enhanced Motions**: Improved f/F/t/T with clever-f
- **Code Structure Navigation**: Jump between functions/classes
- **Text Objects**: Enhanced selection with treesitter and mini.ai
- **Centered Scrolling**: Auto-center on navigation
- **Symbol Search**: Find symbols across workspace

## Troubleshooting

- If clangd not found: Install `clang-tools` package
- If pyright not found: Run `npm install -g pyright`
- For compile_commands.json: Use `bear make` or CMake with `CMAKE_EXPORT_COMPILE_COMMANDS=ON`
