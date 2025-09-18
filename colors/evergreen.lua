-- EVERGREEN
-- created on https://nvimcolors.com

-- Clear existing highlights and reset syntax
vim.cmd('highlight clear')
vim.cmd('syntax reset')

-- Basic UI elements
vim.cmd('highlight Normal guibg=#304b50 guifg=#d6dbdc')
vim.cmd('highlight NonText guibg=#304b50 guifg=#304b50')
vim.cmd('highlight CursorLine guibg=#415a5e')
vim.cmd('highlight LineNr guifg=#839396')
vim.cmd('highlight CursorLineNr guifg=#d6dbdc')
vim.cmd('highlight SignColumn guibg=#304b50')
vim.cmd('highlight StatusLine gui=bold guibg=#d6dbdc guifg=#304b50')
vim.cmd('highlight StatusLineNC gui=bold guibg=#d6dbdc guifg=#839396')
vim.cmd('highlight Directory guifg=#2ee5b1')
vim.cmd('highlight Visual guibg=#62777a')
vim.cmd('highlight Search guibg=#849497 guifg=#d8dcdd')
vim.cmd('highlight CurSearch guibg=#a4e2ff guifg=#304b50')
vim.cmd('highlight IncSearch gui=None guibg=#a4e2ff guifg=#304b50')
vim.cmd('highlight MatchParen guibg=#849497 guifg=#d8dcdd')
vim.cmd('highlight Pmenu guibg=#263c40 guifg=#d8dcdd')
vim.cmd('highlight PmenuSel guibg=#1e3033 guifg=#30efb6')
vim.cmd('highlight PmenuSbar guibg=#7f9093 guifg=#d8dcdd')
vim.cmd('highlight VertSplit guifg=#d6dbdc')
vim.cmd('highlight MoreMsg guifg=#ffffff')
vim.cmd('highlight Question guifg=#ffffff')
vim.cmd('highlight Title guifg=#2bdcab')

-- Syntax highlighting
vim.cmd('highlight Comment guifg=#849497 gui=italic')
vim.cmd('highlight Constant guifg=#fc9f9b')
vim.cmd('highlight Identifier guifg=#2bdcab')
vim.cmd('highlight Statement guifg=#a2dffd')
vim.cmd('highlight PreProc guifg=#a2dffd')
vim.cmd('highlight Type guifg=#ffffff gui=None')
vim.cmd('highlight Special guifg=#ffffff')

-- Refined syntax highlighting
vim.cmd('highlight String guifg=#fc9f9b')
vim.cmd('highlight Number guifg=#42ff4f')
vim.cmd('highlight Boolean guifg=#fc9f9b')
vim.cmd('highlight Function guifg=#2bdcab')
vim.cmd('highlight Keyword guifg=#a2dffd gui=italic')

-- Html syntax highlighting
vim.cmd('highlight Tag guifg=#2bdcab')
vim.cmd('highlight @tag.delimiter guifg=#ffffff')
vim.cmd('highlight @tag.attribute guifg=#2bdcab')

-- Messages
vim.cmd('highlight ErrorMsg guifg=#ff5c5c')
vim.cmd('highlight Error guifg=#ff5c5c')
vim.cmd('highlight DiagnosticError guifg=#ff5c5c')
vim.cmd('highlight DiagnosticVirtualTextError guibg=#454d51 guifg=#ff5c5c')
vim.cmd('highlight WarningMsg guifg=#e2ce3c')
vim.cmd('highlight DiagnosticWarn guifg=#e2ce3c')
vim.cmd('highlight DiagnosticVirtualTextWarn guibg=#42584e guifg=#e2ce3c')
vim.cmd('highlight DiagnosticInfo guifg=#57c7ff')
vim.cmd('highlight DiagnosticVirtualTextInfo guibg=#345762 guifg=#57c7ff')
vim.cmd('highlight DiagnosticHint guifg=#00ffff')
vim.cmd('highlight DiagnosticVirtualTextHint guibg=#2b5d62 guifg=#00ffff')
vim.cmd('highlight DiagnosticOk guifg=#19e624')

-- Common plugins
vim.cmd('highlight CopilotSuggestion guifg=#849497') -- Copilot suggestion
vim.cmd('highlight TelescopeSelection guibg=#62777a') -- Telescope selection
